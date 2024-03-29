# プログラマー・モンキー（Programmer Monkey；プログラマーの猿）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}

# 全部門名
var all_department_names = null


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
	return $"../../👤Programmer"


# 部門制御取得
func department_controller_node():
	return self.owner_node().get_node("📂DepartmentController_🍉VisualNovel")


# 部門制御の猿取得
func department_controller():
	return self.department_controller_node().get_node("🐵Monkey")


# 入力取得
func input_node():
	return self.owner_node().get_node("🕹️Input")


# キー・コンフィグ取得
func key_config_node():
	return self.owner_node().get_node("🎬🍉KeyConfig")


# キー・コンフィグの猿取得
func key_config():
	return self.owner_node().get_node("🎬🍉KeyConfig/🐵Monkey")


# 伝言窓たち取得
func message_windows_globe_node():
	return self.owner_node().get_node("🌏MessageWindows")


# 伝言窓たちの猿取得
func message_windows_globe():
	return self.message_windows_globe_node().get_node("🐵Monkey_🍉VisualNovel")


# シナリオ再生機取得
func scenario_player_node():
	return self.owner_node().get_node("🎬ScenarioPlayer_🍉VisualNovel")


# シナリオ再生機の猿取得
func scenario_player():
	return self.scenario_player_node().get_node("🐵Monkey")


# 命令ノード取得
func get_instruction_node(
		target_name):	# StringName
	return self.scenario_player().get_instruction_node(target_name)


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
