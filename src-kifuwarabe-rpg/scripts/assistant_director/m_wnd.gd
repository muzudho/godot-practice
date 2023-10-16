# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［メッセージ・ウィンドウ制御］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = string_packed_array[0]
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = string_packed_array[1].strip_edges()

	if sub_command == "hide":
		# メッセージ・ウィンドウを隠す
		self.hide_me(node_name)
		return

	self.show_me(node_name)


# メッセージ・ウィンドウを見せる
func show_me(node_name):
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　見せる")

	# 新しいウィンドウ
	snapshot.message_window_name_obj = StringName(node_name)	# StringName 型。 String ではない


func hide_me(node_name):
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　隠す")

	# 新しいウィンドウ
	snapshot.message_window_name_obj = null
