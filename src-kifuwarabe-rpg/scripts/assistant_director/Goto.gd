#	ゴートゥー（Go to；～へ行く）
extends Node


# それをする
func do_it(
	line,					# str
	play_paragraph):		# func

	# 次の段落名
	var next_paragraph_name = line.substr(5).strip_edges()
	print("［ゴートゥー］　次の段落：[" + next_paragraph_name + "]")
	
	play_paragraph.call(next_paragraph_name)
