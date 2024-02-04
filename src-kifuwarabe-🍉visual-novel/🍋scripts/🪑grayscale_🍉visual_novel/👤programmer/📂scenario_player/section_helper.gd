# セクション・ヘルパー（Section Helper；セクションの助け）
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

# 現在の「§」セクション設定
func set_current_section(section_name):
	var department_value = self.monkey().owner_node().get_current_department_value()
	var message_window_gui = self.monkey().get_current_message_window_gui()

	department_value.section_name = section_name
	message_window_gui.section_item_index = 0
