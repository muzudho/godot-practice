# シナリオ・ヘルパー（Scenario Helper；台本の助け）
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

# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var department_value = self.monkey().owner_node().get_current_department_value()
	var scenario_node_name = department_value.name		# StringName
	var section_name =  department_value.section_name
	
	var section_array = self.monkey().section_array_helper_node().get_it(scenario_node_name, section_name)
	return section_array.size()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	var department_value = self.monkey().owner_node().get_current_department_value()
	var message_window_gui = self.monkey().get_current_message_window_gui()

	var merged_scenario_document = self.monkey().owner_node().get_merged_scenario_document(department_value.name)
	return merged_scenario_document[department_value.section_name][message_window_gui.section_item_index]
