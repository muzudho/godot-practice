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
