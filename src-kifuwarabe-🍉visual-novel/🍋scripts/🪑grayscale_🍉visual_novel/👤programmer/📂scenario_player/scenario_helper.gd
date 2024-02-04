# シナリオ・ヘルパー（Scenario Helper；台本の助け）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 主要プログラム
# ーーーーーーーー

# シナリオの現段落の配列のサイズを返す
func get_current_paragraph_size_of_scenario():
	var department_obj = self.monkey().owner_node().get_current_department_value()
	
	# シナリオ・ノード名。例えば `📗会話部門_🍉VisualNovel`
	var scenario_node_name = department_obj.name		# StringName
	
	# 段落名。例えば `§タイトル画面`
	var paragraph_name =  department_obj.paragraph_name
	
	# パーシャルなシナリオ・ドキュメントを１つにマージしたもの
	var scenario_book = ScenarioBookshelf.get_scenario_book_that_document_merged(
			scenario_node_name,
			self.monkey().of_staff().scenario_writer().owner_node())

	var paragraph_array = scenario_book.get_paragraph(paragraph_name)
	return paragraph_array.size()


# シナリオの現在テキストブロック（パラグラフ配列の要素）を返す
func get_current_text_block_of_scenario():
	var department_obj = self.monkey().owner_node().get_current_department_value()
	var message_window_gui = self.monkey().get_current_message_window_gui()

	return ScenarioBookshelf.get_scenario_book_that_document_merged(
			department_obj.name,

			# テキストブロック
			self.monkey().of_staff().scenario_writer().owner_node()).get_text_block(
					department_obj.paragraph_name,			# 段落名
					message_window_gui.paragraph_item_index)	# 段落配列のインデックス
