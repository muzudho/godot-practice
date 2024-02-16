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
func get_current_paragraph_array_size():
	var department_obj = self.monkey().owner_node().get_current_department_value()
	
	return ScenarioBookshelf.get_scenario_book_that_document_merged(
			# シナリオ・ノード名。例えば `📗会話部門_🍉VisualNovel`。StringName型
			department_obj.name,
			self.monkey().of_staff().scenario_writer().owner_node()).get_paragraph(
				# 段落名。例えば `¶タイトル画面`
				department_obj.paragraph_name).size()


# シナリオの現在テキストブロック（パラグラフ配列の要素）を返す
func get_current_text_block(scenario_book):
	var department_obj = self.monkey().owner_node().get_current_department_value()

	return scenario_book.get_text_block(
			department_obj.paragraph_name,			# 段落名

			# 段落配列のインデックス（メッセージ・ウィンドウが持っている）
			self.monkey().get_current_message_window_gui_node().paragraph_item_index)	
