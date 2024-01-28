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
	
