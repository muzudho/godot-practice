#	ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


#	関数の変数
var director_get_current_snapshot = null
var get_choice_row_number_array = null
var set_choice_row_number_array = null
var snapshot_set_message_window_waiting_for_order = null


#	メッセージ・ウィンドウ取得
func get_message_window(
	message_window_name_obj):	# StringName
	return $"../../GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))


#	スナップショット取得
func get_snapshot(department_name):
	return $"../../System/Snapshots".get_node(department_name)


#	初期化の前に
func before_initialize(
	get_choice_row_number_array,
	set_choice_row_number_array,
	snapshot_set_message_window_waiting_for_order):
	
	self.get_choice_row_number_array = get_choice_row_number_array
	self.set_choice_row_number_array = set_choice_row_number_array
	self.snapshot_set_message_window_waiting_for_order = snapshot_set_message_window_waiting_for_order


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(
	temp_text):				# str
	
	var snapshot = self.director_get_current_snapshot.call()
		
	var message_window_name_obj = self.get_snapshot(str(snapshot.name)).message_window_name_obj
	self.push_message(message_window_name_obj, temp_text, self.get_choice_row_number_array.call())


func push_message(
	message_window_name_obj,	# StringName
	temp_text,					# str
	choice_row_number_array):	# number_array
	print("［ノーマル・テキスト・チョイス］　メッセージ：[" + temp_text + "]")

	# メッセージ追加
	self.get_message_window(message_window_name_obj).statemachine_of_message_window.talk(temp_text, choice_row_number_array)
	
	self.snapshot_set_message_window_waiting_for_order.call(false)
	
	#	処理終わり
	self.set_choice_row_number_array.call(null)
