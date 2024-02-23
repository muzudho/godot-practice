# キー・コンフィグ　＞　インプット　＞　イッツ　（Its；それ）
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

	# 状態遷移機械が止まっていれば、入力も無視します
	if self.monkey().statemachine_node().is_terminated():
		return

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if self.monkey().statemachine_node().state != &"WaitingForInput":
		return


	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ。
	# キーボードのキーなら、その名前とする
	var temp_button_symbol = self.monkey().input_parser_node().get_button_symbol_by_text(event_as_text)

	# ーーーーーーーー
	# （５）上キー
	# ーーーーーーーー
	if self.monkey().internal_node().key_config_item_number == 5:
		# 下キーがボタンのときは、上キーはレバーであってはいけません
		if typeof(temp_button_symbol) != TYPE_STRING && 1000 < temp_button_symbol:
			self.monkey().statemachine_node().try_inputting_again(&"SelectUpButton")
			return

	# ーーーーーーーー
	# （７）左キー
	# ーーーーーーーー
	elif self.monkey().internal_node().key_config_item_number == 7:
		# 右キーがボタンのときは、左キーはレバーであってはいけません
		if typeof(temp_button_symbol) != TYPE_STRING && 1000 < temp_button_symbol:
			self.monkey().statemachine_node().try_inputting_again(&"SelectLeftButton")
			return


	# 有効なキーなら
	if typeof(temp_button_symbol) == TYPE_STRING || 0 <= temp_button_symbol:
		self.monkey().internal_node().button_symbol = temp_button_symbol		
		print("受付：　" + self.monkey().display_node().get_button_name_by_symbol(self.monkey().internal_node().button_symbol))
		
		self.monkey().statemachine_node().state = &"InputOk"
