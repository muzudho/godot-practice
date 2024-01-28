extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../../🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー

func on_entry():
	# ローカルのプログラマー・ノードへアクセス
	self.monkey().the_programmer_node().on_key_config_entered()


func on_exit():
	self.monkey().moderator().clear_count_by_step()
	
	# 画面表示、演奏
	self.monkey().display().on_exit()

	# キーコンフィグ呼出し元
	self.monkey().owner_key_config_node().on_exit()


# 入力の前に待て
func on_wait_before_input(reason):
	# キャンセル・ボタン押下後、再入力
	if reason == &"CancelButtonPushed":
		# キー・コンフィグ項目を、１つか、２つ（レバー時）戻す
		self.monkey().display().on_cancel_button_pushed()
		self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)

		self.monkey().moderator().key_config_item_number -= 1
		# さらに連続して戻したいケースもある
		# レバーの上
		if self.monkey().moderator().key_config_item_number == 5 and self.monkey().owner_key_config_node().key_config[&"VK_Down"] == self.monkey().owner_key_config_node().key_config[&"VK_Up"]:
			self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)
			self.monkey().moderator().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Down")
		# レバーの左
		elif self.monkey().moderator().key_config_item_number == 7 and self.monkey().owner_key_config_node().key_config[&"VK_Right"] == self.monkey().owner_key_config_node().key_config[&"VK_Left"]:
			self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)
			self.monkey().moderator().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Right")
		
		self.monkey().display().set_press_message_to_button(self.monkey().moderator().key_config_item_number)
		
		if self.monkey().moderator().previous_virtual_key_name != null:
			self.monkey().owner_key_config_node().key_config.erase(self.monkey().moderator().previous_virtual_key_name)
		
		self.monkey().moderator().clear_count_by_step()

	# 既存のキーと被って、再入力
	elif reason == &"KeyDuplicated":
		self.monkey().display().on_pushed_button_denied(1)
		self.monkey().moderator().clear_count_by_step()
	
	# インターバル後
	elif reason == &"AfterInterval":
		self.monkey().display().set_press_message_to_button(self.monkey().moderator().key_config_item_number)

	# 下キーがボタンなら、上ボタンも再入力
	elif reason == &"SelectUpButton":
		self.monkey().display().on_pushed_button_denied(2)

	# 右キーがボタンなら、左ボタンも再入力
	elif reason == &"SelectLeftButton":
		self.monkey().display().on_pushed_button_denied(3)

	else:
		print("［キーコンフィグ］　▲！　エラー　reason:" + reason)


# 入力しろ
func on_go_input():
	self.monkey().moderator().clear_count_by_step()


# 入力を受け付けた
func on_input_accepted():
	# 決定
	self.monkey().display().on_pushed_button_accepted(
			self.monkey().moderator().key_config_item_number,
			self.monkey().moderator().button_number)
	self.monkey().owner_key_config_node().key_config[self.monkey().moderator().virtual_key_name] = self.monkey().moderator().button_number

	# レバーの下
	if self.monkey().moderator().key_config_item_number == 4:
		if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Down"]:
			# 軸を選択したなら、レバーの上の選択はスキップ
			self.monkey().owner_key_config_node().key_config[&"VK_Up"] = self.monkey().moderator().button_number
			self.monkey().display().set_done_message_the_button(
					self.monkey().moderator().key_config_item_number + 1,
					self.monkey().moderator().button_number)
			self.monkey().moderator().key_config_item_number += 2
		else:
			self.monkey().moderator().key_config_item_number += 1
	# レバーの右
	elif self.monkey().moderator().key_config_item_number == 6:
		if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Right"]:
			# 軸を選択したなら、レバーの左の選択はスキップ
			self.monkey().owner_key_config_node().key_config[&"VK_Left"] = self.monkey().moderator().button_number
			self.monkey().display().set_done_message_the_button(
					self.monkey().moderator().key_config_item_number + 1,
					self.monkey().moderator().button_number)
			self.monkey().moderator().key_config_item_number += 2
		else:
			self.monkey().moderator().key_config_item_number += 1
	else:
		self.monkey().moderator().key_config_item_number += 1
	
