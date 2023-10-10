#	ブイ・ワンド、ビューイング・ウィンドウ（V-Wnd, Viewing Window；覗き窓）
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(6).strip_edges()
	print("［ビューイング・ウィンドウ］　名前：[" + node_name + "]")

	if node_name == "":
		$"../../GuiArtist/WindowsOfViewing".hide_window()
	else:
		$"../../GuiArtist/WindowsOfViewing".show_window(node_name)
