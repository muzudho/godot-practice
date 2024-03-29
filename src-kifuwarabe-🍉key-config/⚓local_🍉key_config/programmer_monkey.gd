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
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# プログラマー取得
func owner_node():
	return self.get_node("../../👤Programmer")


# 入力取得
func input_node():
	return self.owner_node().get_node("🕹️Input")


# キー・コンフィグ取得
func key_config_node():
	return self.owner_node().get_node("🎬🍉KeyConfig")


# キー・コンフィグの猿取得
func key_config():
	return self.owner_node().get_node("🎬🍉KeyConfig/🐵Monkey")
