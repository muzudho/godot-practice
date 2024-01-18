# オーギュ, オーギュメント（Arg, Argument；実引数）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "var:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　変数］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	# 第１引数は、変数展開しない
	var key = string_packed_array[0].strip_edges()
	var value = null

	if 2 <= string_packed_array.size():
		# 第２引数は、変数展開する
		value = self.hub().expand_variables(string_packed_array[1].strip_edges())

		self.set_var(key, value)
		return

	if key == "%clear%":
		self.clear_var()


# 変数の記憶
func set_var(key, value):
	print("［命令　変数］　（" + key + "）[" + value + "]")
	self.hub().get_director_hub().owner_node().stage_directions_variables[key] = value


# 変数のクリアー
func clear_var():
	print("［命令　変数］　クリアー")
	self.hub().get_director_hub().owner_node().stage_directions_variables = {}
