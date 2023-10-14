# システム・メニュー・デパートメント・マネージャー（System Menu Department Manager；システム・メニュー部管理人）
extends AbstractDepartmentManager


# 居なくなる
func disappear():
	print("［システム・メニュー部管理人］　隠す")
	is_appear = false
	
	# メッセージ・ウィンドウを隠す。プロセスも止める
	self.get_message_window().set_appear_subtree(false)
	self.get_message_window().set_process_subtree(false)
	
	# 場所が表示中なら、非表示にする
	#$"../../../LocationCoordinator".hide_current_location(str(self.name))


# 現れる
func appear():
	print("［システム・メニュー部管理人］　表示")
	is_appear = true

	# メッセージ・ウィンドウを表示する。プロセスも再開する
	self.get_message_window().set_appear_subtree(true)
	self.get_message_window().set_process_subtree(true)

	# 場所が非表示中なら、表示する
	#$"../../../LocationCoordinator".show_current_location(str(self.name))


#	メッセージの追加
func push_message(temp_text):
	# メッセージ・ウィンドウの表示
	# TODO メッセージ・ウィンドウが　どれぐらい文字を表示してるかを　スナップショットに記憶したい
	var message_window = self.get_message_window()
	message_window.remember(temp_text)
	message_window.statemachine_of_message_window.talk_2()
