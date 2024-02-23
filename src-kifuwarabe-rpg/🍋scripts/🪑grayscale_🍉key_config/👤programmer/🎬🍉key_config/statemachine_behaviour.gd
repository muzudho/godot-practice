# ステートマシン・ビヘイビア（Statemachine Behaviour；状態遷移機械の振る舞い）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー

func _ready():
	self.monkey().statemachine_node().behaviour_of_entry = on_entry
	self.monkey().statemachine_node().behaviour_of_exit = on_exit
	self.monkey().statemachine_node().behaviour_of_go_input = on_go_input
	self.monkey().statemachine_node().behaviour_of_try_inputting_again = on_try_inputting_again
	self.monkey().statemachine_node().behaviour_of_input_accepted = on_input_accepted


# ーーーーーーーー
# イベント・ハンドラー
# ーーーーーーーー

# 開始時の振る舞い
func on_entry():
	# ローカルのプログラマー・ノードへアクセス
	self.monkey().the_programmer_node().on_key_config_entered()


# 終了時の振る舞い
func on_exit():
	self.monkey().internal_node().clear_count_by_step()
	
	# 画面表示、演奏
	self.monkey().display_node().perform_at_close_scene()

	# キーコンフィグ呼出し元
	self.monkey().owner_key_config_node().on_exit()


# 入力しろ
func on_go_input():
	self.monkey().internal_node().clear_count_by_step()


# 入力に再挑戦
func on_try_inputting_again(reason):
	# キャンセル・ボタン押下後、再入力
	if reason == &"CancelButtonPushed":
		# キー・コンフィグ項目を、１つか、２つ（レバー時）戻す
		self.monkey().display_node().show_cancel()
		self.monkey().display_node().set_empty_the_button_message(self.monkey().internal_node().key_config_item_number)

		self.monkey().internal_node().key_config_item_number -= 1
		# さらに連続して戻したいケースもある
		# レバーの上
		if self.monkey().internal_node().key_config_item_number == 5 and self.monkey().owner_key_config_node().key_config[&"VK_Down"] == self.monkey().owner_key_config_node().key_config[&"VK_Up"]:
			self.monkey().display_node().set_empty_the_button_message(self.monkey().internal_node().key_config_item_number)
			self.monkey().internal_node().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Down")
		# レバーの左
		elif self.monkey().internal_node().key_config_item_number == 7 and self.monkey().owner_key_config_node().key_config[&"VK_Right"] == self.monkey().owner_key_config_node().key_config[&"VK_Left"]:
			self.monkey().display_node().set_empty_the_button_message(self.monkey().internal_node().key_config_item_number)
			self.monkey().internal_node().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Right")
		
		self.monkey().display_node().set_press_message_to_button(self.monkey().internal_node().key_config_item_number)
		
		if self.monkey().internal_node().previous_virtual_key_name != null:
			self.monkey().owner_key_config_node().key_config.erase(self.monkey().internal_node().previous_virtual_key_name)
		
		self.monkey().internal_node().clear_count_by_step()

	# 既存のキーと被って、再入力
	elif reason == &"KeyDuplicated":
		self.monkey().display_node().show_pushed_button_denied(1)
		self.monkey().internal_node().clear_count_by_step()
	
	# インターバル後
	elif reason == &"AfterInterval":
		self.monkey().display_node().set_press_message_to_button(self.monkey().internal_node().key_config_item_number)

	# 下キーがボタンなら、上ボタンも再入力
	elif reason == &"SelectUpButton":
		self.monkey().display_node().show_pushed_button_denied(2)

	# 右キーがボタンなら、左ボタンも再入力
	elif reason == &"SelectLeftButton":
		self.monkey().display_node().show_pushed_button_denied(3)

	else:
		print("［キーコンフィグ］　▲！　エラー　reason:" + reason)


# 入力を受け付けた
func on_input_accepted():
	# 登録
	self.monkey().owner_key_config_node().push_virtual_key(
			self.monkey().internal_node().virtual_key_name,
			self.monkey().internal_node().button_symbol)
	# 決定演出
	self.monkey().display_node().show_pushed_button_accepted(
			self.monkey().internal_node().key_config_item_number,
			self.monkey().internal_node().button_symbol)

	# レバーの下
	if self.monkey().internal_node().key_config_item_number == 4:
		var hardware_symbol = self.monkey().owner_key_config_node().key_config[&"VK_Down"]
		if typeof(hardware_symbol) != TYPE_STRING && 1000 <= hardware_symbol:
			# 軸を選択したなら、レバーの上の選択はスキップ
			# 上キーにも同様に登録
			self.monkey().owner_key_config_node().push_virtual_key(&"VK_Up", self.monkey().internal_node().button_symbol)
			# メッセージ表示
			self.monkey().display_node().set_done_message_the_button(
					self.monkey().internal_node().key_config_item_number + 1,
					self.monkey().internal_node().button_symbol)
			self.monkey().internal_node().key_config_item_number += 2
		else:
			self.monkey().internal_node().key_config_item_number += 1
			
	# レバーの右
	elif self.monkey().internal_node().key_config_item_number == 6:
		var hardware_symbol = self.monkey().owner_key_config_node().key_config[&"VK_Right"]
		if typeof(hardware_symbol) != TYPE_STRING && 1000 <= hardware_symbol:
			# 軸を選択したなら、レバーの左の選択はスキップ
			# 左キーにも同様に登録
			self.monkey().owner_key_config_node().push_virtual_key(&"VK_Left", self.monkey().internal_node().button_symbol)
			# メッセージ表示
			self.monkey().display_node().set_done_message_the_button(
					self.monkey().internal_node().key_config_item_number + 1,
					self.monkey().internal_node().button_symbol)
			self.monkey().internal_node().key_config_item_number += 2
		else:
			self.monkey().internal_node().key_config_item_number += 1

	else:
		self.monkey().internal_node().key_config_item_number += 1
