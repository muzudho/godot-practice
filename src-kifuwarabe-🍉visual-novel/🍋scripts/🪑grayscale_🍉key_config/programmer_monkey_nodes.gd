# プログラムズ・ハブ・ノーズ（Programs Hub Nodes；プログラム中心地節）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# プログラマー・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🐵Monkey",
			self.ancestors)


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.monkey().bg_musics = MonkeyHand.create(
			self.monkey().of_director().musician_bg_musics())		# 探す場所

	self.monkey().images = MonkeyHand.create(
			self.monkey().of_director().illustrator())			# 探す場所

	self.monkey().sound_fx = MonkeyHand.create(
			self.monkey().of_director().musician_sound_fx())			# 探す場所

	self.monkey().telops = MonkeyHand.create(
			self.monkey().of_director().telop_coordinator())	# 探す場所
