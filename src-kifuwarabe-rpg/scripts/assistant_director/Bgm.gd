#	ビージーエム（BGM, Background Music；背景音楽）
extends Node


#	それをする
func do_it(line):

	var csv = line.substr(4).strip_edges()
	print("［ＢＧＭ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = string_packed_array[0]
	var from = null
	
	if 2 <= string_packed_array.size():
		from = float(string_packed_array[1])

	if node_name == "":
		# BGM 停止
		$"../../Musician".stopBgm()
		
	else:
		# じゃあ BGM 流すか
		$"../../Musician".playBgm(node_name, from)
