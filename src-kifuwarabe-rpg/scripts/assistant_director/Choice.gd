# チョイス（Choice；選択肢）
extends Node


# 選択肢用の行番号配列。無ければヌル
var choice_row_number_array = null


func get_choice_row_number_array():
	return self.choice_row_number_array


func set_choice_row_number_array(array):
	self.choice_row_number_array = array


#	それをする
func do_it(line):
	print("［選択肢］　前処理だ：[" + line + "]")
	
	var csv = line.substr(7).strip_edges()
	# TODO 数は昇順であること
	var string_packed_array = csv.split(",", true, 0)
	# 文字列パック配列を、数値の配列に変換
	self.choice_row_number_array = self.convert_string_packed_array_to_number_array(string_packed_array)


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
