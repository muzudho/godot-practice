# デパートメント・スナップショット（Department Snapshot；部門の瞬間の状態）
extends Object

class_name DepartmentSnapshot

# パースをするな
var parse_lock_flag = true

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null

# テキストブロック汎用
#	読込んだメッセージの配列が入っている。どんどんポップされて減っていく
var scenario_array = []
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 表示中の場所のノード名。無ければ空文字列
var location_node_name = ""

# メッセージを出力する対象となるノードの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
var message_window_name_obj = null		# StringName 型 シンタックス・シュガー

# 「§」セクション名
var section_name = null

# 部門名。StringName 型
var name = null

# 居るか？
var is_appear = false


# パースをするな
func set_parse_lock(flag):
	self.parse_lock_flag = flag

# パース禁止か？
func is_parse_lock():
	return self.parse_lock_flag


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# テキストブロックのバッファーが残っているか？
func has_text_block_buffer():
	return 0 < self.text_block_buffer.length()


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
