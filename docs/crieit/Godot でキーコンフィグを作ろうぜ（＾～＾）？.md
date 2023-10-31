# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# Git Hub

📖　[src-game-controller-key-config](https://github.com/muzudho/godot-practice/tree/main/src-game-controller-key-config)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　キー・コンフィグを作るか、アイデア無いけど」  

![202310__godot__30-2237--KeyConfig.png](https://crieit.now.sh/upload_images/d517593dcee2b1f68e893d8a65af0b6b653fb1d72260e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　まず画面の雰囲気を　仮置きしようぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだぜ」  

📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　ソースは一部抜粋すると　こんな感じ」  

```gd
# ディレクター（Director）
extends Node2D


var re_button = RegEx.new()
var re_lever = RegEx.new()

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0
# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var turn_state = &"WaitForPrompt"
var current_step = 1
# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""


# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


	$"TelopCoordinator/TextBlock".text = """\
	＊　＊　＊
	"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if not (turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	var is_ok = false
	
	if self.current_step == 1:
		if turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
		
	elif self.current_step == 2:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
		
	elif self.current_step == 3:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true

	elif self.current_step == 4:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"TelopCoordinator/TextBlock".text = "完了"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
	
	else:
		pass
	
	if is_ok:
		self.counter_of_wait = 0.0
		self.button_number = -1
		self.button_presentation_name = &""


func _unhandled_input(event):

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if turn_state != &"Input":
		return

	var is_ok = false
	var acception = "受付：　"

	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	if not is_ok:
		var matched = re_button.search(event_as_text)
		if matched:
			self.button_number = int(matched.get_string(1))
			button_presentation_name = "ボタン" + str(self.button_number)
			is_ok = true

	if not is_ok:
		var matched = re_lever.search(event_as_text)
		if matched:
			var number = int(matched.get_string(1))
			button_presentation_name = "レバー" + str(number)
			self.button_number = number + 1000
			is_ok = true

	if is_ok:
		print(acception)
		self.current_step += 1
		turn_state = &"InputOk"
		print("入力完了")
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　仮組は　こんなもん」  

📺　[動画](https://x.com/muzudho1/status/1719008935167017345?s=20)  

# 📅 2023-11-01 tue ⏰ 25:46

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　仮組は　こんなもん」  

📺　[動画](https://x.com/muzudho1/status/1719394092797579309?s=20)  

.