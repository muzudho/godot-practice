# パラグラフ・アレイ・ヘルパー（Paragraph Array Helper；段落配列の助け）
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

# 段落配列取得
func get_it(
		department_name,		# StringName型。シナリオ・ノード名。例えば `📗会話部門_🍉VisualNovel`
		paragraph_name):		# 段落名。例えば `§タイトル画面`
	
	# パーシャルなシナリオ・ドキュメントを１つにマージしたもの
	var merged_scenario_document = ScenarioBookshelf.get_scenario_book_that_document_merged(
			department_name,
			self.monkey().of_staff().scenario_writer().owner_node()).document
	
	if not(paragraph_name in merged_scenario_document):
		print("［台本］　▲エラー　”" + paragraph_name + "”段落が無い")
		
	return merged_scenario_document[paragraph_name]
