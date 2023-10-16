# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# メッセージの追加
	var snapshot = self.get_director().get_current_snapshot.call()
	snapshot.remember(temp_text)

	# 会話の開始
	var manager = $"../../../Director".get_department_manager()
	manager.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
