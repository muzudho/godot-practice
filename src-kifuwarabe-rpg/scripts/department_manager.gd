#	デパートメント・マネージャー（Department Manager；抽象部門管理人）
extends Node

class_name AbstractDepartmentManager


func get_scenarion_writer():
	return $"../../ScenarioWriter"


#	同名のデパートメント・スナップショット取得
func get_snapshot():
	var director = $"../../../Director"
	return director.snapshots[director.current_department]


func get_message_window():
	var snapshot = self.get_snapshot()
	var window_name = str(snapshot.message_window_name_obj)
	
	return $"../../GuiArtist/WindowsOfMessage".get_node(window_name)


# 会話開始
func talk():
	self.get_message_window().statemachine_of_message_window.talk()


# 居なくなる
func disappear():
	if self.get_snapshot().is_appear:
		print("［部門管理人］　居なくなる")
		self.get_snapshot().is_appear = false
		
		# メッセージ・ウィンドウを、一時的に居なくする
		self.get_message_window().set_appear_subtree(false)
		
		# 場所が表示中なら、非表示にする
		#$"../../../LocationCoordinator".hide_current_location(str(self.name))


# 現れる
func appear():
	if not self.get_snapshot().is_appear:
		print("［部門管理人］　居なくなっていたのを解除する")
		self.get_snapshot().is_appear = true

		# メッセージ・ウィンドウを、一時的に居なくなっていたのを解除する
		self.get_message_window().set_appear_subtree(true)

		# 場所が非表示中なら、表示する
		#$"../../../LocationCoordinator".show_current_location(str(self.name))