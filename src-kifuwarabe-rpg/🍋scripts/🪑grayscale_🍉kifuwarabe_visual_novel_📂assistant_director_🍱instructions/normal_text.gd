# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# 助監
func get_assistant_director():
	return $"../../../AssistantDirector"


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# 変数展開
	temp_text = self.get_assistant_director().expand_variables(temp_text.strip_edges())

	# メッセージの追加
	var snapshot = self.get_assistant_director().get_director().get_current_snapshot()
	var message_window_gui = self.get_assistant_director().get_director().get_current_message_window_gui()

	message_window_gui.remember(temp_text)

	# 会話の開始
	self.get_assistant_director().get_director().get_current_message_window_gui().statemachine_of_message_window.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
