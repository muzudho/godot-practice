#	ゴートゥー（Go to；～へ行く）
extends Node


# 関数の変数
var assistant_director_set_current_section = null
var assistant_director_play_section = null


# ディレクター取得
func get_director():
	return $"../../../Director"


# それをする
func do_it(
	line):				# str

	# 次の「§」セクション名
	var next_section_name = line.substr(5).strip_edges()
	print("［ゴートゥー］　次の区画：[" + next_section_name + "]")

	# メッセージ・ウィンドウの状態が Completed で止まってるとフリーズするから、強制解除
	print("［ゴートゥー］　メッセージ・ウィンドウの状態が Completed で止まってるとフリーズするから、強制的にオール・ページズ・フラッシュド")
	self.get_director().get_current_message_window().statemachine_of_message_window.all_pages_flushed()

	self.get_director().set_current_section(next_section_name)
	self.assistant_director_play_section.call()
