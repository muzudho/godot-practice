# シナリオ・ブックシェルフ（Scenario Bookshelf；シナリオ本棚）
extends Object

class_name ScenarioBookshelf


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# シナリオ本の辞書
static var book_dictionary = {}


# ーーーーーーーー
# 主要プログラム
# ーーーーーーーー

# 指定の部門下の scenario_document 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
static func get_scenario_book_that_document_merged(
		department_name,
		scenario_writer_node):	# self.monkey().of_staff().scenario_writer().owner_node()
	
	# キャッシュになければ探索
	if not (department_name in ScenarioBookshelf.book_dictionary):

		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = MonkeyHelper.search_descendant_node_by_name_str(
				scenario_writer_node,
				str(department_name))
		ScenarioBookshelf.book_dictionary[department_name] = ScenarioBook.create()

		MonkeyHelper.search_descendant_within_member(
				"scenario_document",
				book_node,
				func(child_node):
					# 辞書をマージ
					ScenarioBookshelf.book_dictionary[department_name].merge_document(child_node.scenario_document))

	return ScenarioBookshelf.book_dictionary[department_name]



