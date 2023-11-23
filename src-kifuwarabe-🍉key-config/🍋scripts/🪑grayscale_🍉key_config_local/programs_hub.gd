# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	self.background_image_cache = MonkeyHand.create(
			self.get_background_artist())	# 探す場所

	self.bgm_cache = MonkeyHand.create(
			self.get_musician_bgm())		# 探す場所

	self.illust_cache = MonkeyHand.create(
			self.get_illustrator())			# 探す場所

	self.se_cache = MonkeyHand.create(
			self.get_musician_se())			# 探す場所


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 背景ノードのキャッシュ
var background_image_cache = null

# BGMノードのキャッシュ
var bgm_cache = null

# イラスト・ノードのキャッシュ
var illust_cache = null

# 全SE
var se_cache = {}

# 全テロップ
var cache_dictionary_for_telop = {}


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../🌏Director"


# 背景アーティスト
func get_background_artist():
	return self.get_director().get_node("🌏BackgroundArtist")


# イラストレーター取得
func get_illustrator():
	return self.get_director().get_node("🌏Illustrator")


# BGM取得
func get_musician_bgm():
	return self.get_director().get_node("🌏Musician_BGM")


# SE取得
func get_musician_se():
	return self.get_director().get_node("🌏Musician_SE")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("🌏TelopCoordinator")


# ーーーーーーーー
# 子パス関連
# ーーーーーーーー


# テロップ取得
func get_telop(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_telop_coordinator(),	# 探す場所
			func():
				return self.cache_dictionary_for_telop)	# 結果を格納する変数
