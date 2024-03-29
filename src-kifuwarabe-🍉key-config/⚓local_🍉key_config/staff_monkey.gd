# 猿（Staff Hub）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督取得
func owner_node():
	return self.get_node("../../👥Staff")


# 構成取得
func config_node():
	return self.owner_node().get_node("⚙Config")


# グリッド取得
func grid_node():
	return self.owner_node().get_node("Grid")


# イラストレーター取得
func illustrator_node():
	return self.owner_node().get_node("👤Illustrator")


# BGM取得
func musician_bg_musics_node():
	return self.owner_node().get_node("👤Musician/🌏BgMusics")


# SE取得
func musician_sound_fx_node():
	return self.owner_node().get_node("👤Musician/🌏SoundFX")


# プログラマーの猿取得
func programmer():
	return self.owner_node().get_node("👤Programmer/🐵Monkey")


# テロップ・コーディネーター取得
func telop_coordinator_node():
	return self.owner_node().get_node("👤TelopCoordinator")
