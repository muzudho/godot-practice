# イメグ（Img, Image；画像）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "img:"


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


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　画像］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.hub().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.hub().expand_variables(string_packed_array[1].strip_edges())
	
	if sub_command == "hide":
		self.hide_image(node_name)
		return
	
	self.show_image(node_name)


#	ウィンドウを表示する
func show_image(node_name):
	var node = self.hub().images.find_node(node_name)
	
	if node == null:
		print("［画像　表示］　▲！エラー　❝" + node_name + "❞ノードが見つかりません")
		return
	
	print("［画像　表示］　❝" + node_name + "❞ノード")
	node.show()


#	ウィンドウを非表示にする
func hide_image(node_name):
	var node = self.hub().images.find_node(node_name)

	if node == null:
		print("［画像　非表示］　▲！エラー　❝" + node_name + "❞ノードが見つかりません")
		return
	
	print("［画像　非表示］　❝" + node_name + "❞ノード")
	node.hide()
