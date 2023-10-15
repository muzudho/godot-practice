# モンスター（Monster；怪物）
extends Node


#	それをする
func do_it(line):

	var csv = line.substr(8).strip_edges()
	print("［モンスター］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = string_packed_array[0]
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = string_packed_array[1].strip_edges()

	if sub_command == "hide":
		# モンスター画像非表示
		$"../../MonsterTrainer".get_node(node_name).hide()
		return

	# モンスター画像表示
	$"../../MonsterTrainer".get_node(node_name).show()
