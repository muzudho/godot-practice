#	エムエスジー、メッセージ（Msg, Message；伝言）
#		どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


#	それをする
func do_it(line, redirect_concrete_message_window_by_name):

	var node_name = line.substr(4).strip_edges()
	print("［メッセージ出力先ウィンドウ変更］　ノード名：[" + node_name + "]")
	
	redirect_concrete_message_window_by_name.call(node_name)
