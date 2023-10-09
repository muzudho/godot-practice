#	ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


#	それをする
func do_it(
	temp_text,
	get_choice_row_number_array,
	set_choice_row_number_array,
	set_message_window_waiting_for_order):

	print("［ノーマル・テキスト・チョイス］　選択肢だ：[" + temp_text + "]")

	# この台詞は選択肢として扱う
	$"../../GuiArtist/WindowsOfMessage".push_choices(get_choice_row_number_array.call(), temp_text)
	set_message_window_waiting_for_order.call(false)

	#	処理終わり
	set_choice_row_number_array.call(null)
