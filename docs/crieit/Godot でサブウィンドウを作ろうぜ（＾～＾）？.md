# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__08-1349-Windows-o2o0.png](https://crieit.now.sh/upload_images/6e36f8727b498ea5e35420df34fa34506522362159cce.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ウィンドウが　増えてきそうなので、  
ツリー階層を　再編したいというところだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　とりあえず　既存の分は　やってしまえば？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
（カタ　カタ　カタ　カタ）  

![202310__godot__08-1429-WindowsRestructure-o2o0.png](https://crieit.now.sh/upload_images/48ea5e7cc40fde214fdf5d29506b157865223e69917ac.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ひとまず　既存の分を移動したぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　どっちも　ウィンドウなのだから　スクリプトは共通化できるはずなのよ。  
`メッセージ`　と　`センター`　のスクリプトは何が違うの？」  

📄　`Director/Windows/メッセージ`:  

```gd
#	メッセージ・ウィンドウ（Message Window）
extends Node2D


#	状態遷移機械
var statemachine = load("scripts/MessageWindowStatemachine.gd").new()


#	メッセージ・ウィンドウを閉じる
func initialize():
	$"TextBlock".initialize()
	self.statemachine.all_page_flushed()


#	ウィンドウを空っぽにして、次の指示を待ちます
func clear_and_awaiting_order():
	print("［メッセージ・ウィンドウ］　ウィンドウを空っぽにして、次の指示を待ちます")
	$"TextBlock".text = ""

	#	メッセージウィンドウは指示待ちだ
	$"../../AssistantDirector".is_message_window_waiting_for_order = true


#	先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	#	最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1, text.length() - (index+1))
	# print("［メッセージ・ウィンドウ］　head：　[" + head + "]")
	# print("［メッセージ・ウィンドウ］　tail：　[" + tail + "]")
	return [head, tail]


#	メッセージを追加
func push_message(text):
	# print("［メッセージ・ウィンドウ］　台詞追加")
	print("［メッセージ・ウィンドウ］　台詞：　[" + text + "]")
	$"TextBlock".push_message(text)

	#	表示
	self.visible = true

	#	タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()


#	選択肢を追加
func push_choices(row_numbers, text):
	print("［メッセージ・ウィンドウ］　選択肢：　[" + text + "]")
	$"TextBlock".push_choices(row_numbers, text)

	#	表示
	self.visible = true

	#	タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()
	


#	ページ送り
func on_page_forward():
	#	効果音
	$"../../Musician".playSe("ページめくり音")
	
	#	ブリンカーを消す
	$"TextBlock".clear_blinker()

	#	ウィンドウを空っぽにして、次の指示を待ちます
	self.clear_and_awaiting_order()


#	下位ノードで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected():
	#	カーソル音
	$"../../Musician".playSe("選択肢確定音")
	
	var row_number = $"TextBlock/ChoiceCursor".selected_row_number	
	print("［メッセージ・ウィンドウ］　選んだ選択肢行番号：" + str(row_number))

	#	選択肢の行番号を、上位ノードへエスカレーションします
	$"../../AssistantDirector".on_choice_selected(row_number)


#	サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# ステートマシーンを、子にも参照させる
	$"Background".statemachine = self.statemachine
	$"TextBlock".statemachine = self.statemachine
	$"TextBlock/BlinkerTriangle".statemachine = self.statemachine
	$"TextBlock/BlinkerUnderscore".statemachine = self.statemachine
	$"TextBlock/ChoiceCursor".statemachine = self.statemachine

	#	ウィンドウを空っぽにする
	$"TextBlock".text = ""


#	テキストボックスなどにフォーカスが無いときの入力を拾う
func _unhandled_key_input(event):
	
	#	完全表示中
	if self.statemachine.is_completed():

		#	選択肢モードなら
		if $"TextBlock".is_choice_mode:
			
			#	何かキーを押したとき
			if event.is_pressed():
				
				#	確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					# print("［メッセージ・ウィンドウ］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
					
				else:
					#	選択肢を確定した
					self.on_choice_selected()
					return
		
		#	それ以外なら
		else:
		
			#	何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					# print("［メッセージ・ウィンドウ］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
				
				#	ページ送り
				self.on_page_forward()
```

📄　`Director/Windows/センター`:  

```gd
#	センター・ウィンドウ（Center Window；中央窓）
extends Node2D


#	現在表示中のセンターウィンドウ画像のノード名
var current_name = null


#	ウィンドウを表示する
func show_window(name):
	print("［センター・ウィンドウ］　表示：[" + name + "]")
	
	#	既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_name != null:
		self.get_node(self.current_name).hide()
	
	self.current_name = name
	self.show()
	self.get_node(self.current_name).show()
	$"System".show()
	$"System/Frame".show()


#	ウィンドウを非表示にする
func hide_window():
	if self.current_name == null:
		return

	print("［センター・ウィンドウ］　非表示：[" + str(self.current_name) + "]")
	self.get_node(self.current_name).hide()	
	$"System/Frame".hide()
	self.current_name = null
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　そら、メッセージ・ウィンドウには  
メッセージ表示をコントロールするスクリプトが書いてるよな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そういえば　メッセージ・ウィンドウの背景は　半透明の黒で、  
センター・ウィンドウの背景は　画像　という違いもあるぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　半透明の黒も　窓から切り離して　背景画像という扱いにしたらいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　メッセージ・ウィンドウ用の画像と、センター・ウィンドウ用の画像は　縦横のサイズが違う」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　画像ファイルは、サイズ別のフォルダーに入れることにしましょう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　直交性を考えると　ウィンドウ名別のフォルダーにした方が　記述が簡潔になるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Godot のツリー構造と、ファイルシステムのツリー構造に　依存性があると不利だぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あっ　そうか～」  

.