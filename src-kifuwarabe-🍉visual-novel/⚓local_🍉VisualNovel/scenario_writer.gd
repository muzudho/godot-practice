# シナリオライター（Scenario Writer；脚本家）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー


# セクション配列取得
func get_section_array(
		department_name,		# StringName
		section_name):
	var merged_scenario_document = self.monkey().get_merged_scenario_document(department_name)
	
	if not(section_name in merged_scenario_document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return merged_scenario_document[section_name]
