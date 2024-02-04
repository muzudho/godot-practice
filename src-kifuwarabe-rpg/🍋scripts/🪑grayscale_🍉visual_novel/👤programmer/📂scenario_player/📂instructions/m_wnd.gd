# エム・ワンド、メッセージ・ウィンドウ（M-Wnd, Message Window；伝言窓）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
#
# どの伝言窓にメッセージを出力するか指定する
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "msg_wnd:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　伝言窓］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())
	var sub_command = null

	if 2 <= string_packed_array.size():
		sub_command = self.monkey().owner_node().expand_variables(string_packed_array[1].strip_edges())

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
	var department_value = self.monkey().scenario_player_node().get_current_department_value()
	print("［命令　伝言窓　”" + node_name + "”］（" + str(department_value.name) + "　" + department_value.paragraph_name + "）　見せる")

	# 伝言窓を、一時的に居なくなっていたのを解除する
	self.monkey().owner_node().message_window_programs.find_node(node_name).set_appear_subtree(true)

	if not is_department_entered:
		# 現在開いている伝言窓をスナップショットに記憶
		department_value.append_currently_displayed_message_window(node_name)

		# 表示した順を覚えておく。スタックに既存なら最後尾に回す
		if node_name in department_value.stack_of_last_displayed_message_window:
			var index = department_value.stack_of_last_displayed_message_window.find(node_name)
			department_value.stack_of_last_displayed_message_window.remove_at(index)
		department_value.stack_of_last_displayed_message_window.push_back(node_name)

	# DEBUG 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
	self.monkey().scenario_player_node().dump_last_displayed_message_window()


# 伝言窓を隠す
func hide_message_window(
		node_name,						# StringName
		is_department_leaved = false):	# bool
	var department_value = self.monkey().scenario_player_node().get_current_department_value()
	print("［命令　伝言窓　”" + node_name + "”］（" + str(department_value.name) + "　" + department_value.paragraph_name + "）　隠す")

	# 伝言窓を、一時的に居なくする
	self.monkey().owner_node().message_window_programs.find_node(node_name).set_appear_subtree(false)

	if not is_department_leaved:
		# 現在開いている伝言窓をスナップショットから除外
		department_value.remove_currently_displayed_message_window(node_name)

		# 表示した順序を覚えているスタックから除外する
		var index = department_value.stack_of_last_displayed_message_window.find(node_name)
		if 0 <= index:
			department_value.stack_of_last_displayed_message_window.remove_at(index)

	# DEBUG 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
	self.monkey().scenario_player_node().dump_last_displayed_message_window()
