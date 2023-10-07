#	シーン（Scene；場面）
extends Node


#	それをする
func do_it(line):
	# head
	var name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + name + "]")
	
	if name == "":
		$"../../Scenes".hide_scene()
	else:
		$"../../Scenes".show_scene(name)
