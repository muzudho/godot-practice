# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# 変数展開
	temp_text = self.get_assistant_director().expand_variables(temp_text.strip_edges())

	# メッセージの追加
	var snapshot = self.get_director().get_current_snapshot()
	snapshot.remember(temp_text)

	# 会話の開始
	self.get_director().get_current_message_window().statemachine_of_message_window.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
