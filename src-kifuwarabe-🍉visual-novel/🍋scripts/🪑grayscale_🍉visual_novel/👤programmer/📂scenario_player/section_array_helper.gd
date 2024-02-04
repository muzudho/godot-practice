# セクション・アレイ・ヘルパー（Section Array Helper；セクション配列の助け）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 主要プログラム
# ーーーーーーーー

# セクション配列取得
func get_it(
		department_name,		# StringName
		section_name):
	var merged_scenario_document = self.monkey().owner_node().get_merged_scenario_document(department_name)
	
	if not(section_name in merged_scenario_document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return merged_scenario_document[section_name]
