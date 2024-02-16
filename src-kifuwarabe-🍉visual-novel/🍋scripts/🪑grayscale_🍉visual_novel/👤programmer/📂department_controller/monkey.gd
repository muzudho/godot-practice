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


# 入力取得
func input_node():
	return $"../🕹️Input"


# 内部取得
func internal_node():
	return $"../🚪Internal"
