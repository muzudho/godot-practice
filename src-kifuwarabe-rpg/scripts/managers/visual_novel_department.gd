#	ビジュアル・ノベル・デパートメント・マネージャー（Visual Novel Department Manager；ビジュアル・ノベル部管理人）
extends AbstractDepartmentManager


#	居なくなる
func disappear():
	print("［ビジュアル・ノベル部管理人］　隠す")
	self.is_appear = false
		
	#	表示中の［下］メッセージ・ウィンドウを隠す。プロセスも止める
	self.get_message_window().set_visible_subtree(false)
	self.get_message_window().set_process_subtree(false)
		
	#	場所が表示中なら、非表示にする
	$"../../../LocationCoordinator".hide_current_location(str(self.name))


#	現れる
func appear():
	print("［ビジュアル・ノベル部管理人］　表示")
	is_appear = true

	#	メッセージ・ウィンドウを表示する。プロセスも再開する
	self.get_message_window().set_visible_subtree(true)
	self.get_message_window().set_process_subtree(true)

	#	場所が非表示中なら、表示する
	$"../../../LocationCoordinator".show_current_location(str(self.name))


#	メッセージの追加
func push_message(temp_text):
	# メッセージ・ウィンドウの表示
	# TODO メッセージ・ウィンドウが　どれぐらい文字を表示してるかを　スナップショットに記憶したい
	self.get_message_window().statemachine_of_message_window.talk(temp_text)
