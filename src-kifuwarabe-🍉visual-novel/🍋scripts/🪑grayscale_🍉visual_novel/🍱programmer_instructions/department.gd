# TODO RPG用
#
# デパートメント（Department；部門）
#	部門を切り替えるときに使う。
#	備考：　`goto` 命令がただのセクションの移動なのに対し、`department` はスナップショットへの保存と、スナップショットからの復元を伴う
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "department:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ProgramsHub")


func get_m_wnd():
	return self.hub().get_instruction(&"📗MWnd")


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr("department:".length()).strip_edges()
	print("［命令　部門］　CSV：［" + csv + "］")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)
	
	var department_name = StringName(self.hub().expand_variables(string_packed_array[0].strip_edges()))
	
	var tail_csv = ""
	if 1 < string_packed_array.size():
		tail_csv = string_packed_array[1]
	
	self.change_department(department_name, tail_csv)


# 部門変更
func change_department(next_department_name, tail_csv):

	# 指定の部門へ飛ぶ
	if next_department_name in self.hub().get_all_department_names():

		# フラグを下ろす
		self.hub().is_department_not_found = false

		# 前部門
		var prev_department_name = self.hub().current_department_name
		print("［命令　部門］　前：［" + prev_department_name + "］　次：［" + next_department_name + "］")
		
		var prev_department = self.hub().get_department_value(prev_department_name)

		# 旧部門のウィンドウを閉じる
		for prev_window_name in prev_department.node_names_of_currently_displayed_message_window:
			self.get_m_wnd().hide_message_window(prev_window_name, true)

		# 部門変更
		self.hub().current_department_name = next_department_name

		# 次部門
		var next_department_snapshot = self.hub().get_department_value(next_department_name)

		# 旧部門のウィンドウを復元する
		for next_window_name in next_department_snapshot.node_names_of_currently_displayed_message_window:
			self.get_m_wnd().show_message_window(next_window_name, true)

		# 台本の「§」セクションの再生
		self.hub().play_section()

		return

	# 指定の部門が無かった
	self.hub().is_department_not_found = true

	# 文字列の配列に分割
	var string_packed_array = tail_csv.split(",", true, 0)

	if 0 < string_packed_array.size():
		var sub_command = string_packed_array[0]

		# 指定の部門が存在しなければ、何もしません	
		if sub_command == "%ignorable%":
			return

	# エラー
	print("［命令　部門］　▲！エラー　指定の ❝" + next_department_name + "❞ 部門は存在しませんでした")
