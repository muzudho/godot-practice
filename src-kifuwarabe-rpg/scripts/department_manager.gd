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


# 居なくなる
func disappear():
	if self.get_snapshot().is_appear:
		print("［部門管理人］　居なくなる")
		self.get_snapshot().is_appear = false
		
		# メッセージ・ウィンドウを、一時的に居なくする
		self.get_message_window().set_appear_subtree(false)
		
		# テロップが表示中なら、非表示にする
		#self.get_assitant_director().hide_current_telop(str(self.name))


# 現れる
func appear():
	if not self.get_snapshot().is_appear:
		print("［部門管理人］　居なくなっていたのを解除する")
		self.get_snapshot().is_appear = true

		# メッセージ・ウィンドウを、一時的に居なくなっていたのを解除する
		self.get_message_window().set_appear_subtree(true)

		# テロップが非表示中なら、表示する
		#self.get_assitant_director().show_current_telop(str(self.name))
