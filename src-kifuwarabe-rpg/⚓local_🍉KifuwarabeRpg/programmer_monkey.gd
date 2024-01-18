# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 自身取得
func monkey():
	return self


# 監督ハブ取得
func of_director():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🐵Monkey",
			self.ancestors)


# プログラマー取得
func owner_node():
	return self.get_node("../../🌏Programmer")


# シナリオ再生機取得
func scenario_player():
	return self.get_instruction("📄Engine_🍉VisualNovel")


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
				self.monkey().of_director().scenario_writer().owner_node(),
				func(child_node):
					# デパートメント名を記憶
					self.all_department_names.append(child_node.name))

	return self.all_department_names


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 全部門名
var all_department_names = null

# 全命令（キー：ノード名　値：ノード）
var cache_dictionary_for_instruction = {}
