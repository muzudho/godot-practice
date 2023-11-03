# キー・コンフィグ・アーティスト（Key Config Artist）
extends Node


# 値はボタン番号。レバーは +1000
var key_config = {
	# 仮想キー（１）決定ボタン、メッセージ送りボタン
	&"VK_Ok" : -1,
	# 仮想キー（２）キャンセルボタン、メニューボタン
	&"VK_Cancel" : -1,
	# 仮想キー（３）メッセージ早送りボタン
	&"VK_FastForward" : -1,
}

var re_button = RegEx.new()
var re_lever = RegEx.new()

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0
var current_step = 0
# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var turn_state = &"WaitForPrompt"

# `.entry()` を呼び出すと真にする。キー・コンフィグが完了するとまた偽にセットする
var is_enabled = false


# 背景担当取得
func get_background_artist():
	return $"../BackgroundArtist"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"../TelopCoordinator"


# 音楽家取得
func get_musician():
	return $"../Musician"


# ＧＵＩ担当取得
func get_gui_artist():
	return $"../GuiArtist"


# ボタンが重複するか？
func is_key_duplicated(button_number):
	return button_number in self.key_config.values()


# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


# キーコンフィグ画面に入る
func entry():
	# 背景
	self.get_background_artist().get_node("🗻崎川駅前").visible = true
	# GUI - メッセージ・ウィンドウ
	self.get_gui_artist().get_node("WindowOfMessage/■上_大").visible = true
	self.get_gui_artist().get_node("WindowOfMessage/■下").visible = true
	# GUI
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer").visible = true
	# テロップ
	self.get_telop_coordinator().get_node("TextBlock").text = """\
	＊　＊　＊
	"""
	self.is_enabled = true


# キーコンフィグ終了時
func on_exit():
	self.is_enabled = false
	# 背景
	self.get_background_artist().get_node("🗻崎川駅前").visible = false
	# GUI - メッセージ・ウィンドウ
	self.get_gui_artist().get_node("WindowOfMessage/■上_大").visible = false
	self.get_gui_artist().get_node("WindowOfMessage/■下").visible = false
	# GUI
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer").visible = false
	# テロップ
	self.get_telop_coordinator().get_node("TextBlock").text = ""


func set_key_ok():
	self.get_telop_coordinator().get_node("TextBlock").text = "＊　＊　＊"


# キーコンフィグ　ボタン設定が拒否
func set_key_denied():
	self.get_musician().get_node("SE/🔔キーコンフィグ不可音").play()
	self.get_telop_coordinator().get_node("TextBlock").text = "他のキーを選んでください"


func on_process(delta):

	if not self.is_enabled:
		return
	
	if not (self.turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	var is_ok = false
	
	# 初回
	if self.current_step == 0:
		self.get_musician().get_node("BGM/🎵キーコンフィグ").play()
		self.current_step += 1
		is_ok = true
		
	# （１）キャンセルボタン、メニューボタン
	elif self.current_step == 1:
		if self.turn_state == &"WaitForPrompt":
			# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視する
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			#																		   "１２３４５６７８９０１２３４５６７８９："
			self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン　を押してください"
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true

		elif self.turn_state == &"InputOk":
			#																		   "１２３４５６７８９０１２３４５６７８９："
			self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン：　" + self.button_presentation_name
			self.key_config[&"VK_Cancel"] = self.button_number
			self.current_step += 1
			self.turn_state = &"WaitForPrompt"
	
	# （２）決定ボタン、メッセージ送りボタン
	elif self.current_step == 2:
		if self.turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			#																		   "１２３４５６７８９０１２３４５６７８９："
			self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン　を押してください"
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true
	
		elif self.turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				is_ok = true

			else:
				self.set_key_ok()
				#																		   "１２３４５６７８９０１２３４５６７８９："
				self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン：　" + self.button_presentation_name
				self.key_config[&"VK_Ok"] = self.button_number
				self.current_step += 1
				self.turn_state = &"WaitForPrompt"
		
	# （３）メッセージ早送りボタン
	elif self.current_step == 3:
		if self.turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			#																		   "１２３４５６７８９０１２３４５６７８９："
			self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　を押してください"
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true

		elif self.turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				is_ok = true
			
			else:
				self.set_key_ok()
				#																		   "１２３４５６７８９０１２３４５６７８９："
				self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　　　　　：　" + self.button_presentation_name
				self.key_config[&"VK_FastForward"] = self.button_number
				self.current_step += 1
				self.turn_state = &"WaitForPrompt"
		
	elif self.current_step == 4:
		if self.turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			#														  "１２３４５６７８９０１２３４５６７８９："
			self.get_telop_coordinator().get_node("TextBlock").text = "完了"
			self.get_musician().get_node("SE/🔔キーコンフィグ完了音").play()
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			# 完了メッセージを見せるために、効果音とも併せて、少し長めに
			if self.counter_of_wait < 1.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			self.on_exit()
			is_ok = true
	
	if is_ok:
		self.counter_of_wait = 0.0
		self.button_number = -1
		self.button_presentation_name = &""


func on_unhandled_input(event):

	if not self.is_enabled:
		return

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if self.turn_state != &"Input":
		return

	var is_ok = false
	var acception = "受付：　"

	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	if not is_ok:
		var matched = self.re_button.search(event_as_text)
		if matched:
			self.button_number = int(matched.get_string(1))
			self.button_presentation_name = "ボタン" + str(self.button_number)
			is_ok = true

	if not is_ok:
		var matched = self.re_lever.search(event_as_text)
		if matched:
			var number = int(matched.get_string(1))
			self.button_presentation_name = "レバー" + str(number)
			self.button_number = number + 1000
			is_ok = true

	if is_ok:
		print(acception)
		self.turn_state = &"InputOk"
		self.get_musician().get_node("SE/🔔キーコンフィグ決定音").play()
		print("入力完了")
