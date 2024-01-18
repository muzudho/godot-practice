# プログラマー（Programmer）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ディレクター・ハブ取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# アドオン・スロット
# ーーーーーーーー


# BGMノードのキャッシュ
var bg_musics = null

# イラスト・ノードのキャッシュ
var images = null

# サウンド・エフェクト（Sound Effect, Sound FX；効果音）のキャッシュ
var sound_fx = null

# テロップのキャッシュ
var telops = null


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.bg_musics = MonkeyHand.create(
			self.monkey().of_director().musician_bg_musics())		# 探す場所

	self.images = MonkeyHand.create(
			self.monkey().of_director().illustrator())			# 探す場所

	self.sound_fx = MonkeyHand.create(
			self.monkey().of_director().musician_sound_fx())			# 探す場所

	self.telops = MonkeyHand.create(
			self.monkey().of_director().telop_coordinator())	# 探す場所
