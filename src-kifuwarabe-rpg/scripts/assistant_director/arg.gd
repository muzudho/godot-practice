# オーギュ, オーギュメント（Arg, Argument；実引数）
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(4).strip_edges()
	print("［ＢＧＭ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	# 変数展開はしません
	var key = string_packed_array[0].strip_edges()
	var value = null
	
	if 2 <= string_packed_array.size():
		value = string_packed_array[1].strip_edges()

		self.set_arg(key, value)
		return

	if key == "%clear%":
		self.clear_arg()


# 実引数の記憶
func set_arg(key, value):
	print("［実引数］　（" + key + "）[" + value + "]")
	self.get_director().instruction_arguments[key] = value


# 実引数のクリアー
func clear_arg():
	print("［実引数］　クリアー")
	self.get_director().instruction_arguments = {}
