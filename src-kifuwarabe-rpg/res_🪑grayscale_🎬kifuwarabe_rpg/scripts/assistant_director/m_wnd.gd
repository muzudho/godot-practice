# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どの伝言窓にメッセージを出力するか指定する
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［命令　伝言窓］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null

	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges())

	if sub_command == "hide":
		# 伝言窓を隠す
		self.hide_message_window(StringName(node_name))
		return

	# 伝言窓を表示する
	self.show_message_window(StringName(node_name))


# 伝言窓を見せる
#	ただし、表示する文章がない場合は窓は消えています（状態機械の都合、文章が無ければウィンドウを消す）
func show_message_window(
		node_name,						# StringName
		is_department_entered = false):	# bool
	var snapshot = self.get_director().get_current_snapshot()
	print("［命令　伝言窓　”" + node_name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　見せる")

	# 伝言窓を、一時的に居なくなっていたのを解除する
	self.get_director().get_message_window(node_name).set_appear_subtree(true)

	if not is_department_entered:
		# 現在開いている伝言窓をスナップショットに記憶
		snapshot.append_currently_displayed_message_window(node_name)

		# 表示した順を覚えておく。スタックに既存なら最後尾に回す
		if node_name in snapshot.stack_of_last_displayed_message_window:
			var index = snapshot.stack_of_last_displayed_message_window.find(node_name)
			snapshot.stack_of_last_displayed_message_window.remove_at(index)
		snapshot.stack_of_last_displayed_message_window.push_back(node_name)

	# DEBUG 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
	self.get_director().dump_last_displayed_message_window()


# 伝言窓を隠す
func hide_message_window(
		node_name,						# StringName
		is_department_leaved = false):	# bool
	var snapshot = self.get_director().get_current_snapshot()
	print("［命令　伝言窓　”" + node_name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　隠す")

	# 伝言窓を、一時的に居なくする
	self.get_director().get_message_window(node_name).set_appear_subtree(false)

	if not is_department_leaved:
		# 現在開いている伝言窓をスナップショットから除外
		snapshot.remove_currently_displayed_message_window(node_name)

		# 表示した順序を覚えているスタックから除外する
		var index = snapshot.stack_of_last_displayed_message_window.find(node_name)
		if 0 <= index:
			snapshot.stack_of_last_displayed_message_window.remove_at(index)

	# DEBUG 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
	self.get_director().dump_last_displayed_message_window()
