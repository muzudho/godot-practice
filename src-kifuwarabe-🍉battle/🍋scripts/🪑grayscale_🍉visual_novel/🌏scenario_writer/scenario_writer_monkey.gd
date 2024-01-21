# シナリオ・ライター・ハブ（Scenario Writer Hub；台本書きの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 自身取得
func monkey():
	return self


# 監督ハブ取得
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# シナリオライター取得
func owner_node():
	return self.get_node("../../👤ScenarioWriter")


# 部門切替取得
func department_control():
	return self.owner_node().get_node("📘DepartmentControl")
