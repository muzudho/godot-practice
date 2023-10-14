# チョイス（Choice；選択肢）
extends Node


# 関数の変数
var director_get_current_snapshot = null


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


# それをする
func do_it(line):
	print("［選択肢］　前処理だ：[" + line + "]")
	
	var csv = line.substr(7).strip_edges()
	# TODO 数は昇順であること
	var string_packed_array = csv.split(",", true, 0)
	# 文字列パック配列を、数値の配列に変換	
	var number_array = self.convert_string_packed_array_to_number_array(string_packed_array)
	
	# 設定
	var snapshot = self.director_get_current_snapshot.call()
	snapshot.choices_row_number_array = number_array


# 文字列パック配列を、数値の配列に変換
func convert_string_packed_array_to_number_array(string_packed_array):
	var size = string_packed_array.size()
	# print("［メッセージ・ウィンドウ］　選択肢サイズ：" + str(size))

	# 文字列型の配列を、数の配列に変換
	var row_numbers = []
	row_numbers.resize(size)
	
	# print("［メッセージ・ウィンドウ］　行番号一覧")
	for i in range(0, size):
		row_numbers[i] = string_packed_array[i].to_int()
		# print(str(row_numbers[i])
	
	return row_numbers
