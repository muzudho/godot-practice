#	エムエスジー、メッセージ（Msg, Message；伝言）
#		どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


#	それをする
func do_it(line, set_target_message_window_name):

	var node_name = line.substr(4).strip_edges()
	print("［メッセージ］　ノード名：[" + node_name + "]")
	
	set_target_message_window_name.call(node_name)
