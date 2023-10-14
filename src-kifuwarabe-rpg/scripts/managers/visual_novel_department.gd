# ビジュアル・ノベル・デパートメント・マネージャー（Visual Novel Department Manager；ビジュアル・ノベル部管理人）
extends AbstractDepartmentManager


# 居なくなる
func disappear():
	if self.is_appear:
		print("［ビジュアル・ノベル部管理人］　隠す")
		self.is_appear = false
		
		# 表示中の［下］メッセージ・ウィンドウを、一時的に居なくする
		self.get_message_window().set_appear_subtree(false)
		
		# 場所が表示中なら、非表示にする
		#$"../../../LocationCoordinator".hide_current_location(str(self.name))


# 現れる
func appear():
	if not self.is_appear:
		print("［ビジュアル・ノベル部管理人］　表示")
		is_appear = true

		# メッセージ・ウィンドウを、一時的に居なくなっていたのを解除する
		self.get_message_window().set_appear_subtree(true)

		# 場所が非表示中なら、表示する
		#$"../../../LocationCoordinator".show_current_location(str(self.name))


#	メッセージの追加
func push_message(temp_text):
	# メッセージ・ウィンドウの表示
	# TODO メッセージ・ウィンドウが　どれぐらい文字を表示してるかを　スナップショットに記憶したい
	var message_window = self.get_message_window()
	message_window.remember(temp_text)
	message_window.statemachine_of_message_window.talk_2()
