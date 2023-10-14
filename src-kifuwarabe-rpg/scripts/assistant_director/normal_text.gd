# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# 関数の変数
var director_get_current_snapshot = null


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# メッセージの追加
	var snapshot = self.director_get_current_snapshot.call()
	snapshot.remember(temp_text)

	# 会話の開始
	var manager = $"../../../Director".get_department_manager()
	manager.talk()

	# パースをするな
	snapshot.set_parse_lock(true)
