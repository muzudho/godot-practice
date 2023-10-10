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

![202310__godot__08-1450-ImageFolderRestructure-o2o0.png](https://crieit.now.sh/upload_images/dacb939b7b185ea252519675012a0234652247c08bcf9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ひとまず　サイズ別のフォルダーを採用だぜ」  

## 静的なウィンドウ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームプログラムの観点から言うと　自由自在なウィンドウが欲しいような  
設計の固まってない状態が　いつまでも続いて　進捗が進んでたら　良くないぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　それはそうだが……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　試しに　ゲームを終了するための　システム・メニューを設計してみればいいんじゃない？」  

![202310__godot__08-1532-Schetch-o2o0.png](https://crieit.now.sh/upload_images/fbf2790ae772628dc66d62bc6b614e5e65224fab7add1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　グリッドに合わさないと　サイズ感は　分からないものだ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そんな小さなウィンドウでは　英語が入らないだろう。  
ローカライズして大丈夫か？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　間に合わないんで　ローカライズで」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　半透明の黒い所は　ＲＧＢＡが　32, 32, 32, 192　か。　192 は、百分率の 75% でもいいことにしよう」  

![202310__godot__08-1546--SystemMenu.png](https://crieit.now.sh/upload_images/b0b94a959b4c1e002f961e2c9123d63065225538cdaa0.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　位置も　サイズも　色も　素材を作る手間がかからないように妥協したぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　画面上に置いてみましょう」  

## 名前を変更

![202310__godot__08-1633-CenterMessageWindow.png](https://crieit.now.sh/upload_images/499105cd0666650490d7eaba5525579365225b5a23727.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　分かった。名前が悪いんだ。名前を変えよう。  
こいつは　システム・ウィンドウ　ではなくて、  
**中央メッセージ・ウィンドウ**　だぜ」  

![202310__godot__08-1635-BottomMessageWindow.png](https://crieit.now.sh/upload_images/5a7dac3bf1902219aa7cd8de87921f9765225bf0cb426.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こいつは　**下メッセージ・ウィンドウ**　だぜ」  

![202310__godot__08-1646-CenterViewingWindow.png](https://crieit.now.sh/upload_images/a116fef9722b7b5c736bc5aeac6e6c5565225e80b5997.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こいつは　**中央ビューイング・ウィンドウ**　だぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　別物と割り切ったわけだな　実践的だぜ」  

![202310__godot__08-1659-Msg-o2o0.png](https://crieit.now.sh/upload_images/fe45beebc8776503cf54d52917f31b34652262102a0aa.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　どのメッセージ・ウィンドウを使うか指定できるようにしようぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　状態を持っていいいの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そこは　ごめんなさい　しようぜ？」  

## 位置合わせ

![202310__godot__08-1725-Center-o2o0.png](https://crieit.now.sh/upload_images/b1f6b32e51fca68ab4250d4cd5cbe599652267a38d355.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　テキストの表示位置をどうするか。　Godot の思想だと　コピー貼り付けして　座標変えて……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　コピー貼り付けするしか　ないんじゃない？　動的にやったら　レイアウトの機能の利便性を損なうんだし」  

![202310__godot__08-1955-Copy-o2o0.png](https://crieit.now.sh/upload_images/f2e7b8be72a714ce4264e639ba0dabe965228ac5bd523.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　同じものが　コピーされて　ＤＲＹの法則が破れているように見えるが、  
座標位置を覚えておくデータだから　残しておいた方が　エディターが活きるのか～」  

![202310__godot__08-2207--CenterMessageWindow.png](https://crieit.now.sh/upload_images/320be789987f88a7396e99f3a1fbb72e6522a9bf8189f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　文字数を調整しないと  
ＣＳＳチョットワカル　みたいになるんだな」  

# 進行

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームの進行を止めて、システム・メニューを出すんだっけ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そうだぜ」  

```plaintext
　　📂 Director
  　　├── 📂 Main
  　　└── 📂 SystemMenu
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　大きく２つに分かれないかだぜ？」  

```plaintext
　　📂 Director
  　　├── 📂 Main
  　　├── 📂 SystemMenu
👉　　└── 📂 Musician
```

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　ミュージシャンは　別れなくてよくない？」  

```plaintext
　　📂 Director
👉　└── 📂 ScenarioBook
　　  　　├── Main
  　　　　└── SystemMenu
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　分かれるのは　シナリオブックだ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　大改造すると　時間が無くなってしまうから、今回は　分けずに行こうぜ？」  

# エスケープ・キー

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　エスケープ・キーを押したら　メニューが出るようにするにしても、  
メッセージ・ウィンドウが出てないときにも　メニューは出したいから、  
キー・イベントを取得するのは　メッセージ・ウィンドウより　上位のノードだよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ルートで　キー判定すりゃ　よくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　メッセージ・ウィンドウが出てるときは　キーが反応しないな。  
`func _unhandled_key_input(event):` を２か所で使うとか　よくないのか？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ルートで全部取って、必要なら　子ノードに配るようにしたらどうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それもまた　大改造だな……」   

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　子ノードが先に  `_unhandled_key_input()` をキャッチするのか？  
後ろ向き探索？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　いや、会話イベント中に　エスケープ・キー　を押して　システム・メニューを出そうなんてのが  
間違いなんだぜ」  

# 会話じゃないシーン

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　しかし　現在の設計では　会話シーンしかない。  
マップの上を移動するような　シーンや、　アドベンチャーのようなメニューの並んだシーンがない」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　会話が途切れることなく連続しちゃ　ダメ　なんだ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　マップ画面を挟んだらいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　１～２時間かけて、１枚　絵を追加するか～」  

📖　[ツイート](https://x.com/muzudho1/status/727284379295207425?s=20)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こういうマップだろ」  

# Z-index のルール分からん

![202310__godot__09-0001--ZIndex.png](https://crieit.now.sh/upload_images/057f3c888d4c86157e6f9bccf9bd84246522c49f288ed.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Z-index で前景、後景の調整ができない……　分けわからん……」  

# 導線を中断するのが　難しい

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　サブ・ウィンドウが　どうのこうのより  
メインで　ゲームが進行していて　それを　停止させるのが難しい」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`_process()`　で動かしてるんだから　嚙み合わせを外したらいいじゃない」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それを１個１個　仕込んでいくのが大変だ。　いったん休憩するぜ」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# 📅 (2023-10-10 tue) 再開

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　エスケープ・キーを押したら　一時停止する機能は実装してきたぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　ついでに　現在表示しているメッセージ・ウィンドウも非表示にしてくれだぜ」  

```gd
#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［チョイス・カーソル］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in self.get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じのメソッドを　ノードに持たせていくかだぜ」  

![202310__godot__10-2243--ElaseWindow.png](https://crieit.now.sh/upload_images/1792fd6fef152781225792a8aeeff1d8652555429b1c4.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　背景を残して、それ以外を非表示にしたぜ」  

## 中央メッセージ・ウィンドウを表示してくれだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　続けて　中央メッセージ・ウィンドウを表示してくれだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　前に `cwnd` って命令を作ってたよな。あれを `v-wnd` に名前を変えようかな」  

![202310__godot__10-2320--ViewingWindow.png](https://crieit.now.sh/upload_images/b41f755f324be679a46c649ad0c5f74865255dd17107b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あっ、これは　ビューイング・ウィンドウだ。間違えた」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　前に `msg` って命令を作ってたよな。あれを `m-wnd` に名前を変えようぜ？」  

![202310__godot__10-2338--CenterMessageWindow.png](https://crieit.now.sh/upload_images/51a1a746aa2f8898769d86bea1640fa265256225aea3b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こうだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　そこに　選択肢を表示してくれだぜ。　再開と　続行でいいかな」  

.