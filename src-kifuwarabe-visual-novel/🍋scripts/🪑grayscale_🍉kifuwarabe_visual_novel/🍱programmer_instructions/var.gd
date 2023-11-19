# オーギュ, オーギュメント（Arg, Argument；実引数）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"../../🛩️ProgramsHub"


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr("var:".length()).strip_edges()
	print("［命令　変数］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	# 変数展開はしません
	var key = string_packed_array[0].strip_edges()
	var value = null
	
	if 2 <= string_packed_array.size():
		value = string_packed_array[1].strip_edges()

		self.set_var(key, value)
		return

	if key == "%clear%":
		self.clear_var()


# 変数の記憶
func set_var(key, value):
	print("［命令　変数］　（" + key + "）[" + value + "]")
	self.hub().get_director().stage_directions_variables[key] = value


# 変数のクリアー
func clear_var():
	print("［命令　変数］　クリアー")
	self.hub().get_director().stage_directions_variables = {}
