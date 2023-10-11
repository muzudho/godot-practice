#	シーン（Scene；場面）
#		撮影場所変更
extends Node


#	それをする
func do_it(line):

	var location_node_name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + location_node_name + "]")

	if location_node_name == "":
		$"../../LocationCoordinator".hide_current_scene("VisualNovelDepartment")
	else:
		$"../../LocationCoordinator".show_scene("VisualNovelDepartment", location_node_name)
