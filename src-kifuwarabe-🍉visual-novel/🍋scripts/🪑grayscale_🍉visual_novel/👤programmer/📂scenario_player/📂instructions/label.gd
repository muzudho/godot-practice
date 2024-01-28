# ラベル（Label；ラベル）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "label:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　ラベル］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	# 例： `Ｔ戦闘シーン/玉の遠さ_上`
	var node_path_str = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())
	var its_text = ""	# 空文字列
	
	if 2 <= string_packed_array.size():
		its_text = self.monkey().owner_node().expand_variables(string_packed_array[1].strip_edges())
		its_text = StringHelper.trim_double_quotation(its_text)

	self.set_label(node_path_str, its_text)


# ラベル設定
func set_label(
		node_path_str,	# str. 例： `Ｔ戦闘シーン/玉の遠さ_上`
		its_text):

	print("［命令　ラベル］　ノード名：[" + node_path_str + "]　テキスト：［" + its_text + "］")
	
	var label_node = self.monkey().owner_node().telops.find_node(node_path_str)

	if label_node == null:
		print("［命令　ラベル］　▲エラー　テロップに ”" + node_path_str + "” ノードが無い")
		return
	
	label_node.text = its_text
