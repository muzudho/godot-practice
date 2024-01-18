# プログラムズ・ハブ・ノーズ（Programs Hub Nodes；プログラム中心地節）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🐵Monkey",
			self.ancestors)


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.hub().message_window_programs = MonkeyHand.create(
			self.hub().get_director_hub().gui_programmer_message_windows())			# 探す場所
