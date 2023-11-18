# ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"../../🛩️ProgramHub"


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(
		temp_text):		# str

	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# 変数展開
	temp_text = self.hub().expand_variables(temp_text.strip_edges())

	# メッセージ追加
	var snapshot = self.hub().get_director().get_current_snapshot()
	var message_window_gui = self.hub().get_director().get_current_message_window_gui()

	print("［命令　選択肢テキスト］　部門：［" + str(snapshot.name) + "］　メッセージ：[" + temp_text + "]")

	message_window_gui.remember(temp_text)

	# 会話開始
	self.hub().get_director().get_current_message_window_gui().statemachine_of_message_window.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
