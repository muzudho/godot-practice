# デパートメント（Department；部門）
extends Node


# ディレクター
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# 部門管理人取得
func get_department_manager():
	return $"../../System/DepartmentManager"


# ロケーション・コーディネーター取得
func get_location_coordinator():
	return $"../../LocationCoordinator"


# スナップショット取得
func get_snapshot(department_node_name):
	return self.get_director().get_snapshot(department_node_name)


# それをする
func do_it(line):

	var department_name = line.substr(11).strip_edges()
	print("［部門］　名前：［" + department_name + "］")

	self.change_department(department_name)


# 部門変更
func change_department(next_department_name):
	# 現在の部門を隠す
	self.get_department_manager().disappear()

	# 部門変更
	self.get_director().current_department = next_department_name

	# 現在の部門を再表示
	self.get_department_manager().appear()

	# 台本の「§」セクションの再生
	self.get_assistant_director().play_section()


# 場所が非表示中なら、表示にする
func show_current_location(department_node_name):
	# 変数名を短くする
	var current_location_node_name = self.get_snapshot(department_node_name).location_node_name

	if current_location_node_name == "":
		return

	print("［ロケーション・コーディネーター］　表示：[" + str(current_location_node_name) + "]")
	self.get_location_coordinator().get_node(current_location_node_name).show()


# 場所が表示中なら、非表示にする
func hide_current_location(department_node_name):
	# 変数名を短くする
	var current_location_node_name = self.get_snapshot(department_node_name).location_node_name

	if current_location_node_name == "":
		return

	print("［ロケーション・コーディネーター］　非表示：[" + str(current_location_node_name) + "]")
	self.get_location_coordinator().get_node(current_location_node_name).hide()

