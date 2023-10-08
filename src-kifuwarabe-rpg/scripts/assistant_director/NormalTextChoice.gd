#	ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


#	それをする
func do_it(
	temp_text,
	get_choice_row_number_array,
	set_choice_row_number_array,
	set_message_window_waiting_for_order):
		
	print("［アシスタント・ディレクター］　選択肢だ：[" + temp_text + "]")

	# 表示
	$"../../Windows".show()
	$"../../Windows/Message".show()
	$"../../Windows/Message".show_choice_cursor()

	# この台詞は選択肢として扱う
	$"../../Windows/Message".push_choices(get_choice_row_number_array.call(), temp_text)
	set_message_window_waiting_for_order.call(false)

	#	処理終わり
	set_choice_row_number_array.call(null)
