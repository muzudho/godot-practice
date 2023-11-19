# シナリオ・ライター・ハブ（Scenario Writer Hub；台本書きの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


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
	var scenario_node = self.get_scenario_writer().get_node(str(department_name))
	if scenario_node == null:
		print("［台本］　▲エラー　”" + department_name + "”ノードが無い")
	
	if not(section_name in scenario_node.document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return scenario_node.document[section_name]


# 指定の部門下の choices_mappings 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_choices_mappings(department_name):
	if not (department_name in self.cached_choices_mappings):
		var book_node = self.get_scenario_writer().get_node(str(department_name))
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

