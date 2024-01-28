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
	if reason == &"CancelButtonPushed":
		self.monkey().display().on_cancel_button_pushed()
		self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)

	else:
		pass
