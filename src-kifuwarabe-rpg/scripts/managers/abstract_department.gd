#	アブストラクト・デパートメント・マネージャー（Abstract Department Manager；抽象部門管理人）
extends Node

class_name AbstractDepartmentManager


var is_appear = false


func get_scenarion_writer():
	return $"../../../ScenarioWriter"

func get_message_window():
	var snapshot = self.get_snapshot()
	var window_name = str(snapshot.message_window_name_obj)
	
	return $"../../../GuiArtist/WindowsOfMessage".get_node(window_name)


#	同名のデパートメント・スナップショット取得
func get_snapshot():
	var department_name = str(self.name)
	return $"../../Snapshots".get_node(department_name)


# シナリオ読込
func load_current_scenario():
	var snapshot = self.get_snapshot()

	# シナリオ・ブックから、内容を取出す
	print("［抽象部門管理人］　シナリオ・ブックから、内容を取出す　部門：［" + str(snapshot.name) + "］　段落名：［" + snapshot.paragraph_name + "］")
	snapshot.scenario_array = get_scenarion_writer().get_node(str(snapshot.name)).document[snapshot.paragraph_name]

	# メッセージ・ウィンドウは、次の指示を待っています
	#snapshot.is_message_window_waiting_for_order = true


#	メッセージの追加
func push_message(temp_text):
	# メッセージ・ウィンドウの表示
	# TODO メッセージ・ウィンドウが　どれぐらい文字を表示してるかを　スナップショットに記憶したい
	self.get_snapshot().remember(temp_text)
	var message_window = self.get_message_window()
	message_window.statemachine_of_message_window.talk()
