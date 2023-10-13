#	ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


#	関数
var get_choice_row_number_array = null
var set_choice_row_number_array = null
var set_message_window_waiting_for_order = null


#	メッセージ・ウィンドウ取得
func get_message_window(message_window_name):
	return $"../../GuiArtist/WindowsOfMessage".get_node(message_window_name)


#	スナップショット取得
func get_snapshot(department_name):
	return $"../../System/Snapshots".get_node(department_name)


#	初期化の前に
func before_initialize(
	get_choice_row_number_array,
	set_choice_row_number_array,
	set_message_window_waiting_for_order):
	
	self.get_choice_row_number_array = get_choice_row_number_array
	self.set_choice_row_number_array = set_choice_row_number_array
	self.set_message_window_waiting_for_order = set_message_window_waiting_for_order


#	それをする
func do_it(
	temp_text):				# str
	var message_window_name = self.get_snapshot("VisualNovelDepartment").message_window_name
	self.push_message(message_window_name, temp_text, self.get_choice_row_number_array.call())


func push_message(
	message_window_name,		# str
	temp_text,					# str
	choice_row_number_array):	# number_array
	print("［ノーマル・テキスト・チョイス］　メッセージ：[" + temp_text + "]")

	# メッセージ追加
	self.get_message_window(message_window_name).push_message(temp_text, choice_row_number_array)
	
	self.set_message_window_waiting_for_order.call(false)
	
	#	処理終わり
	self.set_choice_row_number_array.call(null)
