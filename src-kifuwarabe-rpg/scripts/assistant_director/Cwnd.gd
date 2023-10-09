#	シーワンド、ビューイング・ウィンドウ（Cwnd, Center Viewing Window；中央覗き窓）
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(5).strip_edges()
	print("［中央ビューイング・ウィンドウ］　名前：[" + node_name + "]")

	if node_name == "":
		$"../../GuiArtist/WindowsOfViewing".hide_window()
	else:
		$"../../GuiArtist/WindowsOfViewing".show_window(node_name)
