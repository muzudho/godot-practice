# テロップ（Telop, Television opaque projector；テレビ投射映像機）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
#
# ラベルよりは大きなかたまり。CanvasLayer
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "telop:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# 部門変数取得
#func get_department_value(department_node_name):
#	return self.monkey().of_staff().owner_node().get_department_value(department_node_name)


# ーーーーーーーー
# その他
# ーーーーーーーー


#	それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　テロップ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.monkey().owner_node().expand_variables(string_packed_array[1].strip_edges())
	
	if sub_command == "hide":
		# テロップを隠す
		self.hide_telop(node_name)
		return
	
	self.show_telop(node_name)


# テロップを見せる
func show_telop(node_name):
	
	var telop_node = self.monkey().owner_node().telops.find_node(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")
	
	telop_node.show()


# テロップを隠す
func hide_telop(node_name):
	
	var telop_node = self.monkey().owner_node().telops.find_node(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")

	telop_node.hide()
