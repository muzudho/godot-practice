# ゴートゥー（Go to；～へ行く）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "goto:"


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
func do_it(
	line):				# str

	# 次の「§」段落名
	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　ゴートゥー］　CSV：[" + csv + "]")
	# 文字列を最初のカンマで分割して配列に入れる
	var string_packed_array = csv.split(",", true, 1)

	# 段落名
	var paragraph_name = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())
	
	var tail_csv = ""
	if 1 < string_packed_array.size():
		tail_csv = string_packed_array[1]

	self.goto(paragraph_name, tail_csv)


# 同じ部門内の、指定の段落に飛ぶ
func goto(paragraph_name, tail_csv):
	
	if self.monkey().scenario_player_node().sub_monkey().internal().is_department_not_found:
		self.monkey().scenario_player_node().sub_monkey().internal().is_department_not_found = false
		return
	
	# 伝言窓の状態が Completed で止まってるとフリーズするから、強制解除
	print("［命令　ゴートゥー］　伝言窓の状態が Completed で止まってるとフリーズするから、強制的にオール・ページズ・フラッシュド")
	self.monkey().scenario_player().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()

	var merged_scenario_document = ScenarioBookshelf.get_scenario_book_that_document_merged(
			self.monkey().owner_node().current_department_name,
			self.monkey().of_staff().scenario_writer().owner_node()).document
	
	# 該当があれば、その段落を現段落にし、その段落を実行して、この関数を抜ける
	if paragraph_name in merged_scenario_document:
		self.monkey().scenario_player_node().set_current_paragraph(paragraph_name)
		self.monkey().scenario_player_node().play_paragraph()
		return
	
	# 該当なければ、とりあえず２番目のセクションまで見る
	
	# 文字列を最初のカンマで分割して配列に入れる
	var string_packed_array = tail_csv.split(",", true, 1)

	var paragraph_name2 = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())

	self.monkey().scenario_player_node().set_current_paragraph(paragraph_name2)
	self.monkey().scenario_player_node().play_paragraph()
