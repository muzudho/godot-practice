# メッセージ・ウィンドウ（Message Window；伝言窓）
extends Node


class_name DepartmentMessageWindow


# メッセージ・スピード（１秒当たりの文字数）
var msg_speed = 20.0

# テキストブロック汎用
#	セクションの何番目（０開始）を次に読込むか
var section_item_index = 0
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null
#	選択肢配列のインデックス
var choices_index = 0


# テキストブロックのバッファーが残っているか？
func has_text_block_buffer():
	return 0 < self.text_block_buffer.length()


# テキスト・ブロックの先頭１文字を切り取って返す
func pop_head_of_text_block():
	var head = self.text_block_buffer.substr(0, 1)
	self.text_block_buffer = self.text_block_buffer.substr(1)
	return head


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# 選択肢カーソルが指しているのは何行目か？　序数。該当がなければ 1 を返す
func get_row_number_of_choices():
	if self.choices_row_numbers == null:
		return 1

	return self.choices_row_numbers[self.choices_index]


# メッセージを記録するだけ
func remember(
		new_text):		# str

	# 設定
	self.text_block_buffer = new_text

	# 選択肢なら
	if self.is_choices():
		print("［部門スナップ写］　リメンバー　選択肢：[" + new_text + "]")

	# それ以外なら
	else:
		print("［部門スナップ写］　リメンバー　台詞：[" + new_text + "]")
