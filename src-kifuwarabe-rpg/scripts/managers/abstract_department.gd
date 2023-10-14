#	アブストラクト・デパートメント・マネージャー（Abstract Department Manager；抽象部門管理人）
extends Node

class_name AbstractDepartmentManager


var is_appear = false


func get_scenarion_writer():
	return $"../../../ScenarioWriter"

func get_message_window():
	var snapshot_data = self.get_snapshot_data()
	var window_name = str(snapshot_data.message_window_name_obj)
	
	return $"../../../GuiArtist/WindowsOfMessage".get_node(window_name)


#	同名のデパートメント・スナップショット取得
func get_snapshot_data():
	var department_name = str(self.name)
	return $"../../../../Director".snapshots[department_name]


# 会話開始
func talk():
	self.get_message_window().statemachine_of_message_window.talk()
