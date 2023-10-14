#	ゴートゥー（Go to；～へ行く）
extends Node


# 関数の変数
var assistant_director_change_paragraph = null
var assistant_director_play_paragraph = null
var assistant_director_get_current_message_window = null


# それをする
func do_it(
	line):				# str

	# 次の段落名
	var next_paragraph_name = line.substr(5).strip_edges()
	print("［ゴートゥー］　次の段落：[" + next_paragraph_name + "]")
	
	# メッセージ・ウィンドウの状態が Completed で止まってるとフリーズするから、強制解除
	print("［ゴートゥー］　メッセージ・ウィンドウの状態が Completed で止まってるとフリーズするから、強制的にオール・ページズ・フラッシュド")
	self.assistant_director_get_current_message_window.call().statemachine_of_message_window.all_pages_flushed()

	self.assistant_director_change_paragraph.call(next_paragraph_name)
	self.assistant_director_play_paragraph.call()
