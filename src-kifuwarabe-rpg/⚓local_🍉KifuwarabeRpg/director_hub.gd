# ディレクター・ハブ（Director Hub）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督取得
func owner_node():
	return self.get_node("../../🌏Director")


# イラストレーター取得
func illustrator():
	return self.get_node("🌏Illustrator")


# メッセージ・ウィンドウズ取得
func gui_programmer_message_windows():
	return self.get_node("🌏Programmer_MessageWindow")


# モンスターの全身像
func monster_whole_body():
	return self.get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func monster_faces():
	return self.get_node("MonsterTrainer/Faces")


# BGM取得
func musician_bg_musics():
	return self.get_node("🌏Musician/🌏BgMusics")


# SE取得
func musician_sound_fx():
	return self.get_node("🌏Musician/🌏SoundFX")


# プログラマー取得
func programmer():
	return self.get_node("🌏Programmer")


# シナリオライター取得
func scenario_writer():
	return self.get_node("🌏ScenarioWriter")


# シナリオライター・ハブ取得
func scenario_writers_hub():
	return self.get_node("🌏ScenarioWriter/🛩️Hub_🍉VisualNovel")


# テロップ・コーディネーター取得
func telop_coordinator():
	return self.get_node("🌏TelopCoordinator")
