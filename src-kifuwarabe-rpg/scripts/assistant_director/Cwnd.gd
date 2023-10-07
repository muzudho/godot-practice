#	シーワンド、センター・ウィンドウ（Cwnd, Center Window；中央窓）
extends Node


#	それをする
func do_it(line):
	# head
	var name = line.substr(5).strip_edges()
	print("［センター・ウィンドウ］　名前：[" + name + "]")
	
	if name == "":
		$"../../CenterWindow".hide_window()
	else:
		$"../../CenterWindow".show_window(name)
