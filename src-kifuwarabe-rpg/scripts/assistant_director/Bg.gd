#	ビージー（Bg, Background；背景）
#		背景画像の変更
extends Node


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# 背景アーティスト
func get_background_artist():
	return $"../../BackgroundArtist"


#	それをする
func do_it(line):

	var csv = line.substr(3).strip_edges()
	print("［背景］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_param(string_packed_array[0])
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_param(string_packed_array[1].strip_edges())

	self.control_bg(node_name, sub_command)


# 背景を制御
func control_bg(node_name, sub_command):

	var node = self.get_background_artist().get_node(node_name)
	if node == null:
		print("［背景］　▲エラー　”" + node_name + "”　が無い")

	if sub_command == "hide":
		# 背景画像非表示
		node.hide()
		return

	# 背景画像表示
	self.get_background_artist().get_node(node_name).show()
