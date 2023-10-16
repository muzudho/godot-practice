#	ビージー（Bg, Background；背景）
#		背景画像の変更
extends Node


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


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

	if sub_command == "hide":
		# 背景画像非表示
		$"../../BackgroundArtist".get_node(node_name).hide()
		return

	# 背景画像表示
	$"../../BackgroundArtist".get_node(node_name).show()
