#	ビジュアル・ノベル・デパートメント・スナップショット（Visual Novel Department Snapshot；ビジュアル・ノベル部のこの瞬間の状態）
extends AbstractDepartment


#	メッセージを出力する対象となるノードの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
var message_window_name_obj = &"下"		# StringName 型 シンタックス・シュガー

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
	return $"../../Managers".get_node(str(self.name))
