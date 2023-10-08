#	ビージー（Bg, Background；背景）
extends Node


#	それをする
func do_it(line):
	# head
	var node_name = line.substr(3).strip_edges()
	print("［背景］　名前：[" + node_name + "]")

	# 背景設定
	$"../../Background".show(node_name)
