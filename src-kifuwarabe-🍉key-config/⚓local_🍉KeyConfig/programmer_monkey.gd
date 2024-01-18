# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督ハブ取得
func of_director():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🐵Monkey",
			self.ancestors)


# プログラマー取得
func owner_node():
	return self.get_node("../../🌏Programmer")
