# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 入力
# ーーーーーーーー


# 入力時
func on_unhandled_input(event):

	if not self.monkey().statemachine().is_enabled:
		return

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if self.monkey().statemachine().state != &"Input":
		return


	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	var temp_button_number = self.monkey().parser_for_input().get_button_number_by_text(event_as_text)

	# ーーーーーーーー
	# （５）上キー
	# ーーーーーーーー
	if self.monkey().moderator().key_config_item_number == 5:
		# 下キーがボタンのときは、上キーはレバーであってはいけません
		if 1000 < temp_button_number:
			self.monkey().moderator().set_key_denied(2)
			self.monkey().statemachine().state = &"WaitForInput"
			return

	# ーーーーーーーー
	# （７）左キー
	# ーーーーーーーー
	elif self.monkey().moderator().key_config_item_number == 7:
		# 右キーがボタンのときは、左キーはレバーであってはいけません
		if 1000 < temp_button_number:
			self.monkey().moderator().set_key_denied(3)
			self.monkey().statemachine().state = &"WaitForInput"
			return


	# 有効なキーなら
	if 0 <= temp_button_number:
		self.monkey().moderator().button_number = temp_button_number		
		print("受付：　" + self.monkey().display().get_button_name_by_number(self.monkey().moderator().button_number))
		
		self.monkey().statemachine().state = &"InputOk"
