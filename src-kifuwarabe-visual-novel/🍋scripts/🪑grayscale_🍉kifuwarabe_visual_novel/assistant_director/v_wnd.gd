# ブイ・ワンド、ビューイング・ウィンドウ（V-Wnd, Viewing Window；覗き窓）
extends Node


# 助監
func get_assistant_director():
	return $"../../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［命令　覗き窓］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var position = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	var node_name = null
		
	if 2 <= string_packed_array.size():
		node_name = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())
	
	self.show_viewing_window(position, node_name)


func show_viewing_window(position, node_name):
	print("［命令　覗き窓］　配置：[" + position + "]　ノード名：[" + str(node_name) + "]")

	if node_name == null:
		self.get_assistant_director().get_viewing_windows().hide_window()
	else:
		self.get_assistant_director().get_viewing_windows().show_window(node_name)
