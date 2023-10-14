# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


# 関数
var redirect_concrete_message_window_by_name = null


func before_initialize(redirect_concrete_message_window_by_name):
	self.redirect_concrete_message_window_by_name = redirect_concrete_message_window_by_name


# それをする
func do_it(line):

	var node_name = line.substr(6).strip_edges()
	print("［メッセージ出力先ウィンドウ変更］　ノード名：[" + node_name + "]")
	
	self.redirect_message_window(node_name)


func redirect_message_window(node_name):
	self.redirect_concrete_message_window_by_name.call(node_name)
