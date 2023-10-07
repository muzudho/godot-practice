#	エスイー（SE, Sound Effects；効果音）
extends Node


#	それをする
func do_it(line):
	# head
	var name = line.substr(3).strip_edges()
	print("［効果音］　ノード名：[" + name + "]")

	if name == "":
		# 効果音 停止
		$"../../Musician".stopSe()
		
	else:
		# 効果音 再生
		$"../../Musician".playSe(name)
