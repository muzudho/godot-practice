# ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


# 関数の変数
var director_get_current_snapshot = null
var snapshot_set_message_window_waiting_for_order = null


# メッセージ・ウィンドウ取得
func get_message_window(
	message_window_name_obj):	# StringName
	return $"../../GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))


# 初期化の前に
func before_initialize(
	snapshot_set_message_window_waiting_for_order):
	
	self.snapshot_set_message_window_waiting_for_order = snapshot_set_message_window_waiting_for_order


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(
	temp_text):		# str
	
	self.push_message(temp_text)


func push_message(
	temp_text):		# str

	var snapshot = self.director_get_current_snapshot.call()

	print("［ノーマル・テキスト・チョイス］　部門：［" + str(snapshot.name) + "］　メッセージ：[" + temp_text + "]")


	# メッセージ追加、会話
	var message_window = self.get_message_window(str(snapshot.message_window_name_obj))
	message_window.statemachine_of_message_window.remember(temp_text)
	message_window.statemachine_of_message_window.talk_2()
	
	self.snapshot_set_message_window_waiting_for_order.call(false)
	
