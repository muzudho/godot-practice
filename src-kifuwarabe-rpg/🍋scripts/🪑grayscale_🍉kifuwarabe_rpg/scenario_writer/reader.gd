# シナリオ・リーダー（Scenario Reader；台本読み機）
extends Node


# シナリオライター取得
func get_scenario_writer():
	return $"../../../📂ScenarioWriter"


# セクション配列取得
func get_section_array(department_name, section_name):
	var scenario_node = self.get_scenario_writer().get_node(str(department_name))
	if scenario_node == null:
		print("［助監］　▲エラー　”" + department_name + "”ノードが無い")
	
	if not(section_name in scenario_node.document):
		print("［助監］　▲エラー　”" + section_name + "”セクションが無い")
		
	return scenario_node.document[section_name]
