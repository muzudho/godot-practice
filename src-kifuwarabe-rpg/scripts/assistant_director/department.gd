# デパートメント（Department；部門）
#	部門を切り替えるときに使う
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
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

	var department_name_str = line.substr(11).strip_edges()
	print("［命令　部門］　名前：［" + department_name_str + "］")
	department_name_str = self.get_assistant_director().expand_variables(department_name_str.strip_edges())

	self.change_department(StringName(department_name_str))


# 部門変更
func change_department(next_department_name):

	# 旧部門のウィンドウを閉じる
	var old_department_name = self.get_director().current_department_name
	#old_department_name

	# 部門変更
	self.get_director().current_department_name = next_department_name

	# 台本の「§」セクションの再生
	self.get_assistant_director().play_section()
