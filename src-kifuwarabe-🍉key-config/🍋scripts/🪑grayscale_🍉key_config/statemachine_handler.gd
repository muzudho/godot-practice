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
	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	self.monkey().of_staff().telop_coordinator().show()
	self.monkey().of_staff().illustrator_node().show()
	self.monkey().of_staff().programmer().owner_node().images.find_node("■下").show()
	self.monkey().of_staff().programmer().owner_node().images.find_node("■上_大").show()
	self.monkey().of_staff().programmer().owner_node().telops.find_node("Ｔキーコンフィグ").show()

	# ーーーーーーーー
	# イベント
	# ーーーーーーーー
	# シーンの外側の１階層上の `👥Staff` ノードへアクセス
	self.monkey().of_staff().programmer().owner_node().on_key_config_entered()


func on_exit():
	self.monkey().moderator().clear_count_by_step()
	self.monkey().display().on_exit()


# 入力の前に待て
func on_wait_before_input(reason):
	# キャンセル・ボタン押下時
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


	else:
		pass
