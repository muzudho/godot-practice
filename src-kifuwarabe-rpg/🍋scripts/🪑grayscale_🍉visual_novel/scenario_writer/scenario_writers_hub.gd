# シナリオ・ライター・ハブ（Scenario Writer Hub；台本書きの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# シナリオ・ドキュメント
var cached_scenario_document = {}

# 選択肢と移動先
var cached_choices_mappings = {}


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../Director"


# プログラムズ・ハブ取得
func get_programs_hub():
	return self.get_director().get_node("📂Programmer/🛩️ProgramsHub")


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("📂ScenarioWriter")


# ーーーーーーーー
# その他
# ーーーーーーーー


# セクション配列取得
func get_section_array(department_name, section_name):
	var merged_scenario_document = self.get_merged_scenario_document(department_name)
	
	if not(section_name in merged_scenario_document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return merged_scenario_document[section_name]


# 指定の部門下の scenario_document 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_scenario_document(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_scenario_document):
		
		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = self.search_scenario_book_node(
				self.get_scenario_writer(),
				str(department_name))
		self.cached_scenario_document[department_name] = {}

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, book_node)

	return self.cached_scenario_document[department_name]


# ［📗～］ノードを探索
func search_scenario_book_node(
		current_node,
		department_name_str):
	if current_node.has_node(department_name_str):
		return current_node.get_node(department_name_str)

	for child_node in current_node.get_children():
		var book_node = self.search_scenario_book_node(
				child_node,
				department_name_str)
		
		if book_node != null:
			return book_node


func search_merged_scenario_document(department_name, current_node):
	for child_node in current_node.get_children():
		if "scenario_document" in child_node:
			self.cached_scenario_document[department_name].merge(child_node.scenario_document)

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, child_node)


# 指定の部門下の choices_mappings 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_choices_mappings(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_choices_mappings):
		
		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = self.search_scenario_book_node(
				self.get_scenario_writer(),
				str(department_name))
		self.cached_choices_mappings[department_name] = {}

		# 再帰。結果は外部変数に格納
		self.search_merged_choices_mappings(department_name, book_node)

	return self.cached_choices_mappings[department_name]


func search_merged_choices_mappings(department_name, current_node):
	for child_node in current_node.get_children():
		if "choices_mappings" in child_node:
			self.cached_choices_mappings[department_name].merge(child_node.choices_mappings)

		# 再帰。結果は外部変数に格納
		self.search_merged_choices_mappings(department_name, child_node)

