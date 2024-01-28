# モンキー（Monkey；猿）
#
#	木登りが得意
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# キー・コンフィグ取得
func owner_key_config_node():
	return $"../../📂🍉KeyConfig"


# 時計取得
func clock():
	return $"../⌚Clock"


# ディスプレイ取得
func display():
	return $"../🖥️Display"


# モデレーター取得
func moderator():
	return $"../Moderator"


# 入力のためのパーサー
func parser_for_input():
	return $"../🅿ParserForInput"


# 状態遷移機械取得
func statemachine():
	return $"../🍇Statemachine"


# プログラマー・ノード取得
func the_programmer_node():
	return self.owner_key_config_node().monkey_of_staff().programmer().owner_node()


# イラストレーター・ノード取得
func the_illustrator_node():
	return self.owner_key_config_node().monkey_of_staff().illustrator_node()


# （外ノード）テロップ取得
func the_telop_canvas_layer():
	return self.the_programmer_node().telops.find_node("Ｔキーコンフィグ")


# （外ノード）テロップ取得
func get_my_telop(node_name_str):
	return self.the_telop_canvas_layer().get_node(node_name_str)
