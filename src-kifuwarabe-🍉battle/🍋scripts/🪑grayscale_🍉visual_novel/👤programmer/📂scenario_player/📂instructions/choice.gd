# チョイス（Choice；選択肢）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "choice:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):
	print("［命令　選択肢］　前処理だ：[" + line + "]")

	var csv = line.substr(self.code.length()).strip_edges()
	# TODO 数は昇順であること
	var string_packed_array = csv.split(",", true, 0)
	# FIXME 変数展開には対応してない
	# 文字列パック配列を、数値の配列に変換
	var number_array = self.convert_string_packed_array_to_number_array(string_packed_array)

	self.monkey().scenario_player().get_current_message_window_gui_node().choices_row_numbers = number_array

	# カーソル位置の初期化
	self.monkey().scenario_player().get_current_message_window_gui_node().reset_cursor_position()


# 文字列パック配列を、数値の配列に変換
func convert_string_packed_array_to_number_array(string_packed_array):
	var size = string_packed_array.size()
	# print("［命令　選択肢］　選択肢サイズ：" + str(size))

	# 文字列型の配列を、数の配列に変換
	var row_numbers = []
	row_numbers.resize(size)
	
	# print("［命令　選択肢］　行番号一覧")
	for i in range(0, size):
		row_numbers[i] = string_packed_array[i].to_int()
		# print(str(row_numbers[i])
	
	return row_numbers
