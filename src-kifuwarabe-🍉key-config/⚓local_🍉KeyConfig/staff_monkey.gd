# ディレクター・ハブ（Staff Hub）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督取得
func owner_node():
	return self.get_node("../../👥Staff")


# グリッド取得
func grid():
	return self.owner_node().get_node("Grid")


# イラストレーター取得
func illustrator():
	return self.owner_node().get_node("👤Illustrator")


# BGM取得
func musician_bg_musics():
	return self.owner_node().get_node("🌏Musician/🌏BgMusics")


# SE取得
func musician_sound_fx():
	return self.owner_node().get_node("🌏Musician/🌏SoundFX")


# プログラマー・ハブ取得
func programmer():
	return self.owner_node().get_node("👤Programmer/🐵Monkey")


# テロップ・コーディネーター取得
func telop_coordinator():
	return self.owner_node().get_node("🌏TelopCoordinator")
