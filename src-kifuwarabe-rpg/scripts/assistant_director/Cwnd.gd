#	シーワンド、センター・ウィンドウ（Cwnd, Center Window；中央窓）
extends Node


#	それをする
func do_it(line):
	# head
	var name = line.substr(5).strip_edges()
	print("［センター・ウィンドウ］　名前：[" + name + "]")
	
	if name == "":
		$"../../Windows/センター".hide_window()
	else:
		$"../../Windows/センター".show_window(name)
