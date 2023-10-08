#	シーン（Scene；場面）
extends Node


#	それをする
func do_it(line):
	# head
	var node_name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + node_name + "]")
	
	if node_name == "":
		$"../../Scenes".hide_scene()
	else:
		$"../../Scenes".show_scene(node_name)
