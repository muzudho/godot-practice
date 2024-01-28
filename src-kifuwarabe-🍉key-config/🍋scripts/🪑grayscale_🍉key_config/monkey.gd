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


# モデレーター取得
func moderator():
	return $"../Moderator"


# 状態遷移機械取得
func statemachine():
	return $"../🍇Statemachine"


# プログラマー・ノード取得
func the_programmer_node():
	return self.owner_key_config_node().monkey_of_staff().programmer().owner_node()


# イラストレーター・ノード取得
func the_illustrator_node():
	return self.owner_key_config_node().monkey_of_staff().illustrator_node()
