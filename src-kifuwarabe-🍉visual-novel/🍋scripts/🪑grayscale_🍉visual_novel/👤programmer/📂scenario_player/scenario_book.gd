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


# 先頭の段落のキー名取得
func get_first_paragraph_name():
	return self.document.keys()[0]

# テキストブロック取得
func get_text_block(
		paragraph_name,
		paragraph_array_index):
	return self.document[paragraph_name][paragraph_array_index]
