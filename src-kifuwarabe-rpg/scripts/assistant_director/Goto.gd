#	ゴートゥー（Go to；～へ行く）
extends Node


# 関数の変数
var assistant_director_change_paragraph = null
var assistant_director_play_paragraph = null


# それをする
func do_it(
	line):				# str

	# 次の段落名
	var next_paragraph_name = line.substr(5).strip_edges()
	print("［ゴートゥー］　次の段落：[" + next_paragraph_name + "]")
	
	self.assistant_director_change_paragraph.call(next_paragraph_name)
	self.assistant_director_play_paragraph.call()
