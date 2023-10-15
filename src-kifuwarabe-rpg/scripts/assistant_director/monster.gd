# モンスター（Monster；怪物）
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(8).strip_edges()
	print("［背景］　ノード名：[" + node_name + "]")

	# 背景設定
	$"../../MonsterTrainer".get_node(node_name).show()
