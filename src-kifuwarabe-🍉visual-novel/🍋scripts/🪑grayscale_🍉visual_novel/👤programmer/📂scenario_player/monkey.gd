# モンキー（Monkey；猿）
#
#	木登りが得意
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# スタッフの猿取得
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# プログラマーの猿取得
func of_programmer():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestors)


# 所有者ノード取得
func owner_node():
	return $"../../📂ScenarioPlayer_🍉VisualNovel"


# 時計取得
func clock():
	return $"../⌚Clock"


# 内部取得
func internal():
	return $"../🚪Internal"


# 全ての命令コード一覧
func get_all_instruction_codes():
	if self.owner_node().directory_for_instruction_code_and_node_name == null:
		self.owner_node().directory_for_instruction_code_and_node_name = {}	# キー：StringName, 値：None

		MonkeyHelper.search_node_name_begins_with(
				# 命令のノード名は `📗` で始まるものとする
				&"📗",
				# 探す場所
				# 本当は `👤Programmer` ノードの下のどこかにある `📂ScenarioPlayer_🍉VisualNovel` ノードのさらに下の `📂Instructions` ノードの下を探して欲しいが。
				self.of_staff().programmer().owner_node(),
				func(child_node):
					# コードにノード名を紐づける
					self.owner_node().directory_for_instruction_code_and_node_name[child_node.code] = child_node.name)

	return self.owner_node().directory_for_instruction_code_and_node_name


# 伝言窓（現在、出力の対象になっているもの）
func get_current_message_window_gui():
	var department_value = self.owner_node().get_current_department_value()
	if department_value.stack_of_last_displayed_message_window.size() < 1:
		print("［プログラマーズ・ハブ］　▲！　最後に表示したメッセージウィンドウが無い")

	var node_name = department_value.stack_of_last_displayed_message_window[-1]
	#print("［監督］　伝言窓名：［" + node_name + "］")
	return self.of_programmer().owner_node().message_window_programs.find_node(str(node_name))
