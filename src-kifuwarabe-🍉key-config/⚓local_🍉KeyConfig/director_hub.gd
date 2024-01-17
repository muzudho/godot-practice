# ディレクター・ハブ（Director Hub）
extends Node


# ーーーーーーーー
# 内パス関連
# ーーーーーーーー


# イラストレーター取得
func illustrator():
	return self.get_node("../../🌏Director/🌏Illustrator")


# BGM取得
func musician_bg_musics():
	return self.get_node("../../🌏Director/🌏Musician/🌏BgMusics")


# SE取得
func musician_sound_fx():
	return self.get_node("../../🌏Director/🌏Musician/🌏SoundFX")


# プログラマー取得
func programmer():
	return self.get_node("../../🌏Director/🌏Programmer")


# プログラマー・ハブ取得
func programmer_hub():
	return self.get_node("../../🌏Director/🌏Programmer/🛩️Hub")


# テロップ・コーディネーター取得
func telop_coordinator():
	return self.get_node("../../🌏Director/🌏TelopCoordinator")
