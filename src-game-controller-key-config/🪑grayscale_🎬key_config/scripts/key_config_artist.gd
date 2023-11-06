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
	# Director_KeyConfig” ルート・ノードを名称変更して使いたいなら、以下を編集してください
	return $"../../Director_KeyConfig"


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
	# 最後に半角スペースを入れること。 `Button 1` と `Button 10` を区別するために
	re_button.compile("Joypad Button (\\d+) ")
	re_lever.compile("Joypad Motion on Axis (\\d+) ")


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
	self.set_empty_the_1st_button_message()
	self.set_empty_the_2nd_button_message()
	self.set_empty_the_3rd_button_message()
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

	# BGM 停止	
	self.get_musician().get_node("BGM/🎵キーコンフィグ").stop()

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


func set_empty_the_1st_button_message():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）"


func set_empty_the_2nd_button_message():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）"


func set_empty_the_3rd_button_message():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）"


func set_press_message_to_1st_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン　を押してください"


func set_press_message_to_2nd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン　を押してください"


func set_press_message_to_3rd_button():
	#																		   "１２３４５６７８９０１２３４５６７８９："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　を押してください"


func set_press_message_to_4th_button():
	#														  "１２３４５６７８９０１２３４５６７８９："
	self.get_telop_coordinator().get_node("TextBlock").text = "完了"
	self.get_musician().get_node("SE/🔔キーコンフィグ完了音").play()


func set_message_the_1st_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（１）ボタン").text = "（１）キャンセルボタン、メッセージ送りボタン：　" + self.button_presentation_name


func set_message_the_2nd_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（２）ボタン").text = "（２）決定ボタン、メニューボタン　　　　　　：　" + self.button_presentation_name


func set_message_the_3rd_button_done():
	#																		   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
	self.get_gui_artist().get_node("KeyConfig_CanvasLayer/（３）ボタン").text = "（３）メッセージ早送りボタン　　　　　　　　：　" + self.button_presentation_name


func clear_count():
	self.counter_of_wait = 0.0
	self.button_number = -1
	self.button_presentation_name = &""
	

func on_step_regular(
		delta,
		set_press_message_to_button):
	
	if self.turn_state == &"WaitForPrompt":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return true
			
		self.turn_state = &"Prompt"
		return true

	elif self.turn_state == &"Prompt":
		set_press_message_to_button.call()
		self.turn_state = &"WaitForInput"
		return true
		
	elif self.turn_state == &"WaitForInput":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return true

		# 最終ステップ時
		if self.current_step == 4:
			# 完了メッセージを見せるために、効果音とも併せて、少し長めに
			if self.counter_of_wait < 1.5:
				self.counter_of_wait += delta
				return true
			
			self.turn_state = &"Input"
			self.clear_count()
			self.on_exit()
			return true

		self.turn_state = &"Input"
		self.clear_count()
		return true
	
	return false


func on_process(delta):

	if not self.is_enabled:
		return
	
	if not (self.turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	# 初回
	if self.current_step == 0:
		self.get_musician().get_node("BGM/🎵キーコンフィグ").play()
		self.current_step += 1
		self.clear_count()
	
	# ーーーーーーーー
	# （１）キャンセルボタン、メニューボタン
	# ーーーーーーーー
	elif self.current_step == 1:

		# 起動直後に　レバーが入った状態で始まることがあるから、最初は、入力を数フレーム無視するウェイトから始めること
		var is_controlled = self.on_step_regular(
				delta,
				self.set_press_message_to_1st_button)
		
		if is_controlled:
			pass

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

		var is_controlled = self.on_step_regular(
				delta,
				self.set_press_message_to_2nd_button)
		
		if is_controlled:
			pass
		
		elif self.turn_state == &"InputOk":

			# キャンセルボタン押下時は、１つ戻す
			if self.is_cancel_button_pressed(self.button_number):
				self.set_key_canceled()
				self.get_director().key_config.erase(&"VK_Cancel")
				self.turn_state = &"WaitForInput"
				self.current_step -= 1
				self.set_empty_the_2nd_button_message()
				self.set_press_message_to_1st_button()
				self.clear_count()

			# 既存のキーと被る場合、やり直しさせる
			elif self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				self.clear_count()

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

		var is_controlled = self.on_step_regular(
				delta,
				self.set_press_message_to_3rd_button)
		
		if is_controlled:
			pass
		
		elif self.turn_state == &"InputOk":

			# キャンセルボタン押下時は、１つ戻す
			if self.is_cancel_button_pressed(self.button_number):
				self.set_key_canceled()
				self.get_director().key_config.erase(&"VK_Ok")
				self.turn_state = &"WaitForInput"
				self.current_step -= 1
				self.set_empty_the_3rd_button_message()
				self.set_press_message_to_2nd_button()
				self.clear_count()

			# 既存のキーと被る場合、やり直しさせる
			elif self.is_key_duplicated(self.button_number):
				self.set_key_denied()
				self.turn_state = &"WaitForInput"
				self.clear_count()
			
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

		var is_controlled = self.on_step_regular(
				delta,
				self.set_press_message_to_4th_button)
		
		if is_controlled:
			pass


# ボタン番号、またはレバー番号を返す。レバー番号は +1000 して返す。該当がなければ -1 を返す
func get_button_number_by_text(event_as_text):
	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	var matched = self.re_button.search(event_as_text)
	if matched:
		return int(matched.get_string(1))

	matched = self.re_lever.search(event_as_text)
	if matched:
		return int(matched.get_string(1)) + 1000
	
	return -1


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_number(button_number):
	if button_number < 0:
		return &""
		
	if button_number < 1000:
		return "ボタン" + str(button_number)

	return "レバー" + str(button_number - 1000)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number):
	for key in self.get_director().key_config.keys():
		var value = self.get_director().key_config[key]
		if button_number == value:
			return key
	return &""


func on_unhandled_input(event):

	if not self.is_enabled:
		return

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if self.turn_state != &"Input":
		return

	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	self.button_number = self.get_button_number_by_text(event_as_text)
	self.button_presentation_name = self.get_button_name_by_number(self.button_number)

	if 0 <= self.button_number:
		print("受付：　" + self.button_presentation_name)
		self.turn_state = &"InputOk"
