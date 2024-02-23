# モンキー（Monkey；猿）
#
#	木登りが得意
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# スタッフの猿取得
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# キー・コンフィグ取得
func owner_key_config_node():
	return $"../../🎬🍉KeyConfig"


# 時計取得
func clock_node():
	return $"../⌚Clock"


# ディスプレイ取得
func display_node():
	return $"../🖥️Display"


# 入力取得
func input_node():
	return $"../🕹️Input"


# 内部取得
func internal_node():
	return $"../🚪Internal"


# 入力のためのパーサー
func input_parser_node():
	return $"../🕹️Input/🅿Parser"


# 状態遷移機械取得
func statemachine_node():
	return $"../🍇Statemachine"


# プログラマー・ノード取得
func the_programmer_node():
	return self.of_staff().programmer().owner_node()


# イラストレーター・ノード取得
func the_illustrator_node():
	return self.of_staff().illustrator_node()


# （外ノード）テロップ取得
func the_telop_canvas_layer_node():
	return self.the_programmer_node().telops.find_node("Ｔキーコンフィグ")


# （外ノード）テロップ取得
func get_my_telop_node(node_name_str):
	return self.the_telop_canvas_layer_node().get_node(node_name_str)
