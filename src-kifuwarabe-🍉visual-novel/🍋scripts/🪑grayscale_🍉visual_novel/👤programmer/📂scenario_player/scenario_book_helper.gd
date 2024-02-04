# シナリオ・ブック・ヘルパー（Scenario Book Helper；台本の助け）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 複数のシナリオ・ドキュメント
var cached_scenario_documents = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 主要プログラム
# ーーーーーーーー

# 指定の部門下の scenario_document 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_scenario_document(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_scenario_documents):

		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = MonkeyHelper.search_descendant_node_by_name_str(
				self.monkey().of_staff().scenario_writer().owner_node(),
				str(department_name))
		self.cached_scenario_documents[department_name] = {}

		MonkeyHelper.search_descendant_within_member(
				"scenario_document",
				book_node,
				func(child_node):
					self.cached_scenario_documents[department_name].merge(child_node.scenario_document))

	return self.cached_scenario_documents[department_name]


