# システム・メニュー・デパートメント・マネージャー（System Menu Department Manager；システム・メニュー部管理人）
extends AbstractDepartmentManager


# 居なくなる
func disappear():
	print("［システム・メニュー部管理人］　隠す")
	is_appear = false
	
	# メッセージ・ウィンドウを隠す。プロセスも止める
	self.get_message_window().set_appear_subtree(false)
	
	# 場所が表示中なら、非表示にする
	#$"../../../LocationCoordinator".hide_current_location(str(self.name))


# 現れる
func appear():
	print("［システム・メニュー部管理人］　表示")
	is_appear = true

	# メッセージ・ウィンドウを表示する。プロセスも再開する
	self.get_message_window().set_appear_subtree(true)

	# 場所が非表示中なら、表示する
	#$"../../../LocationCoordinator".show_current_location(str(self.name))
