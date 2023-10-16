# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#	どのメッセージ・ウィンドウにメッセージを出力するか指定する
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［メッセージ・ウィンドウ制御］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_arg(string_packed_array[0].strip_edges())
	var sub_command = null

	if 2 <= string_packed_array.size():
		sub_command = self.get_assistant_director().expand_arg(string_packed_array[1].strip_edges())

	if node_name == "%hide_current_it_then_push_it_to_stack%":
		self.hide_current_it_then_push_it_to_stack()
		return

	if node_name == "%pop_it_from_stack_then_show_current_it%":
		self.pop_it_from_stack_then_show_current_it()
		return

	if sub_command == "hide":
		# メッセージ・ウィンドウを隠す
		self.hide_me(node_name)
		return

	self.show_me(node_name)


# メッセージ・ウィンドウを見せる
func show_me(node_name_str):
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　見せる")

	# メッセージ・ウィンドウを、一時的に居なくなっていたのを解除する
	self.get_director().get_message_window(StringName(node_name_str)).set_appear_subtree(true)


# メッセージ・ウィンドウを隠す
func hide_me(node_name_str):
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　隠す")

	# メッセージ・ウィンドウを、一時的に居なくする
	self.get_director().get_message_window(StringName(node_name_str)).set_appear_subtree(false)


# 現在のウィンドウを隠し、そして、それをスタックへプッシュする
func hide_current_it_then_push_it_to_stack():
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　現在のウィンドウを隠し、そして、それをスタックへプッシュする")

	# 現在のウィンドウを隠す
	var current_node_name = snapshot.message_window_name_obj_stack[-1]
	self.hide_me(str(current_node_name))

	# スタックにプッシュする
	snapshot.message_window_name_obj_stack.push_back(current_node_name)

# スタックからウィンドウをポップし、そして、それを見せる
func pop_it_from_stack_then_show_current_it():
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　スタックからウィンドウをポップし、そして、それを見せる")

	# スタックからウィンドウをポップする
	var peek_node_name = snapshot.message_window_name_obj_stack.pop_back()
	
	# それを見せる
	self.show_me(str(peek_node_name))

