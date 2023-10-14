# ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


# 関数の変数
var director_get_current_snapshot = null


# メッセージ・ウィンドウ取得
func get_message_window(
		message_window_name_obj):	# StringName

	return $"../../GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))


func set_director_get_current_snapshot_subtree(it):
		self.director_get_current_snapshot = it


# それをする
func do_it(
		temp_text):		# str

	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# メッセージ追加
	var snapshot = self.director_get_current_snapshot.call()
	print("［ノーマル・テキスト・チョイス］　部門：［" + str(snapshot.name) + "］　メッセージ：[" + temp_text + "]")

	snapshot.remember(temp_text)

	# 会話開始
	# TODO 簡単に書けないか？
	var message_window = self.get_message_window(str(snapshot.message_window_name_obj))
	message_window.statemachine_of_message_window.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
