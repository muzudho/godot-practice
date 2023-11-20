#	ゴートゥー（Go to；～へ行く）
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


# それをする
func do_it(
	line):				# str

	# 次の「§」セクション名
	var csv = line.substr("goto:".length()).strip_edges()
	print("［命令　ゴートゥー］　CSV：[" + csv + "]")
	# 文字列を最初のカンマで分割して配列に入れる
	var string_packed_array = csv.split(",", true, 1)

	var section_name = self.hub().expand_variables(string_packed_array[0].strip_edges())
	
	var tail_csv = ""
	if 1 < string_packed_array.size():
		tail_csv = string_packed_array[1]

	self.goto(section_name, tail_csv)


# 同じ部門内の、指定のセクションに飛ぶ
func goto(section_name, tail_csv):
	
	if self.hub().is_department_not_found:
		self.hub().is_department_not_found = false
		return
	
	# 伝言窓の状態が Completed で止まってるとフリーズするから、強制解除
	print("［命令　ゴートゥー］　伝言窓の状態が Completed で止まってるとフリーズするから、強制的にオール・ページズ・フラッシュド")
	self.hub().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()

	var merged_scenario_document = self.hub().get_scenario_writers_hub().get_merged_scenario_document(
		self.hub().current_department_name)
	
	if section_name in merged_scenario_document:
		self.hub().set_current_section(section_name)
		self.hub().play_section()
		return
	
	# 該当なければ、とりあえず２番目のセクションまで見る
	
	# 文字列を最初のカンマで分割して配列に入れる
	var string_packed_array = tail_csv.split(",", true, 1)

	var section_name2 = self.hub().expand_variables(string_packed_array[0].strip_edges())

	self.hub().set_current_section(section_name2)
	self.hub().play_section()
