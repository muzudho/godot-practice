#	アブストラクト・デパートメント・マネージャー（Abstract Department Manager；抽象部管理人）
extends Node

class_name AbstractDepartmentManager


var is_appear = false


func get_message_window(node_name):
	return $"../../../GuiArtist/WindowsOfMessage".get_node(node_name)
