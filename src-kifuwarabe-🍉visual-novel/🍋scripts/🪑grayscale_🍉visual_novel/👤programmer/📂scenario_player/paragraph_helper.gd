# パラグラフ・ヘルパー（Paragraph Helper；段落の助け）
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

# 現在の「¶」段落設定
func set_current_paragraph(paragraph_name):
	var department_value = self.monkey().owner_node().get_current_department_value()
	var message_window_gui = self.monkey().get_current_message_window_gui_node()

	# 段落名
	department_value.paragraph_name = paragraph_name
	
	# 段落配列の先頭要素に戻します
	message_window_gui.paragraph_item_index = 0
