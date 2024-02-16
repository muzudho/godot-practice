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


# モンスターの全身像
func monster_whole_body():
	return self.owner_node().get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func monster_faces():
	return self.owner_node().get_node("MonsterTrainer/Faces")


# BGM取得
func musician_bg_musics_node():
	return self.owner_node().get_node("👤Musician/🌏BgMusics")


# SE取得
func musician_sound_fx_node():
	return self.owner_node().get_node("👤Musician/🌏SoundFX")


# プログラマー・ハブ取得
func programmer():
	return self.owner_node().get_node("👤Programmer/🐵Monkey")


# シナリオライター・ハブ取得
func scenario_writer():
	return self.owner_node().get_node("👤ScenarioWriter/🐵Monkey_🍉VisualNovel")


# テロップ・コーディネーター取得
func telop_coordinator_node():
	return self.owner_node().get_node("👤TelopCoordinator")
