#	エムエスジー、メッセージ（Msg, Message；伝言）
#		どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


#	それをする
func do_it(line, lambda_target_message_window):
	# ノード名
	var node_name = line.substr(4).strip_edges()
	print("［メッセージ］　ノード名：[" + node_name + "]")
	
	lambda_target_message_window.call(node_name)
