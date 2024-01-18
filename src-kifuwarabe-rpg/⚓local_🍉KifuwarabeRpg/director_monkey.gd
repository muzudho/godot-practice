# ディレクター・ハブ（Director Hub）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督取得
func owner_node():
	return self.get_node("../../🌏Director")


# グリッド取得
func grid():
	return self.owner_node().get_node("Grid")


# イラストレーター取得
func illustrator():
	return self.owner_node().get_node("🌏Illustrator")


# キー・コンフィグ・ハブ取得
func key_config_island():
	return self.owner_node().get_node("🏝️KeyConfigIsland")


# メッセージ・ウィンドウズ取得
func gui_programmer_message_windows():
	return self.owner_node().get_node("🌏Programmer_MessageWindow")


# モンスターの全身像
func monster_whole_body():
	return self.owner_node().get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func monster_faces():
	return self.owner_node().get_node("MonsterTrainer/Faces")


# BGM取得
func musician_bg_musics():
	return self.owner_node().get_node("🌏Musician/🌏BgMusics")


# SE取得
func musician_sound_fx():
	return self.owner_node().get_node("🌏Musician/🌏SoundFX")


# プログラマー取得
func programmer():
	return self.owner_node().get_node("🌏Programmer")


# プログラマー・ハブ取得
func programmer_monkey():
	return self.owner_node().get_node("🌏Programmer/🐵Monkey")


# シナリオライター取得
func scenario_writer():
	return self.owner_node().get_node("🌏ScenarioWriter")


# シナリオライター・ハブ取得
func scenario_writer_monkey():
	return self.owner_node().get_node("🌏ScenarioWriter/🐵Monkey_🍉VisualNovel")


# テロップ・コーディネーター取得
func telop_coordinator():
	return self.owner_node().get_node("🌏TelopCoordinator")
