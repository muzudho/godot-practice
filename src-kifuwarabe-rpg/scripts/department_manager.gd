# デパートメント・マネージャー（Department Manager；抽象部門管理人）
extends Node

class_name AbstractDepartmentManager


# ディレクター取得
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター取得
func get_assitant_director():
	return $"../../AssistantDirector"


# スナップショット取得
func get_snapshot():
	return self.get_director().get_current_snapshot()


func get_message_window():
	var snapshot = self.get_snapshot()
	var window_name = str(snapshot.message_window_name_obj)
	
	return $"../../GuiArtist/WindowsOfMessage".get_node(window_name)


# 会話開始
func talk():
	self.get_message_window().statemachine_of_message_window.talk()
