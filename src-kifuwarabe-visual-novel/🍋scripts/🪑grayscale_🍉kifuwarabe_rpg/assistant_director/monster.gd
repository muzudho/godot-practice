# モンスター（Monster；怪物）
extends Node


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# モンスターの全身像
func get_monster_whole_body():
	return $"../../MonsterTrainer/WholeBody"


# それをする
func do_it(line):

	var csv = line.substr(8).strip_edges()
	print("［命令　怪物］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0])
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())

	self.control_monster(node_name, sub_command)


# モンスターを制御
func control_monster(node_name, sub_command):

	var monster_node = self.get_monster_whole_body().get_node(node_name)
	if monster_node == null:
		print("［命令　怪物］　▲エラー　”" + node_name + "”　が無い")

	if sub_command == "hide":
		# モンスター画像非表示
		monster_node.hide()
		return

	# モンスター画像表示
	monster_node.show()
