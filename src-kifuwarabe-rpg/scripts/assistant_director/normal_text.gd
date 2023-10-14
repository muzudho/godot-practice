# ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


# 関数の変数
var director_get_current_snapshot = null


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


# それをする
func do_it(temp_text):
	self.remember(temp_text)
	self.talk()


# メッセージの追加
func remember(temp_text):
	var snapshot = self.director_get_current_snapshot.call()
	snapshot.remember(temp_text)


# 会話の開始
func talk():
	var snapshot = self.director_get_current_snapshot.call()
	var manager = snapshot.get_manager()
	manager.talk()

	# パースを開始するのは待て
	snapshot.set_ready_parse(false)
