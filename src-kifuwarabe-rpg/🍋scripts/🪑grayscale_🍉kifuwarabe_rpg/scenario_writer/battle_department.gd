#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		バトル部門
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


func get_director():
	return $"../../../Director"


# プログラムズ・ハブ取得
func get_programs_hub():
	return self.get_director().get_node("📂Programmer/🛩️ProgramsHub")


func get_telop_coordinator():
	return self.get_director().get_node("📂TelopCoordinator")


func get_scorer():
	return self.get_director().get_node("Scorer")


func get_game_sheet_for_battle():
	return self.get_director().get_node("Scorer/GameSheetForBattle")


func get_accessor():
	return $"Accessor"
