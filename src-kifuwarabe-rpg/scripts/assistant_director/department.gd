# デパートメント（Department；部門）
extends Node


# ディレクター
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"../../TelopCoordinator"


# スナップショット取得
func get_snapshot(department_node_name):
	return self.get_director().get_snapshot(department_node_name)


# それをする
func do_it(line):

	var department_name = line.substr(11).strip_edges()
	print("［部門］　名前：［" + department_name + "］")
	department_name = self.get_assistant_director().expand_variables(department_name.strip_edges())

	self.change_department(department_name)


# 部門変更
func change_department(next_department_name):

	# 部門変更
	self.get_director().current_department = next_department_name

	# 台本の「§」セクションの再生
	self.get_assistant_director().play_section()
