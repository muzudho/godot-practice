# シナリオライター（Scenario Writer；脚本家）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"🐵Monkey_🍉VisualNovel"


# ーーーーーーーー
# その他
# ーーーーーーーー

# セクション配列取得
func get_section_array(
		department_name,		# StringName
		section_name):
	var merged_scenario_document = self.monkey().of_staff().programmer().scenario_player_node().get_merged_scenario_document(department_name)
	
	if not(section_name in merged_scenario_document):
		print("［台本］　▲エラー　”" + section_name + "”セクションが無い")
		
	return merged_scenario_document[section_name]


# 仮想キーを押下したという建付け
func on_virtual_key_input(
		virtual_key,
		lever_value,
		vk_operation):

	var cur_department_name = self.monkey().of_staff().programmer().owner_node().current_department_name

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if vk_operation == &"VKO_Pressed" and cur_department_name in self.monkey().department_control().key_pressed_stage_directions:
		
		# その要素を取得
		var key_pressed_stage_directions_1 = self.monkey().department_control().key_pressed_stage_directions[cur_department_name]
		
		# 押したキーに紐づく、ト書きは辞書に記載されているか？
		if virtual_key in key_pressed_stage_directions_1:
			
			# そのト書き
			var stage_directions = key_pressed_stage_directions_1[virtual_key]

			print("［監督］　アンハンドルド・キー押下　部門変更")

			# ここで stage_directions をト書きとして実行したい
			self.monkey().of_staff().programmer().scenario_player_node().parse_paragraph(stage_directions)

			# 子要素には渡しません
			return true

	# 何もしませんでした
	return false
