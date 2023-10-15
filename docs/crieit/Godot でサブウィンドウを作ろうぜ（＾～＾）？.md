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

![202310__godot__10-2355--Choice.png](https://crieit.now.sh/upload_images/644f88be50b6e0f152a5367ca49d38ce6525661ae4648.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　枠のサイズが　なんか余ったな」  

## 復帰処理

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　そこで　エスケープ・キーを押したら　元の状態に戻してくれだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　元の状態を保存してないから　難しいなあ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　何を消したか　覚えておくしかなくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それか、何も消さず　背景の後ろに隠しておくかだな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Godot での `z-index` の処理は　分けが分からないのではなかったか？」  

# 📅 (2023-10-11 wed) 再開

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Visual Novel パートと System Menu パートを分けるべきか、  
パートという呼称は　適切か？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　コンポーネントなんじゃないの？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　班なら　グループ（Group）だが」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームは　どれだけの画面で構成される？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　画面なら　スクリーン（Screen）とか　シーン（Scene）かな」

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`Scene` は Godot に用語を取られたから使いたくない」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　セッションでどう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ビジュアル・ノベル・セッション、　バトル・セッション、　メニュー・セッション……、  
良い案だぜ　今んとこ候補」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　セパレーション（Separation；離別）は　どうだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　意味は適切だが」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　用語として　他の単語と絡みにくいのよね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ビジュアル・ノベル・セパレーション、　バトル・セパレーション、　メニュー・セパレーション……、  
おかしいか。どうすれば？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　デパートメント（Department；部）で　いいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それだぜ！  
ビジュアル・ノベル・デパートメント、　バトル・デパートメント、　システム・メニュー・デパートメント、  
これで行こう」  

## ビジュアル・ノベル・デパートメント

![202310__godot__11-2022--VisualNovelDepartment-o2o0.png](https://crieit.now.sh/upload_images/090f9c7aa2ca6206b751cd8f9b06551e652685a853463.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　シナリオを書くというのは、  
`VisualNovelDepartment` のスナップショットを変更することだと、  
そういう概念にしてしまおう」  

![202310__godot__11-2102--VisualNovelDepartment-o2o0.png](https://crieit.now.sh/upload_images/182126091be3bef4a6aae6db55fa2d4d65268ef701a32.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　スナップショットではない　ビジュアル・ノベル部　も作っておこう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ファイル名を間違えそうだ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ロケーションの名前も　デパートメント毎に覚えておく必要があるか」  

## タイプライターで表示途中の文

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　タイプライターで表示途中の文も　覚えておけだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　なんで　こんなに難しいのだろう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　スナップショットは　グローバル変数のように　変数を持っておきたくて、  
オブジェクト指向のカプセル化とは　反するんだが、  
データを１か所で管理したいときは　オブジェクト指向じゃない方がいいんだ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　テキストブロックが　タイプライター表示をしていて  
文字列を切り分けたりしているが、この機能は　デパートメント　の方に持たせたい」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　また　次の日ねえ」  

# 📅 (2023-10-12 thu 20:12) 再開

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　テキストブロックを見るか」  

```gd
# メッセージを追加
func push_message(new_text):
	# print("［テキストブロック］　台詞追加")
	print("［テキストブロック］　台詞：　[" + new_text + "]")
	self.get_snapshot("VisualNovelDepartment").is_choice_mode = false
	self.get_snapshot("VisualNovelDepartment").choice_row_numbers = []
	self.get_snapshot("VisualNovelDepartment").text_block_buffer = new_text

	# 空欄化
	self.emptize()


# 選択肢を追加
func push_choices(row_numbers, new_text):
	print("［テキストブロック］　選択肢：　[" + new_text + "]")
	self.get_snapshot("VisualNovelDepartment").choice_row_numbers = row_numbers
	self.get_snapshot("VisualNovelDepartment").text_block_buffer = new_text
	self.get_snapshot("VisualNovelDepartment").is_choice_mode = true

	# 空欄化
	self.emptize()

	# さらに、ブリンカーは無いことにする
	$"BlinkerTriangle".initialize()
	$"BlinkerUnderscore".initialize()
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　通常のメッセージと、選択肢でメソッドが分かれているの、  
改造の邪魔なんで　１本化したいぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　前処理として `.setup_normal_mode()` と、 `.setup_choices_mode()` を作ったら？」  

```gd
# メッセージを追加
func push_message(new_text, choice_row_numbers = null):

	#	テキスト設定
	self.get_snapshot("VisualNovelDepartment").text_block_buffer = new_text

	#	空欄化
	self.emptize()

	#	選択肢なら
	if choice_row_numbers != null:
		print("［テキストブロック］　選択肢：　[" + new_text + "]")
		self.get_snapshot("VisualNovelDepartment").is_choice_mode = true
		self.get_snapshot("VisualNovelDepartment").choice_row_numbers = choice_row_numbers

		# メッセージエンド・ブリンカーは無いことにする
		$"BlinkerTriangle".initialize()
		$"BlinkerUnderscore".initialize()

	#	それ以外なら
	else:
		print("［テキストブロック］　台詞：　[" + new_text + "]")
		self.get_snapshot("VisualNovelDepartment").is_choice_mode = false
		self.get_snapshot("VisualNovelDepartment").choice_row_numbers = []
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　関数を増やしたくないんで　１本化するぜ」  

## 元の状態に復元するのが難しい

![202310__godot__12-2241--RestoreToFailed.png](https://crieit.now.sh/upload_images/416acb184eb5e46e1066d8a21bd587636527f7b5bf9ff.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　難しい！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　しかし　不具合の状況はマシになってきたぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　部門切り替え時に　下メッセージ・ウィンドウの初期化をやってしまっていて、そのとき透明になってるようだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　初期化するのは　正しいんじゃない？　そのあと表示しないのが悪いだけで」  

![202310__godot__12-2351--Opaque.png](https://crieit.now.sh/upload_images/d15ff0bede22da547e18c5ce28288dc365280838bf7c0.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　可視性ではなく、不透明性で　見えなくなっていたのだった」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　不具合は　少しずつ　マシになってきているぜ」  

# アクティブ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot のオブジェクトは、存在しない、という設定にできないのかだぜ？ `.set_active()` みたいな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　不可視だったら　存在しない　という取り決めにするしかなくない？」  

# 📅 (2023-10-13 fri 21:21) 再開

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　状態機械をガチガチに作ろうぜ？」  

## スクリプトを統合しよう

![202310__godot__13-2125--Tree-o2o0.png](https://crieit.now.sh/upload_images/51be8f31f2f2d45b13c17b9aa984326d6529376fd274a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　その前に　スクリプトの機能分担が　煩雑になってきたので　シンプルにしていこうぜ？」  

![202310__godot__13-2315--MessageWindow-o2o0.png](https://crieit.now.sh/upload_images/84c71f7298ef5938f040a875bc567df86529511686b3e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　統合して　１ファイル減らしたぜ」  

# セリフと選択肢は別状態か？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　台詞は　最後に　▼　が出て、  
選択肢は　最後に移動できる　▶　が出るのが　違いなんだよな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　メッセージエンド・ブリンカー（Message-end Blinker※造語）が違うだけか」  

![202310__godot__14-0002--MessageEndBlinker-o2o0.png](https://crieit.now.sh/upload_images/5898073a182d1df22d1883137c85c00f65295c367f8eb.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ここらへんのスクリプトを　内部的に１種類に統合したいぜ」  

## メッセージエンド・ブリンカーの状態機械

```gd
#	メッセージエンド・ブリンカー（Message-end Blinker）
extends Node

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　resolved　※解決済み
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※メッセージエンド・ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　worry　※悩む
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーー＋
# ｜　　　｜　　　　｜　　BlinkHere 　　｜　※その場で点滅中
# ｜　　　｜　　　　＋ーー＋ーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　move　※カーソルを動かす　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーーーーー＋　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　BlinkMoving 　　｜　※点滅しながら　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーーーーー＋　　カーソル移動中　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　moved 　※移動完了　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, BlinkHere, BlinkMoving}

# 状態
var state = States.None

# 関数の変数
var on_resolved = null
var on_worry = null
var on_move = null
var on_moved = null


func is_none():
	return self.state == States.None


func is_blink_here():
	return self.state == States.BlinkHere


func is_blink_moving():
	return self.state == States.BlinkMoving


func resolved():
	if on_resolved != null:
		on_resolved.call()
	
	print("［メッセージエンド・ブリンカー］　解決済み")
	self.state = States.None


func worry():
	if on_worry != null:
		on_worry.call()
	
	print("［メッセージエンド・ブリンカー］　悩む")
	self.state = States.BlinkHere


func move():
	if on_move != null:
		on_move.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルを動かす")
	self.state = States.BlinkMoving


func moved():
	if on_moved != null:
		on_moved.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルは移動した")
	self.state = States.BlinkHere
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じか」  

# 📅 2023-10-14 sat ⏰ 12:10 再開

![202310__godot__14-1206--TextBlock-o2o0.png](https://crieit.now.sh/upload_images/8bca3c27f5411dea0e29d6218949ea9a652a06ac8a4e6.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　スクリプトが分かれてると　つらいから　統合するぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　使ってみると　最適が分かってくるな」  

## ブリンカーの状態機械

```gd
#	ブリンカー（Blinker；点滅するもの）
extends Node

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　switch_off　※スイッチ・オフ
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　switch_on　※スイッチ・オン
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーーーーーーー＋
# ｜　　　　　　　　｜　　BrightAtFirst 　　｜　※初回はすぐ表示
# ｜　　　　　　　　＋ーー＋ーーーーーーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　turn_off　※時間経過による消灯　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　Off 　　｜　※消える　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーー＞＋＜ーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　turn_on　※時間経過による点灯　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーー＋　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　Bright　　｜　※灯る　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーー＋　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, BrightAtFirst, Off, Bright}

# 状態
var state = States.None

# 関数の変数
var on_switched_on = null
var on_switched_off = null
var on_turned_on = null
var on_turned_off = null


func is_none():
	return self.state == States.None


func is_bright_at_first():
	return self.state == States.BrightAtFirst


func is_off():
	return self.state == States.Off


func is_bright():
	return self.state == States.Bright


func switch_on():
	if on_switched_on != null:
		on_switched_on.call()
	
	print("［ブリンカー］　スイッチ・オン")
	self.state = States.BrightAtFirst


func switch_off():
	if on_switched_off != null:
		on_switched_off.call()
	
	print("［ブリンカー］　スイッチ・オフ")
	self.state = States.None


func turn_on():
	if on_turned_on != null:
		on_turned_on.call()
	
	print("［ブリンカー］　点灯")
	self.state = States.Bright


func turn_off():
	if on_turned_off != null:
		on_turned_off.call()
	
	print("［ブリンカー］　消灯")
	self.state = States.Off
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　点滅の状態も機械に」  

![202310__godot__14-1528--Cursor-o2o0.png](https://crieit.now.sh/upload_images/f6c0d0ba4f5995d32780e9635324b50f652a3551abf91.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　非表示のウィンドウのカーソルが　見えてる」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot の `.show()` 、 `.hide()` メソッドは　アホが考えたメソッドなんだ。  
わたしが考えた `.set_visible_subtree()` メソッドを使うことで解決！」  

## ウィンドウの表示／非表示まででけた

![202310__godot__14-1621--SubWindow.png](https://crieit.now.sh/upload_images/eab22b8c041d8673816fe13b40f857d5652a41a98db74.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　👆　ウィンドウの表示／非表示まででけた。  
中の文章の復元は　まだ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　細かくやってくしかないわねえ」  

# 📅 2023-10-15 sun

![202310__godot__15-0138--Restore.png](https://crieit.now.sh/upload_images/bc3aeded7295d155ac6be34fc85a5183652ac4745434c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　👆　芋づる式に　次から次へと　できてないところが　出てくるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　順調だけど　遅いなあ」  

## Department も一般化しないと　きつい

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　ビジュアルノベル部門とか、システムメニュー部門も　一般化しないと　きつくなってきた」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　再開するのに？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　そう。個別にハードコーディングではきつい」  

```gd
func get_current_snapshot():
	if self.statemachine_of_director.is_playing_visual_novel():
		return self.get_snapshot("VisualNovelDepartment")
		
	elif self.statemachine_of_director.is_playing_system_menu():
		return self.get_snapshot("SystemMenuDepartment")
	
	else:
		return null
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　👆　状態遷移にしていたが、 `Department` は、ただの変数にしたい」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`Department` は状態ではないという建付けにするわけだな」  

## 再開の機能付けた

![202310__godot__15-0512--Department.png](https://crieit.now.sh/upload_images/94d3e3071be22fcb29f1b626977602e7652af688342b9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　👆　再開の機能付けたんだが　なぜだか知らないが　このメニューは１回使うと　２回目以降から出てこないぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　作った本人が分かってないの　わらう」  

## ポップしてるから、ランタイム中に元データが空になってる

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)   
「　ポップしてるから　シナリオが空になってるようだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　カーソルをインクリメントする方が　いいのかしらねえ？」  

.