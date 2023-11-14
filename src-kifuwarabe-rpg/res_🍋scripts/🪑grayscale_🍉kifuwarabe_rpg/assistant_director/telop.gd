# テロップ（Telop, Television opaque projector；テレビ投射映像機）
#	撮影場所変更
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return self.get_director().get_node("AssistantDirector")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("TelopCoordinator")


# スナップショット取得
func get_snapshot(department_node_name):
	return self.get_director().get_snapshot(department_node_name)


#	それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［命令　テロップ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())
	
	if sub_command == "hide":
		# テロップを隠す
		self.hide_telop(node_name)
		return
	
	self.show_telop(node_name)


# テロップを見せる
func show_telop(node_name):
	
	var telop_node = self.get_telop_coordinator().get_node(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")
	
	telop_node.show()


# テロップを隠す
func hide_telop(node_name):
	
	var telop_node = self.get_telop_coordinator().get_node(node_name)
	if telop_node == null:
		print("［命令　テロップ］　▲エラー　”" + node_name + "”　が無い")

	telop_node.hide()
