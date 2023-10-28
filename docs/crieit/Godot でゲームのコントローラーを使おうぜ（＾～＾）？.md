# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# Git Hub

📖　[src-game-controller](https://github.com/muzudho/godot-practice/tree/main/src-game-controller)  

# はじめに

![202310__photo__27-2220--Gamepad.jpg](https://crieit.now.sh/upload_images/d713d338edceee98e75f4eccda2800e9653bb92629320.jpg)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ゲームパッドが届いたので　Godot　はゲームパッドを使えるか　調べようぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　こういうコントローラーは　どうやって使うの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ハードウェアと　ハードウェアは結局　ピンが束になったバスで　つながってるだけで  
そこを電気信号が通るだけだぜ。  
現代だと　USB規格　を使うだろうから、  
USB端子を　USBポートに差し込めば  
OS に何か刺さった、という　自動認識まではしてくれるんじゃないかな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　やってくれだぜ」  

![202310__photo__27-2232--Gamepad-o2o0.jpg](https://crieit.now.sh/upload_images/c06c18cdbaa0040dc757352a36e64819653bbc515950e.jpg)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　USB ケーブルを指すぜ。無線のもあるな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　USB メモリータイプの端子挿したら　PCから音が出て　反応して　セットアップが自動的に始まって  
セットアップが終わったぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　電池は？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ケーブル挿して１、２時間でチャージが終わるそうだぜ。電池は取り出せなさそう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　ケーブル挿せだぜ」  

## Godot の説明書読もうぜ？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　説明書読むか～」  

📖　[Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/stable/tutorials/inputs/controllers_gamepads_joysticks.html)  

```
E 0:00:00:0571   director.gd:24 @ _process(): The InputMap action "move_back" doesn't exist. Did you mean "ui_text_backspace"?
  <C++ エラー>      Condition "!InputMap::get_singleton()->has_action(p_action)" is true. Returning: 0.0
  <C++ ソース>      core/input/input.cpp:346 @ get_action_raw_strength()
  <スタックトレース>     director.gd:24 @ _process()
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　いや　もう　エラー出たが」  

![202310__godot__27-2316--InputMap.png](https://crieit.now.sh/upload_images/ff4a2920b1acef9476e36663df09bc5b653bc6549e0ed.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　インプットマップが空なのと　何か関係あるかだぜ？」  

![202310__godot__27-2316--InputMap-o2o0.png](https://crieit.now.sh/upload_images/2644461e23db9ed66971483e7c6e1225653bc6ee33603.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あっ、何か出た！」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`ui_left` というのが使えるんじゃないの？」  

```gd
func _process(_delta):
	
	var velocity = Input.get_vector(
			&"ui_left",		# 左の方
			&"ui_right",	# 右の方
			&"ui_up",		# 上の方
			&"ui_down")		# 下の方

	$"GuiArtist/CanvasLayer/→値".text = str(velocity.x)
	$"GuiArtist/CanvasLayer/↓値".text = str(velocity.y)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　よし、取れたぜ。 `-1`、`0`、`1` のいずれかになる感じだぜ」  

## Godot の説明書じゃ分かんね

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　たいてい、公式の記事を読め、と言うところなんだが、 `Godot` は金も人手も足りてないのか　ホームページもドキュメントも　ぐちゃぐちゃなんで……」  

📖　[Input examples](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html)  

```gd
func _input(event):
	print(event.as_text())
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　自力で解析するか」  

Output:  

```
Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　この入力はどうやって　利用できるのか」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　その文字列を利用すればいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　この文字列が仕様なのか　Godot をアップデートしたら　あっさり変わるのか分からん」  

📖　[Input](https://godotforums.org/d/25136-getting-the-name-of-input-action-associated-to-input/10)  

```
func _input(event):
	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			print("action: " + action)
```

Output:  

```
Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　確かにこの文字列が出力されるが……」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ　この長ったらしい文字列が　ボタンのＩｄになってるわけかだぜ、変なの」  

```
Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　１ボタンと　連射１ボタンが　同じ文字列　返ってくるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　連射ボタンだからじゃないか？　押しっぱなしにしてみろだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　確かに　１ボタンは　押しっぱなしにしても反応しないが、  
連射１ボタンは　押しっぱなしにしてると　何度も反応するぜ、いわゆるキー・リピート」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　連射ボタンだからな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　嬉しくね～」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　せっかく　４つ　ボタンが付いてるのに　そのうちの半分は　キーリピートするだけ……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　時代よ　時代！　シューティング全盛期！」  

## セレクトボタンと　ランボタン

```
Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)
Joypad Button 6 (Start, Xbox Menu, Nintendo +)
Unknown
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　セレクト・ボタンが　ボタン４、  
ラン・ボタンが　ボタン６　だぜ。
模倣品のゲームパッドの真ん中上の方にある　本来付いてない何か分からんボタンを押すと `Unknown` で、パソコン画面上に　各種設定が出てきたぜ」  

## PC-Engine のゲームパッドのボタン配置

```
　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　&"Unknown"
　　　　　　&"ui_up"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　&"Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)"連射　　&"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)"連射
&"ui_left"　　　　　　　&"ui_right"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
　　　　　　&"ui_down"　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　&"Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)"　　　　&"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)"

　　　　　　　　　　　　　　　　　　&"Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)"     　&"Joypad Button 6 (Start, Xbox Menu, Nintendo +)"
```

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　つまり　こうだ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　美しくないが　その文字列に従って　コーディングしてみるか、美しくないが」  

```gd
# 入力１つ１つに分解されて呼び出されるようだ
func _unhandled_input(event):
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	var description = "判定：　"
	# 初期状態は、ボタンを離しているということにする
	var presentation = "."

	# ボタンの状態（何もしていないときはこの関数自体が呼び出されない）

	if event.is_pressed():
		description += "pressed "
		presentation = "■"
	
	if event.is_released():
		description += "released "
		presentation = "."

	# 操作したボタン
	var button_number = -1

	if event_as_text == &"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
		description += "Joypad Button 0"
		button_number = 0
		
	elif event_as_text == &"Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)":
		description += "Joypad Button 1"
		button_number = 1

	elif event_as_text == &"Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)":
		description += "Joypad Button 4"
		button_number = 4

	elif event_as_text == &"Joypad Button 6 (Start, Xbox Menu, Nintendo +)":
		description += "Joypad Button 6"
		button_number = 6
	
	print(description)

	# "Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)"
	if button_number == 0:
		$"GuiArtist/CanvasLayer/I値".text = presentation
			
	# "Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)"
	elif button_number == 1:
		$"GuiArtist/CanvasLayer/II値".text = presentation

	# "Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)"
	elif button_number == 4:
		$"GuiArtist/CanvasLayer/Select値".text = presentation
				
	# "Joypad Button 6 (Start, Xbox Menu, Nintendo +)"
	elif button_number == 6:
		$"GuiArtist/CanvasLayer/Run値".text = presentation


	var is_lever = false

	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			print("action: " + action)
			
			# 十字キーを想定
			if action == &"ui_left" or action == &"ui_right" or action == &"ui_up" or action == &"ui_down":
				is_lever = true

#			if action == &"JOY_AXIS_INVALID":
#				print("JOY_AXIS_INVALID")
#			elif action == &"JOY_AXIS_LEFT_X":
#				print("JOY_AXIS_LEFT_X")
#			elif action == &"JOY_AXIS_LEFT_Y":
#				print("JOY_AXIS_LEFT_Y")
#			elif action == &"JOY_AXIS_MAX":
#				print("JOY_AXIS_MAX")
#			elif action == &"JOY_AXIS_RIGHT_X":
#				print("JOY_AXIS_RIGHT_X")
#			elif action == &"JOY_AXIS_RIGHT_Y":
#				print("JOY_AXIS_RIGHT_Y")
#			elif action == &"JOY_AXIS_SDL_MAX":
#				print("JOY_AXIS_SDL_MAX")
#			elif action == &"JOY_AXIS_TRIGGER_LEFT":
#				print("JOY_AXIS_TRIGGER_LEFT")
#			elif action == &"JOY_AXIS_TRIGGER_RIGHT":
#				print("JOY_AXIS_TRIGGER_RIGHT")
#			elif action == &"JOY_BUTTON_A":
#				print("JOY_BUTTON_A")
#			elif action == &"JOY_BUTTON_B":
#				print("JOY_BUTTON_B")
#			elif action == &"JOY_BUTTON_BACK":
#				print("JOY_BUTTON_BACK")
#			elif action == &"JOY_BUTTON_DPAD_DOWN":
#				print("JOY_BUTTON_DPAD_DOWN")
#			elif action == &"JOY_BUTTON_DPAD_LEFT":
#				print("JOY_BUTTON_DPAD_LEFT")
#			elif action == &"JOY_BUTTON_DPAD_RIGHT":
#				print("JOY_BUTTON_DPAD_RIGHT")
#			elif action == &"JOY_BUTTON_DPAD_UP":
#				print("JOY_BUTTON_DPAD_UP")
#			elif action == &"JOY_BUTTON_GUIDE":
#				print("JOY_BUTTON_GUIDE")
#			elif action == &"JOY_BUTTON_INVALID":
#				print("JOY_BUTTON_INVALID")
#			elif action == &"JOY_BUTTON_LEFT_SHOULDER":
#				print("JOY_BUTTON_LEFT_SHOULDER")
#			elif action == &"JOY_BUTTON_LEFT_STICK":
#				print("JOY_BUTTON_LEFT_STICK")
#			elif action == &"JOY_BUTTON_MAX":
#				print("JOY_BUTTON_MAX")
#			elif action == &"JOY_BUTTON_MISC1":
#				print("JOY_BUTTON_MISC1")
#			elif action == &"JOY_BUTTON_PADDLE1":
#				print("JOY_BUTTON_PADDLE1")
#			elif action == &"JOY_BUTTON_PADDLE2":
#				print("JOY_BUTTON_PADDLE2")
#			elif action == &"JOY_BUTTON_PADDLE3":
#				print("JOY_BUTTON_PADDLE3")
#			elif action == &"JOY_BUTTON_PADDLE4":
#				print("JOY_BUTTON_PADDLE4")
#			elif action == &"JOY_BUTTON_RIGHT_SHOULDER":
#				print("JOY_BUTTON_RIGHT_SHOULDER")
#			elif action == &"JOY_BUTTON_RIGHT_STICK":
#				print("JOY_BUTTON_RIGHT_STICK")
#			elif action == &"JOY_BUTTON_SDL_MAX":
#				print("JOY_BUTTON_SDL_MAX")
#			elif action == &"JOY_BUTTON_START":
#				print("JOY_BUTTON_START")
#			elif action == &"JOY_BUTTON_TOUCHPAD":
#				print("JOY_BUTTON_TOUCHPAD")
#			elif action == &"JOY_BUTTON_X":
#				print("JOY_BUTTON_X")
#			elif action == &"JOY_BUTTON_Y":
#				print("JOY_BUTTON_Y")
				
			# 以上
				
	if is_lever:
		var velocity = Input.get_vector(
				&"ui_left",		# 左の方
				&"ui_right",	# 右の方
				&"ui_up",		# 上の方
				&"ui_down")		# 下の方
		
		$"GuiArtist/CanvasLayer/→値".text = str(velocity.x)
		$"GuiArtist/CanvasLayer/↓値".text = str(velocity.y)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　よく分からん。またあとで書き直そうぜ？」  

## 仮想キーを作らな

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームパッドと　キーボード、両方の操作を　プログラムするの　めんどくさいぜ。  
仮想キーを作らな」  

```gd
&"VK_Ok"
&"VK_SystemMenu"
&"VK_FastForward"
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　キーボードが　Push Any Key じゃなくなったが……」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　１つ１つ　仮想の Ok ボタン当てはめていくの　めんどくさいんで　エンターキー使えだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　劣化よ、劣化！」  

## メガドライブ風ゲームパッド

![202310__photo__28-1256--GamePadBox-o2o0.jpg](https://crieit.now.sh/upload_images/8d05907725ada9894de7a7d8c4114fee653cd2188eaef.jpg)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　まだ箱があるぜ」  

![202310__photo__28-1256--GamePadOpen-o2o0.jpg](https://crieit.now.sh/upload_images/b7ac6cda3d71b51c8fc059e8e7ec640d653cd260df583.jpg)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　これもＵＳＢが入ってるな。　同じ　8 Bit Do というメーカーのようだぜ、知らんけど」  

## コントローラーが反応しなくなった

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　終わった……」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　電池か？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　最後に挿したＵＳＢ端子のせいで　おかしくなったとか　画面右下で言いわけがポップアップされたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　２時間　充電してみましょう。  
それで動かなかったら　床に叩きつけて　割りましょう」  

## 8BitDo のPC-Engine風のゲームパッドは、実用的な話を言えば、必ずドライバーの更新の手順を踏む必要がある

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　捨てるか　ドライバーを再インストールするか　考え中」  

📖　[https://support.8bitdo.com/](https://support.8bitdo.com/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　サポートサイトはここにあるが、悪意のあるサイトか、そうでないか分からない。  
わたしが人柱になるんで、あとは頼む」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　PC-Engine風のゲームパッド用のドライバーをダウンロードすると説明書が入っているのでそれを読む」  

![202310__godot__28-2330--8BitDo-HomeButton.png](https://crieit.now.sh/upload_images/60575110b41fbd9a621a1ec7598e8ae1653d1b7b97f37.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　8BitDo のゲームパッドには　上図のような柄のボタンが付いていて、 **ホームボタン**（Home Button） と呼ぶそうだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームパッドのＵＳＢ接続を抜き、ホームボタンを３秒押すと、赤いランプも青いランプも消えた状態になる。  
これが　電源オフの状態だぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　セレクトボタンを押したまま、ホームボタンを押す」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　すると　青いランプと　黄色いランプが点滅する」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　無線ではなく、USBケーブルを使って　ゲームパッドとPCを接続する」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　すると　ゲームパッド側は　**USB フラッシュ・ドライブ** になっているらしく、  
そのファイル・エクスプローラーが開く」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`8BitDo_PCE_Gamepad_Fw_V4.02.dat` ファイルを、 USB フラッシュ・ドライブへ  
コピー貼り付けする」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　コピーが終わったら　USBケーブルを抜く」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　まだ　青いランプと　黄色いランプが点滅しているから、  
そのランプが消えるよう、ホームボタンを　３秒間　押し続ける」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ランプが消えたら更新完了」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あとは　工場から出荷されて自宅に届いたつもりになって　普通にゲームパッドを使えば　使える」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　だったら　使用前に　ドライバーの更新をすることを　必須にしてほしい」  

## 8BitDO のメガドライブ風のゲームパッドも、実用的な話を言えば、ドライバーを再インストールする必要がある

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　8BitDO のメガドライブ風のゲームパッドも、実用的な話を言えば、ドライバーを再インストールする必要がある」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　何の案内も無いのに　探した者だけが見つけることができるところに　手順だけあるの、海外製品のサポートよね～」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　とりあえず　自分の持ってる製品に合ったドライバーを入手しろだぜ。ゲームパッドのどこかに型番が刻印されているだろう」  

📂 `M30_24G_Mini_GamepadV208`  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　パターンがいくつかあるようなので、わたしのケースで説明する」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームパッドとPCが接続されていない状態にする。USBケーブルを抜くとか」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲームパッドのど真ん中にあるスタートボタンを、体感で１０秒ぐらい長押しする。  
すべてのランプが消灯する」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Ｌ、Ｒボタンの両方を押しっぱなしにして、スタートボタンを押す。  
これで　黄色いランプと、青いランプが点灯し続ける。これは　**アップグレード・モード**　と呼ぶそうだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　USBケーブルを使って、ゲームパッドとＰＣを接続する」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　すると　ゲームパッド側は　**USB フラッシュ・ドライブ** になっているらしく、  
そのファイル・エクスプローラーが開く」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`CopyFwToUDisk.exe` ファイルをダブルクリックする」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`Open` ボタンをクリックして、`*.dat` ファイルが添付されてるから、それを選ぶ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`Update` ボタンをクリックする。黒い画面が出る。それが勝手に閉じられるまで待つ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　また、ゲームパッドとPCを接続しているUSBケーブルを抜く」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　スタートボタンを　３秒間　押し続ける。これでコントローラーの電源がオフになる」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あとは　工場から出荷されて自宅に届いたつもりになって　普通にゲームパッドを使えば　使える」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　だったら　使用前に　ドライバーの更新をすることを　必須にしてほしい」  

.