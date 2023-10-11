#	ビジュアル・ノベル・デパートメント・スナップショット（Visual Novel Department Snapshot；ビジュアル・ノベル部のこの瞬間の状態）
extends Node


# 段落名
var paragraph_name = null

# メッセージウィンドウが指示待ちか？
var is_message_window_waiting_for_order = false

# メッセージが入っている
var scenario_array = []

#	表示中の場所のノード名
var location_node_name = null


# メッセージウィンドウが指示待ちか？
func set_message_window_waiting_for_order(flag):
	self.is_message_window_waiting_for_order = flag
