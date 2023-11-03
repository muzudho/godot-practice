# キー・コンフィグ・アーティスト（Key Config Artist）
extends Node


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


# ディレクター取得
func get_director():
	return $"../../Director"


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
	return button_number in self.get_director().key_config.values()


# キャンセルボタン押下か？
func is_cancel_button_pressed(button_number):
	return button_number == self.get_director().key_config[&"VK_Cancel"]
	

# Called when the node enters the scene tree for the first time.
func _ready():

	# ーーーーーーーー
	# 初期化
	# ーーーーーーーー
	
	# 背景非表示
	self.get_background_artist().visible = false
	
	# ウィンドウ非表示
	self.get_gui_artist().get_node("WindowOfMessage").visible = false
	
	# GUI非表示
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer").visible = false
	
	# テロップ非表示
	self.get_telop_coordinator().get_node("TextBlock").visible = false

	# 入力イベントが返す文字列。仕様さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


# キーコンフィグ画面に入る
func entry():
	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	
	# 背景表示
	self.get_background_artist().visible = true
	
	# ウィンドウ表示
	self.get_gui_artist().get_node("WindowOfMessage").visible = true
	
	# GUI表示
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer").visible = true
	
	# テロップ表示
	self.get_telop_coordinator().get_node("TextBlock").visible = true

	# ーーーーーーーー
	# 設定
	# ーーーーーーーー

	# 背景
	self.get_background_artist().get_node("🗻崎川駅前").visible = true
	# GUI - メッセージ・ウィンドウ
	self.get_gui_artist().get_node("WindowOfMessage/■上_大").visible = true
	self.get_gui_artist().get_node("WindowOfMessage/■下").visible = true
	# GUI
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer").visible = true
	# テロップ
	self.set_message_the_empty_1st_button()
	self.set_message_the_empty_2nd_button()
	self.set_message_the_empty_3rd_button()
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
	
	# ディレクターのイベントハンドラ呼出し
	self.get_director().on_exit()


func set_key_ok():
	self.get_telop_coordinator().get_node("TextBlock").text = "＊　＊　＊"


# キーコンフィグ　ボタン設定を受入
func set_key_accepted():
	self.get_musician().get_node("SE/🔔キーコンフィグ受入音").play()


# キーコンフィグ　ボタン設定が拒否
func set_key_denied():
	self.get_musician().get_node("SE/🔔キーコンフィグ不可音").play()
	self.get_telop_coordinator().get_node("TextBlock").text = "他のキーを選んでください"


# キーコンフィグ　ボタン設定が拒否
func set_key_canceled():
	self.get_musician().get_node("SE/🔔キーコンフィグ取消音").play()
	self.get_telop_coordinator().get_node("TextBlock").text = ""


func set_message_the_empty_1st_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）"


func set_message_the_empty_2nd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）"


func set_message_the_empty_3rd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）"


func set_message_the_push_1st_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン　を押してください"


func set_message_the_push_2nd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン　を押してください"


func set_message_the_push_3rd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　を押してください"


func set_message_the_1st_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン：　" + self.button_presentation_name


func set_message_the_2nd_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン　　　　　　：　" + self.button_presentation_name


func set_message_the_3rd_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　　　　　　　　：　" + self.button_presentation_name


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
	
	# ーーーーーーーー
	# （１）キャンセルボタン、メニューボタン
	# ーーーーーーーー
	elif self.current_step == 1:
		if self.turn_state == &"WaitForPrompt":
			# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視する
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			self.set_message_the_push_1st_button()
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true

		elif self.turn_state == &"InputOk":
			self.set_key_accepted()
			self.set_message_the_1st_button_done()
			self.get_director().key_config[&"VK_Cancel"] = self.button_number
			self.current_step += 1
			self.turn_state = &"WaitForPrompt"
	
	# ーーーーーーーー
	# （２）決定ボタン、メッセージ送りボタン
	# ーーーーーーーー
	elif self.current_step == 2:
		if self.turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			self.set_message_the_push_2nd_button()
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true
	
		elif self.turn_state == &"InputOk":

			# キャンセルボタン押下時は、１つ戻す
			if self.is_cancel_button_pressed(self.button_number):
				self.set_key_canceled()
				self.get_director().key_config.erase(&"VK_Cancel")
				self.turn_state = &"WaitForInput"
				self.current_step -= 1
				self.set_message_the_empty_2nd_button()
				self.set_message_the_push_1st_button()
				is_ok = true

			# 既存のキーと被る場合、やり直しさせる
			elif self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				is_ok = true

			else:
				self.set_key_accepted()
				self.set_key_ok()
				self.set_message_the_2nd_button_done()
				self.get_director().key_config[&"VK_Ok"] = self.button_number
				self.current_step += 1
				self.turn_state = &"WaitForPrompt"
		
	# ーーーーーーーー
	# （３）メッセージ早送りボタン
	# ーーーーーーーー
	elif self.current_step == 3:
		if self.turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Prompt"
		
		elif self.turn_state == &"Prompt":
			self.set_message_the_push_3rd_button()
			self.turn_state = &"WaitForInput"

		elif self.turn_state == &"WaitForInput":
			if self.counter_of_wait < 0.5:
				self.counter_of_wait += delta
				return
			self.turn_state = &"Input"
			is_ok = true

		elif self.turn_state == &"InputOk":

			# キャンセルボタン押下時は、１つ戻す
			if self.is_cancel_button_pressed(self.button_number):
				self.set_key_canceled()
				self.get_director().key_config.erase(&"VK_Ok")
				self.turn_state = &"WaitForInput"
				self.current_step -= 1
				self.set_message_the_empty_3rd_button()
				self.set_message_the_push_2nd_button()
				is_ok = true

			# 既存のキーと被る場合、やり直しさせる
			elif self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				is_ok = true
			
			else:
				self.set_key_accepted()
				self.set_key_ok()
				self.set_message_the_3rd_button_done()
				self.get_director().key_config[&"VK_FastForward"] = self.button_number
				self.current_step += 1
				self.turn_state = &"WaitForPrompt"
		
	# ーーーーーーーー
	# 完了
	# ーーーーーーーー
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
		print("入力Ok")
