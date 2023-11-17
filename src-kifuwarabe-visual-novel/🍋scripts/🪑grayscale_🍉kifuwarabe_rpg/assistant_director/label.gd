# ラベル（Label；ラベル）
extends Node


func get_root_relative_path_str():
	return "../../../"


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［命令　ラベル］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	node_name = get_root_relative_path_str() + node_name
	var its_text = ""	# 空文字列
	
	if 2 <= string_packed_array.size():
		its_text = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())
		its_text = self.get_assistant_director().trim_double_quotation(its_text)

	self.set_label(node_name, its_text)


# ラベル設定
func set_label(node_name, its_text):
	print("［命令　ラベル］　ノード名：[" + node_name + "]　テキスト：［" + its_text + "］")
	
	var label_node = self.get_node(node_name)
	if label_node == null:
		print("［命令　ラベル］　▲エラー　”" + node_name + "”　が無い")
		return
	
	label_node.text = its_text
