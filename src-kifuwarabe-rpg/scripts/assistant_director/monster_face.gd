# モンスター・フェース（Monster Face；怪物顔）
extends Node


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# モンスター・フェースズ
func get_monster_faces():
	return $"../../MonsterTrainer/Faces"


# それをする
func do_it(line):

	var csv = line.substr(13).strip_edges()
	print("［命令　怪物顔］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0])
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())

	self.control_monster_face(node_name, sub_command)


# モンスターを制御
func control_monster_face(node_name, sub_command):

	var monster_node = self.get_monster_faces().get_node(node_name)
	if monster_node == null:
		print("［命令　怪物顔］　▲エラー　”" + node_name + "”　が無い")

	if sub_command == "hide":
		# モンスター画像非表示
		print("［命令　怪物顔］　隠す：[" + node_name + "]")
		monster_node.hide()
		return

	# モンスター画像表示
	print("［命令　怪物顔］　見せる：[" + node_name + "]")
	monster_node.show()
