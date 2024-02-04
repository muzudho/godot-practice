# シナリオ・ブック（Scenario Book；台本の本）
extends Node


class_name ScenarioBook


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 内容。辞書形式
var document = {}


# ーーーーーーーー
# 主要プログラム
# ーーーーーーーー

# 生成
static func create():
	return ScenarioBook.new()


# 内容をマージ
func merge_document(target_document):
	self.document.merge(target_document)


# 先頭のセクションのキー名取得
func get_first_section_name():
	return self.document.keys()[0]

# 段落取得
func get_paragraph(
		section_name,
		section_item_index):
	return self.document[section_name][section_item_index]
