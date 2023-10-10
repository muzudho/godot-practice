#	ブイ・ワンド、ビューイング・ウィンドウ（V-Wnd, Viewing Window；覗き窓）
extends Node


#	それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	var string_packed_array = csv.split(",", true, 0)

	#	現状、常に　”中央”　が入っている想定
	var position = string_packed_array[0]
	
	var node_name = string_packed_array[1]
	self.show_viewing_window(position, node_name)


#	`position` - 現状、常に　”中央”　が入っている想定
func show_viewing_window(position, node_name):
	print("［ビューイング・ウィンドウ］　配置：[" + position + "]　ノード名：[" + node_name + "]")

	if node_name == "":
		$"../../GuiArtist/WindowsOfViewing".hide_window()
	else:
		$"../../GuiArtist/WindowsOfViewing".show_window(node_name)
