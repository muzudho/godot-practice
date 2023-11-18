# イメグ（Img, Image；画像）
extends Node


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


func get_illustrator():
	return $"../../Illustrator"


# それをする
func do_it(line):

	var csv = line.substr("img:".length()).strip_edges()
	print("［命令　画像］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())
	
	if sub_command == "hide":
		self.hide_image(node_name)
		return
	
	self.show_image(node_name)


#	ウィンドウを表示する
func show_image(node_name):
	var node = self.get_illustrator().get_node(node_name)
	
	if node == null:
		print("［画像　表示］　▲！エラー　❝" + node_name + "❞ノードが見つかりません")
		return
	
	print("［画像　表示］　❝" + node_name + "❞ノード")
	node.show()


#	ウィンドウを非表示にする
func hide_image(node_name):
	var node = self.get_illustrator().get_node(node_name)

	if node == null:
		print("［画像　非表示］　▲！エラー　❝" + node_name + "❞ノードが見つかりません")
		return
	
	print("［画像　非表示］　❝" + node_name + "❞ノード")
	node.hide()
