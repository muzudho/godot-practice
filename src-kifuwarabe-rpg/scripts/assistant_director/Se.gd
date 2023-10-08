#	エスイー（SE, Sound Effects；効果音）
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(3).strip_edges()
	print("［効果音］　ノード名：[" + node_name + "]")

	if node_name == "":
		# 効果音 停止
		$"../../Musician".stopSe()
		
	else:
		# 効果音 再生
		$"../../Musician".playSe(node_name)
