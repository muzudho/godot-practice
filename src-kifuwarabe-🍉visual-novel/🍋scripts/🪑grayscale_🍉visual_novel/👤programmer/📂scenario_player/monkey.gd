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
