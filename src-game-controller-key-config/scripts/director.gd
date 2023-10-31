# ディレクター（Director）
extends Node2D


var re_button = RegEx.new()
var re_lever = RegEx.new()

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0
# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var turn_state = &"WaitForPrompt"
var current_step = 0
# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""

# 値はボタン番号。レバーは +1000
var key_config = {
	# 仮想キー（１）決定ボタン、メッセージ送りボタン
	&"VK_Ok" : -1,
	# 仮想キー（２）キャンセルボタン、メニューボタン
	&"VK_Cancel" : -1,
	# 仮想キー（３）メッセージ早送りボタン
	&"VK_FastForward" : -1,
}

# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


	$"TelopCoordinator/TextBlock".text = """\
	＊　＊　＊
	"""


# ボタンが重複するか？
func is_key_duplicated(button_number):
	return button_number in self.key_config.values()


func set_key_ok():
	$"TelopCoordinator/TextBlock".text = "＊　＊　＊"


# キーコンフィグ　ボタン設定が拒否
func set_key_denied():
	$"Musician/SE/🔔キーコンフィグ不可音".play()
	$"TelopCoordinator/TextBlock".text = "他のキーを選んでください"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not (turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	var is_ok = false
	
	# 初回
	if self.current_step == 0:
		$"Musician/BGM/🎵キーコンフィグ".play()
		self.current_step += 1
		is_ok = true
		
	# （１）決定ボタン、メッセージ送りボタン
	elif self.current_step == 1:
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

		elif turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン：　" + self.button_presentation_name
			self.key_config[&"VK_Ok"] = self.button_number
			self.current_step += 1
			turn_state = &"WaitForPrompt"
	
	# （２）キャンセルボタン、メニューボタン
	elif self.current_step == 2:
		if turn_state == &"WaitForPrompt":
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
	
		elif turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				turn_state = &"WaitForInput"
				is_ok = true

			else:
				self.set_key_ok()
				$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン：　" + self.button_presentation_name
				self.key_config[&"VK_Cancel"] = self.button_number
				self.current_step += 1
				turn_state = &"WaitForPrompt"
		
	# （３）メッセージ早送りボタン
	elif self.current_step == 3:
		if turn_state == &"WaitForPrompt":
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

		elif turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				turn_state = &"WaitForInput"
				is_ok = true
			
			else:
				self.set_key_ok()			
				$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン：　" + self.button_presentation_name
				self.key_config[&"VK_FastForward"] = self.button_number
				self.current_step += 1
				turn_state = &"WaitForPrompt"
		
	elif self.current_step == 4:
		if turn_state == &"WaitForPrompt":
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
		turn_state = &"InputOk"
		$"Musician/SE/🔔キーコンフィグ決定音".play()
		print("入力完了")
