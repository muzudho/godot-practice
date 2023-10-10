#	ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


#	関数
var get_choice_row_number_array = null
var set_choice_row_number_array = null
var set_message_window_waiting_for_order = null


#	初期化の前に
func before_initialize(
	get_choice_row_number_array,
	set_choice_row_number_array,
	set_message_window_waiting_for_order):
		
	self.get_choice_row_number_array = get_choice_row_number_array
	self.set_choice_row_number_array = set_choice_row_number_array
	self.set_message_window_waiting_for_order = set_message_window_waiting_for_order


#	それをする
func do_it(temp_text):
	self.redirect_message_window(self.get_choice_row_number_array.call(), temp_text)


func redirect_message_window(choice_row_number_array, temp_text):
	print("［ノーマル・テキスト・チョイス］　選択肢だ：[" + temp_text + "]")

	# この台詞は選択肢として扱う
	$"../../GuiArtist/WindowsOfMessage".push_choices(choice_row_number_array, temp_text)
	
	self.set_message_window_waiting_for_order.call(false)
	
	#	処理終わり
	self.set_choice_row_number_array.call(null)
