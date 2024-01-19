# シナリオ・ライター・ハブ（Scenario Writer Hub；台本書きの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 先祖の辞書キャッシュ
var ancestors = {}

# シナリオ・ドキュメント
var cached_scenario_document = {}

# 選択肢と移動先
var cached_choices_mappings = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 自身取得
func monkey():
	return self


# 監督ハブ取得
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# シナリオライター取得
func owner_node():
	return self.get_node("../../👤ScenarioWriter")


# 部門切替取得
func department_control():
	return self.owner_node().get_node("📘DepartmentControl")


# ーーーーーーーー
# その他
# ーーーーーーーー


# セクション配列取得
func get_section_array(
		department_name,		# StringName
		section_name):
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
		var book_node = MonkeyHelper.search_descendant_node_by_name_str(
				self.owner_node(),
				str(department_name))
		self.cached_scenario_document[department_name] = {}

		MonkeyHelper.search_descendant_within_member(
				"scenario_document",
				book_node,
				func(child_node):
					self.cached_scenario_document[department_name].merge(child_node.scenario_document))

	return self.cached_scenario_document[department_name]


# 指定の部門下の choices_mappings 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_choices_mappings(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_choices_mappings):

		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = MonkeyHelper.search_descendant_node_by_name_str(
				self.owner_node(),
				str(department_name))
		self.cached_choices_mappings[department_name] = {}

		MonkeyHelper.search_descendant_within_member(
				"choices_mappings",
				book_node,
				func(child_node):
					self.cached_choices_mappings[department_name].merge(child_node.choices_mappings))

	return self.cached_choices_mappings[department_name]


# 仮想キーを押下したという建付け
func on_virtual_key_input(
		virtual_key,
		lever_value,
		vk_operation):

	var cur_department_name = self.monkey().of_staff().programmer().owner_node().current_department_name

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if vk_operation == &"VKO_Pressed" and cur_department_name in self.department_control().key_pressed_stage_directions:
		
		# その要素を取得
		var key_pressed_stage_directions_1 = self.department_control().key_pressed_stage_directions[cur_department_name]
		
		# 押したキーに紐づく、ト書きは辞書に記載されているか？
		if virtual_key in key_pressed_stage_directions_1:
			
			# そのト書き
			var stage_directions = key_pressed_stage_directions_1[virtual_key]

			print("［監督］　アンハンドルド・キー押下　部門変更")

			# ここで stage_directions をト書きとして実行したい
			self.monkey().of_staff().programmer().scenario_player().parse_paragraph(stage_directions)

			# 子要素には渡しません
			return true

	# 何もしませんでした
	return false
