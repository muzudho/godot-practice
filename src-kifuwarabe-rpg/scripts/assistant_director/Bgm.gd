#	ビージーエム（BGM, Background Music；背景音楽）
extends Node


#	それをする
func do_it(line):
	# head
	var node_name = line.substr(4).strip_edges()
	print("［ＢＧＭ］　名前：[" + node_name + "]")

	if node_name == "":
		# BGM 停止
		$"../../Musician".stopBgm()
		
	else:
		# じゃあ BGM 流すか
		$"../../Musician".playBgm(node_name)
