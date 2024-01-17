# プログラム・ハブ（Program Hub；プログラムの中心地）
# TODO このファイルの内容は、`📄Nodes_🍉xxxx` に小分けにしていきたい。少なくしたい
extends Node


var Department = load("res://🍋scripts/🪑grayscale_🍉visual_novel/department.gd")


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# アドオン・スロット
# ーーーーーーーー

# BGMノードのキャッシュ
var bg_musics = null

# メッセージ・ウィンドウ・プログラムのキャッシュ
var message_window_programs = null

# イラスト・ノードのキャッシュ
var images = null

# サウンド・エフェクト（Sound Effect, Sound FX；効果音）のキャッシュ
var sound_fx = null

# テロップのキャッシュ
var telops = null


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 監督ハブ取得
func get_director_hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🛩️Hub",
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
				self.get_director_hub().scenario_writer_hub().owner_node(),
				func(child_node):
					# デパートメント名を記憶
					self.all_department_names.append(child_node.name))

	return self.all_department_names


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー


func _ready():
	# メッセージ・ウィンドウに対応関数紐づけ
	MonkeyHelper.search_node_name_begins_with(
			# メッセージ・ウィンドウの名前は `■` で始まるものとする
			&"■",
			# 探す場所
			self.get_director_hub().gui_programmer_message_windows(),
			func(child_node):
				# メッセージ・ウィンドウのページ送り時、パーサーのロックを解除
				child_node.on_message_window_page_forward = func():
					self.scenario_player().get_current_department_value().set_parse_lock(false))

	# デパートメント変数辞書作成
	for department_name in self.get_all_department_names():
		# 生成
		var department_value = Department.new()

		# 部門名をコピー
		department_value.name = department_name		# StringName 型

		# メッセージを出力する対象となるウィンドウの名前。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
		department_value.stack_of_last_displayed_message_window.push_back(&"■FullScreen")	# StringName 型 シンタックス・シュガー

		# 先頭セクションの名前
		department_value.section_name = self.get_director_hub().scenario_writer_hub().get_merged_scenario_document(department_name).keys()[0]

		self.departments[department_name] = department_value


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 全角数字
var zenkaku_numbers = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]

# デパートメント変数辞書（キー：StringName型）
var departments = {}

# 全部門名
var all_department_names = null

# 現在の部門（StringName型）
var current_department_name = null

# 全命令（キー：ノード名　値：ノード）
var cache_dictionary_for_instruction = {}


# ーーーーーーーー
# その他
# ーーーーーーーー


# 変数展開する
# `target_before_change` - １行かもしれないし、段落かもしれないし、匿名関数かもしれない
func expand_variables(target_before_change):
	
	target_before_change = target_before_change.strip_edges()
		
	if target_before_change is String:
		# ここで `{{banana}} などの引数を　変数展開したい
		
		# 無限に変数展開することを防ぐため、変換前文字列と、変換後文字列は別途用意する
		var terget_after_change = ""
				
		var from = 0
		
		while from < target_before_change.length():
			var open_index = target_before_change.find("{{", from)
			var close_index = target_before_change.find("}}", from)
			
			if from <= open_index and open_index + 2 < close_index:

				# Head
				terget_after_change += target_before_change.substr(from, open_index - from)

				# 変数名取得
				var key = target_before_change.substr(open_index + 2, close_index - (open_index + 2))
				print("［プログラマーズ・ハブ　変数展開］　変数キー：［" + key + "］")
				
				if key in self.get_director_hub().owner_node().stage_directions_variables:
					var value = self.get_director_hub().owner_node().stage_directions_variables[key]
					print("［プログラマーズ・ハブ　変数展開］　変数値：［" + value + "］")
				
					terget_after_change += value
				
				else:
					print("［プログラマーズ・ハブ　変数展開］　変数値が見つかりません")
					
					# 仕方ないので、カッコ悪いが、キー（ハンドルバー）を画面に表示する
					terget_after_change += "{{" + key + "}}"

				from = close_index + 2
		
			else:
				#print("［助監　変数展開］　対象なし　段落：［" + target_before_change + "］")
				terget_after_change += target_before_change.substr(from)
				break

		return terget_after_change
	
	else:
		#print("［助監　変数展開］　対象なし　非テキスト")
		return target_before_change


# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
func trim_double_quotation(line):
	if 2 <= line.length() and line[0]=="\"" and line[-1]=="\"":
		return line.substr(1, line.length()-2)
	
	return line


# 先頭行と、それ以外に分けます。できなければヌル
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	
	if index < 0:
		return null
	
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［助監］　head：　[" + head + "]")
	# print("［助監］　tail：　[" + tail + "]")
	return [head, tail]


# 数値を全角テキストに変換
func number_to_zenkaku_text(number, figures):
	var zenkaku_text = ""
	
	while 0 < number:
		var zenkaku_num = self.zenkaku_numbers[number % 10]
		number /= 10
		
		zenkaku_text = zenkaku_num + zenkaku_text
	
	# 左側に全角空白を詰める
	var spaces = figures - zenkaku_text.length()
	for i in range(spaces):
		zenkaku_text = "　" + zenkaku_text
		
	return zenkaku_text


# 部門変数取得
func get_department_value(
		department_name):	# StringName
	return self.departments[department_name]
