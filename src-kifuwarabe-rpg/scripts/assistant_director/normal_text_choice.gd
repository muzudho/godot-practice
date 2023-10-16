# ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# それをする
func do_it(
		temp_text):		# str

	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# メッセージ追加
	var snapshot = self.get_director().get_current_snapshot()
	print("［ノーマル・テキスト・チョイス］　部門：［" + str(snapshot.name) + "］　メッセージ：[" + temp_text + "]")

	snapshot.remember(temp_text)

	# 会話開始
	self.get_director().get_message_window().statemachine_of_message_window.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
