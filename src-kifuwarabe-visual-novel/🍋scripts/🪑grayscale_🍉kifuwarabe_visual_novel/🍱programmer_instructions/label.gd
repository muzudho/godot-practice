# ラベル（Label；ラベル）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"../../🛩️ProgramsHub"


func get_root_relative_path_str():
	return "../../../../"


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr("label:".length()).strip_edges()
	print("［命令　ラベル］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.hub().expand_variables(string_packed_array[0].strip_edges())
	node_name = get_root_relative_path_str() + node_name
	var its_text = ""	# 空文字列
	
	if 2 <= string_packed_array.size():
		its_text = self.hub().expand_variables(string_packed_array[1].strip_edges())
		its_text = self.hub().trim_double_quotation(its_text)

	self.set_label(node_name, its_text)


# ラベル設定
func set_label(node_name, its_text):
	print("［命令　ラベル］　ノード名：[" + node_name + "]　テキスト：［" + its_text + "］")
	
	var label_node = self.get_node(node_name)
	if label_node == null:
		print("［命令　ラベル］　▲エラー　”" + node_name + "”　が無い")
		return
	
	label_node.text = its_text
