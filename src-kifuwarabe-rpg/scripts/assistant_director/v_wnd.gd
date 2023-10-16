#	ブイ・ワンド、ビューイング・ウィンドウ（V-Wnd, Viewing Window；覗き窓）
extends Node


#	それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［ビューイング・ウィンドウ制御］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var position = string_packed_array[0].strip_edges()
	var node_name = null
		
	if 2 <= string_packed_array.size():
		node_name = string_packed_array[1].strip_edges()
	
	self.show_viewing_window(position, node_name)


func show_viewing_window(position, node_name):
	print("［ビューイング・ウィンドウ］　配置：[" + position + "]　ノード名：[" + str(node_name) + "]")

	if node_name == null:
		$"../../GuiArtist/WindowsOfViewing".hide_window()
	else:
		$"../../GuiArtist/WindowsOfViewing".show_window(node_name)
