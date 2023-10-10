#	シーン（Scene；場面）
#		撮影場所変更
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + node_name + "]")

	if node_name == "":
		$"../../LocationCoordinator".hide_current_scene()
	else:
		$"../../LocationCoordinator".show_scene(node_name)
