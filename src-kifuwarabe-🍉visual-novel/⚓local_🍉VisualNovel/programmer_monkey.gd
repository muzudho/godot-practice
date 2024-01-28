# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}

# 全部門名
var all_department_names = null

# 全命令（キー：ノード名　値：ノード）
var cache_dictionary_for_instruction = {}


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


# プログラマー取得
func owner_node():
	return self.get_node("../../👤Programmer")


# 部門制御取得
func department_controller_node():
	return self.owner_node().get_node("📂DepartmentController_🍉VisualNovel")


# 部門制御の猿取得
func department_controller():
	return self.department_controller_node().get_node("🐵Monkey")


# キー・コンフィグ取得
func key_config_node():
	return self.owner_node().get_node("📂🍉KeyConfig")


# シナリオ再生機取得
func scenario_player_node():
	return self.owner_node().get_node("📂ScenarioPlayer_🍉VisualNovel")


# シナリオ再生機の猿取得
func scenario_player():
	return self.scenario_player_node().get_node("🐵Monkey")


# 命令ノード取得
func get_instruction(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.owner_node(),	# 探す場所
			func():
				return self.cache_dictionary_for_instruction)	# 結果を格納する変数


# 全ての部門名一覧
func get_all_department_names():
	if self.all_department_names == null:
		self.all_department_names = []	# StringName の配列

		MonkeyHelper.search_node_name_begins_with(
				# 命令のノード名は `📗` で始まるものとする
				&"📗",
				# 探す場所
				self.monkey().of_staff().scenario_writer().owner_node(),
				func(child_node):
					# デパートメント名を記憶
					self.all_department_names.append(child_node.name))

	return self.all_department_names
