# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# それをする
func do_it(line):

	var node_name = line.substr(6).strip_edges()
	print("［メッセージ・ウィンドウ制御］　ノード名：[" + node_name + "]")

	self.show_me(node_name)


# メッセージ出力先ウィンドウ変更。ノード名を指定
func show_me(node_name):

	var snapshot = self.get_director().get_current_snapshot()

	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　リダイレクトしてきた")

	# 新しいウィンドウ
	snapshot.message_window_name_obj = StringName(node_name)	# StringName 型。 String ではない
