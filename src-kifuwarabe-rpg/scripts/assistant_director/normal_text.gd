# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# 関数の変数
var director_get_current_snapshot_data = null


func set_director_get_current_snapshot_data_subtree(it):
	self.director_get_current_snapshot_data = it


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# メッセージの追加
	var snapshot_data = self.director_get_current_snapshot_data.call()
	snapshot_data.remember(temp_text)

	# 会話の開始
	var manager = $"../../../Director".get_department_manager(str(snapshot_data.name))
	manager.talk()

	# パースをするな
	snapshot_data.set_parse_lock(true)
