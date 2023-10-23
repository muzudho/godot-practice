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

	if node_name == "%hide_current_it_then_push_it_to_stack%":
		self.hide_current_it_then_push_it_to_stack()
		return

	if node_name == "%pop_it_from_stack_then_show_current_it%":
		self.pop_it_from_stack_then_show_current_it()
		return

	if sub_command == "hide":
		# 伝言窓を隠す
		self.hide_me(node_name)
		return

	# 伝言窓を表示する
	self.show_me(node_name)


# 伝言窓を見せる
#	ただし、表示する文章がない場合は窓は消えています（状態機械の都合、文章が無ければウィンドウを消す）
func show_me(node_name_str):
	var snapshot = self.get_director().get_current_snapshot()
	print("［命令　伝言窓　”" + node_name_str + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　見せる")

	# 伝言窓を、一時的に居なくなっていたのを解除する
	self.get_director().get_message_window(StringName(node_name_str)).set_appear_subtree(true)


# 伝言窓を隠す
func hide_me(node_name_str):
	var snapshot = self.get_director().get_current_snapshot()
	print("［命令　伝言窓　”" + node_name_str + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　隠す")

	# 伝言窓を、一時的に居なくする
	self.get_director().get_message_window(StringName(node_name_str)).set_appear_subtree(false)


# 現在のウィンドウを隠し、そして、それをスタックへプッシュする
func hide_current_it_then_push_it_to_stack():
	var snapshot = self.get_director().get_current_snapshot()

	# 現在の伝言窓名
	var current_node_name = snapshot.message_window_name_obj_stack[-1]
	print("［命令　伝言窓　”" + current_node_name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　現在の伝言窓を隠し、そして、それをスタックへプッシュする")

	# 現在の伝言窓を隠す
	self.hide_me(str(current_node_name))

	# スタックにプッシュする
	snapshot.message_window_name_obj_stack.push_back(current_node_name)

# スタックからウィンドウをポップし、そして、それを見せる
func pop_it_from_stack_then_show_current_it():
	var snapshot = self.get_director().get_current_snapshot()
	
	# スタックからポップした伝言窓名
	var peek_node_name = snapshot.message_window_name_obj_stack.pop_back()
	
	print("［命令　伝言窓　”" + peek_node_name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　スタックから伝言窓をポップし、そして、それを見せる")

	# スタックからポップした伝言窓を見せる
	self.show_me(str(peek_node_name))

