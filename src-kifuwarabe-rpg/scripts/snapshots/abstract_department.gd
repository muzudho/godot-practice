# アブストラクト・デパートメント・スナップショット（Abstract Department Snapshot；抽象的なこの瞬間の状態）
extends Node

class_name AbstractDepartmentSnapshot

# メッセージウィンドウが指示待ちか？
var is_message_window_waiting_for_order = false

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null

# テキストブロック汎用
#	読込んだメッセージの配列が入っている
var scenario_array = []
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 表示中の場所のノード名。無ければ空文字列
var location_node_name = ""


# メッセージウィンドウが指示待ちか？
func set_message_window_waiting_for_order(flag):
	self.is_message_window_waiting_for_order = flag


# 同名のデパートメント・マネージャー取得
func get_manager():
	var department_name = str(self.name)
	return $"../../Managers".get_node(department_name)


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# メッセージを記録するだけ
func remember(
	new_text):		# str

	# 設定
	self.text_block_buffer = new_text

	# 選択肢なら
	if self.is_choices():
		print("［メッセージウィンドウ　”" + self.name + "”］　リメンバー　選択肢：[" + new_text + "]")

	# それ以外なら
	else:
		print("［メッセージウィンドウ　”" + self.name + "”］　リメンバー　台詞：[" + new_text + "]")
