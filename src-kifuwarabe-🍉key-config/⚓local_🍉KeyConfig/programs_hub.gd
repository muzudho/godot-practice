# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


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
# 外パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return MonkeyHelper.find_ancestor(
			self,
			&"🌏Director",
			self.ancestors)


# 監督ハブ取得
func get_director_hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🛩️Hub",
			self.ancestors)


# BGM取得
func get_musician_bg_musics():
	return self.get_director().get_node("🌏Musician/🌏BgMusics")


# SE取得
func get_musician_sound_fx():
	return self.get_director().get_node("🌏Musician/🌏SoundFX")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("🌏TelopCoordinator")
