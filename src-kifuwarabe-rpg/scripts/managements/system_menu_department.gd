#	システム・メニュー・デパートメント・マネージャー（System Menu Department Manager；システム・メニュー部管理人）
extends Node


var is_appear = false


func get_message_window(node_name):
	return $"../../../GuiArtist/WindowsOfMessage".get_node(node_name)


#	居なくなる
func disappear():
	print("［システム・メニュー部管理人］　隠す")
	is_appear = false
	
	#	表示中の［中央］メッセージ・ウィンドウを隠す
	self.get_message_window("中央").set_visible_subtree(false)

	#	ポーズ
	#		とりあえず、［下］メッセージ・ウィンドウを止めてみる
	#		is_processing は、初回は false
	self.get_message_window("中央").set_process_subtree(false)
	
	#	場所が表示中なら、非表示にする
	# $"../../../LocationCoordinator".hide_current_location(str(self.name))


#	現れる
func appear():
	print("［システム・メニュー部管理人］　表示")
	is_appear = true

	#	表示中の［中央］メッセージ・ウィンドウを表示する
	self.get_message_window("中央").set_visible_subtree(true)

	#	再開
	self.get_message_window("中央").set_process_subtree(true)

	#	場所が非表示中なら、表示する
	# $"../../../LocationCoordinator".show_current_location(str(self.name))
