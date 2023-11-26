# プログラムズ・ハブ・ノーズ（Programs Hub Nodes；プログラム中心地節）
extends Node


# ーーーーーーーー
# 共通メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.hub().bg_musics = MonkeyHand.create(
			self.hub().get_musician_bg_musics())		# 探す場所

	self.hub().images = MonkeyHand.create(
			self.hub().get_illustrator())			# 探す場所

	self.hub().message_window_programs = MonkeyHand.create(
			self.hub().get_gui_programmer_message_windows())			# 探す場所

	self.hub().sound_fx = MonkeyHand.create(
			self.hub().get_musician_sound_fx())			# 探す場所

	self.hub().telops = MonkeyHand.create(
			self.hub().get_telop_coordinator())	# 探す場所


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🛩️Hub",
			self.ancestors)
