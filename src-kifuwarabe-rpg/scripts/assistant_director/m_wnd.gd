# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


# アシスタント・ディレクター取得
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var node_name = line.substr(6).strip_edges()
	print("［メッセージ・ウィンドウ制御］　ノード名：[" + node_name + "]")

	self.get_assistant_director().get_message_window(node_name).redirect_me()
