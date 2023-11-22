# テロップ（Telop, Television opaque projector；テレビ投射映像機）
#	撮影場所変更
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ProgramsHub")


# 部門変数取得
func get_department_value(department_node_name):
	return self.hub().get_director().get_department_value(department_node_name)


# ーーーーーーーー
# その他
# ーーーーーーーー


#	それをする
func do_it(line):

	var csv = line.substr("telop:".length()).strip_edges()
	print("［命令　テロップ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.hub().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.hub().expand_variables(string_packed_array[1].strip_edges())
	
	if sub_command == "hide":
		# テロップを隠す
		self.hide_telop(node_name)
		return
	
	self.show_telop(node_name)


# テロップを見せる
func show_telop(node_name):
	
	var telop_node = self.hub().get_telop(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")
	
	telop_node.show()


# テロップを隠す
func hide_telop(node_name):
	
	var telop_node = self.hub().get_telop(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")

	telop_node.hide()
