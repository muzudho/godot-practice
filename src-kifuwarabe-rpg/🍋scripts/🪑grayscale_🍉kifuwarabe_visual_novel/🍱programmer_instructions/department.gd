# TODO RPG用
#
# デパートメント（Department；部門）
#	部門を切り替えるときに使う。
#	備考：　`goto` 命令がただのセクションの移動なのに対し、`department` はスナップショットへの保存と、スナップショットからの復元を伴う
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"../../🛩️ProgramsHub"


# ーーーーーーーー
# その他
# ーーーーーーーー


func get_m_wnd():
	return self.hub().get_instruction("MWnd")


# それをする
func do_it(line):

	var department_name_str = line.substr("department:".length()).strip_edges()
	print("［命令　部門］　名前：［" + department_name_str + "］")
	department_name_str = self.hub().expand_variables(department_name_str.strip_edges())

	self.change_department(StringName(department_name_str))


# 部門変更
func change_department(next_department_name):

	# 前部門
	var prev_department_name = self.hub().current_department_name
	print("［命令　部門］　前：［" + prev_department_name + "］　次：［" + next_department_name + "］")
	
	var prev_department_snapshot = self.hub().get_snapshot(prev_department_name)

	# 旧部門のウィンドウを閉じる
	for prev_window_name in prev_department_snapshot.node_names_of_currently_displayed_message_window:
		self.get_m_wnd().hide_message_window(prev_window_name, true)

	# 部門変更
	self.hub().current_department_name = next_department_name

	# 次部門
	var next_department_snapshot = self.hub().get_snapshot(next_department_name)

	# 旧部門のウィンドウを復元する
	for next_window_name in next_department_snapshot.node_names_of_currently_displayed_message_window:
		self.get_m_wnd().show_message_window(next_window_name, true)

	# 台本の「§」セクションの再生
	self.hub().play_section()
