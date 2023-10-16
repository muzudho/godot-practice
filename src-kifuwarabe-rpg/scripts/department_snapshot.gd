# デパートメント・スナップショット（Department Snapshot；部門の瞬間の状態）
extends Object

class_name DepartmentSnapshot

# パースをするな
var parse_lock_flag = true

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null

# テキストブロック汎用
#	セクションの何番目（０開始）を次に読込むか
var section_item_index = 0
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# メッセージ・ウィンドウのノード名。スタック構造をしている。文字列ではなく StringName 型
var message_window_name_obj_stack = []

# 「§」セクション名
var section_name = null

# 部門名。StringName 型
var name = null


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
