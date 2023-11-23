# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


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
func get_musician_bg_musics():
	return self.get_director().get_node("🌏Musician_BgMusics")


# SE取得
func get_musician_sound_fx():
	return self.get_director().get_node("🌏Musician_SoundFX")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("🌏TelopCoordinator")


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 背景ノードのキャッシュ
var bg_images = null

# BGMノードのキャッシュ
var bg_musics = null

# イラスト・ノードのキャッシュ
var images = null

# サウンド・エフェクト（Sound Effect, Sound FX；効果音）のキャッシュ
var sound_fx = null

# テロップのキャッシュ
var telops = null
