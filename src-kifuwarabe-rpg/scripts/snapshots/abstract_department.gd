#	アブストラクト・デパートメント・スナップショット（Abstract Department Snapshot；抽象的なこの瞬間の状態）
extends Node

class_name AbstractDepartmentSnapshot

# 段落名
var paragraph_name = null

# メッセージウィンドウが指示待ちか？
var is_message_window_waiting_for_order = false

#	選択肢
# 		選択肢モード
var is_choice_mode = false

# 		選択肢の行番号
var choice_row_numbers = []

#		テキストブロックに表示したい文章
var text_block_buffer = ""

#		タイプライターのカウント
var count_of_typewriter = 0


#	表示中の場所のノード名。無ければ空文字列
var location_node_name = ""


#	メッセージウィンドウが指示待ちか？
func set_message_window_waiting_for_order(flag):
	self.is_message_window_waiting_for_order = flag


#	同名のデパートメント・マネージャー取得
func get_manager():
	var department_name = str(self.name)
	return $"../../Managers".get_node(department_name)