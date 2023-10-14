#	ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


#	関数の変数
var director_get_current_snapshot = null
var snapshot_set_message_window_waiting_for_order = null


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(temp_text):
	self.put_message(temp_text)


#	メッセージの追加
func put_message(temp_text):
	
	var snapshot = self.director_get_current_snapshot.call()
	var manager = snapshot.get_manager()
	
	manager.remember(temp_text)
	manager.talk()
	
	self.snapshot_set_message_window_waiting_for_order.call(false)
