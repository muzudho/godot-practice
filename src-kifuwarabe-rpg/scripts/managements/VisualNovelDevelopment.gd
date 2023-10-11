#	ビジュアル・ノベル・デパートメント・マネージャー（Visual Novel Department Manager；ビジュアル・ノベル部管理人）
extends Node


var is_appear = false


func get_message_window(node_name):
	return $"../../../GuiArtist/WindowsOfMessage".get_node(node_name)


#	居なくなる
func disappear():
	print("［ビジュアル・ノベル部管理人］　隠す")
	is_appear = false
	
	#	表示中の［下］メッセージ・ウィンドウを隠す
	if self.get_message_window("下").visible:
		self.get_message_window("下").set_visible_subtree(false)

	#	ポーズ
	#		とりあえず、［下］メッセージ・ウィンドウを止めてみる
	#		is_processing は、初回は false
	if self.get_message_window("下").is_processing():
		self.get_message_window("下").set_process_subtree(false)
		
	#	場所が表示中なら、非表示にする
	$"../../../LocationCoordinator".hide_current_location(str(self.name))


#	現れる
func appear():
	print("［ビジュアル・ノベル部管理人］　表示")
	is_appear = true

	#	表示中の［下］メッセージ・ウィンドウを表示する
	if not self.get_message_window("下").visible:
		self.get_message_window("下").set_visible_subtree(true)
		# TODO 最後に表示していた途中のメッセージを追加しないと、ウィンドウは表示されない？

	#	再開
	if not self.get_message_window("下").is_processing():
		self.get_message_window("下").set_process_subtree(true)

	#	場所が非表示中なら、表示する
	$"../../../LocationCoordinator".show_current_location(str(self.name))
