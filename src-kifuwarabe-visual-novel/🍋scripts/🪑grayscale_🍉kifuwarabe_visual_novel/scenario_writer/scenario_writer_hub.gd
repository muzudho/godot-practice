# シナリオ・ライター・ハブ（Scenario Writer Hub；台本書きの中心地）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../Director"


# プログラムズ・ハブ取得
func get_programs_hub():
	return self.get_director().get_node("📂Programmer/🛩️ProgramsHub")


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("📂ScenarioWriter")


# ーーーーーーーー
# その他
# ーーーーーーーー


# セクション配列取得
func get_section_array(department_name, section_name):
	var scenario_node = self.get_scenario_writer().get_node(str(department_name))
	if scenario_node == null:
		print("［台本］　▲エラー　”" + department_name + "”ノードが無い")
	
	if not(section_name in scenario_node.document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return scenario_node.document[section_name]
