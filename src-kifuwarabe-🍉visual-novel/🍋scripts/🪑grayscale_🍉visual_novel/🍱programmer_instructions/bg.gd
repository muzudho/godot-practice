#	ビージー（Bg, Background；背景）
#		背景画像の変更
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


# ーーーーーーーー
# その他
# ーーーーーーーー


#	それをする
func do_it(line):

	var csv = line.substr("bg:".length()).strip_edges()
	print("［命令解析　背景］　CSV：[" + csv + "]　Line：[" + line + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.hub().expand_variables(string_packed_array[0])
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.hub().expand_variables(string_packed_array[1].strip_edges())

	if sub_command == "hide":
		self.hide_bg(node_name)
		return

	self.show_bg(node_name)


# 背景画像表示
func show_bg(node_name):

	var node = self.hub().get_background_image(node_name)
	if node == null:
		print("［命令　背景］　▲エラー　”" + node_name + "”　が無い")

	print("［命令　背景］　表示　指定ノード名：❝" + node_name + "❞　検索結果ノードの名前：❝" + node.name + "❞")
	node.show()

# 背景画像非表示
func hide_bg(node_name):

	var node = self.hub().get_background_image(node_name)
	if node == null:
		print("［命令　背景］　▲エラー　”" + node_name + "”　が無い")

	print("［命令　背景］　非表示　指定ノード名：❝" + node_name + "❞　検索結果ノードの名前：❝" + node.name + "❞")
	node.hide()
