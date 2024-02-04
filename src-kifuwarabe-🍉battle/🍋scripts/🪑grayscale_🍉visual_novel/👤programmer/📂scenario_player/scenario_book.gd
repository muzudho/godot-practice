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


# 段落配列取得
func get_paragraph(
		paragraph_name):		# 段落名。例えば `¶タイトル画面`
	
	if not(paragraph_name in self.document):
		print("［台本］　▲エラー　”" + paragraph_name + "”段落が無い")
		
	return self.document[paragraph_name]


# 先頭の段落のキー名取得
func get_first_paragraph_name():
	return self.document.keys()[0]


# テキストブロック取得
func get_text_block(
		paragraph_name,
		paragraph_array_index):
	return self.document[paragraph_name][paragraph_array_index]
