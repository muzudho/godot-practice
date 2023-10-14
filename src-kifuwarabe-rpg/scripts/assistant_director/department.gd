# デパートメント（Department；部門）
extends Node


# ディレクター
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# 部門管理人
func get_department_manager():
	return $"../../System/DepartmentManager"


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

	# 台本の段落の再生
	self.get_assistant_director().play_paragraph()
	
