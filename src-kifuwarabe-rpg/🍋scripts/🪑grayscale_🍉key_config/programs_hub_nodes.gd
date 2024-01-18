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
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🐵Monkey",
			self.ancestors)


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.hub().bg_musics = MonkeyHand.create(
			self.hub().get_director_hub().musician_bg_musics())		# 探す場所

	self.hub().images = MonkeyHand.create(
			self.hub().get_director_hub().illustrator())			# 探す場所

	self.hub().sound_fx = MonkeyHand.create(
			self.hub().get_director_hub().musician_sound_fx())			# 探す場所

	self.hub().telops = MonkeyHand.create(
			self.hub().get_director_hub().telop_coordinator())	# 探す場所
