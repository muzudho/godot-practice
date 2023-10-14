#	アブストラクト・デパートメント・マネージャー（Abstract Department Manager；抽象部管理人）
extends Node

class_name AbstractDepartmentManager


var is_appear = false


func get_message_window():
	var snapshot = self.get_snapshot()
	var window_name = str(snapshot.message_window_name_obj)
	
	return $"../../../GuiArtist/WindowsOfMessage".get_node(window_name)


#	同名のデパートメント・スナップショット取得
func get_snapshot():
	var department_name = str(self.name)
	return $"../../Snapshots".get_node(department_name)
