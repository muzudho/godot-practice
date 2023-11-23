# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


var Department = load("res://🍋scripts/🪑grayscale_🍉visual_novel/department.gd")


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 全角数字
var zenkaku_numbers = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]

# デパートメント変数辞書（キー：StringName型）
var departments = {}

# 全部門名
var all_department_names = null

# 全命令（キー："命令名:"　値：ノード名）
var directory_for_instruction_code_and_node_name = null

# 全背景
var cache_dictionary_for_background_image = {}

# 全BGM
var cache_dictionary_for_bgm = {}

# 現在の部門（StringName型）
var current_department_name = null

# 全イラスト
var cache_dictionary_for_illust = {}

# 全命令（キー：ノード名　値：ノード）
var cache_dictionary_for_instruction = {}

# 全メッセージ・ウィンドウGUI
var cache_dictionary_for_message_window_gui = {}

# 全SE
var cache_dictionary_for_se = {}

# 全テロップ
var cache_dictionary_for_telop = {}

# `department:` 命令に失敗すると、次の `goto:` 命令は１回無視されるというルール。
# 次の `goto:` 命令に到達するか、次の `department:` 命令に成功するか、 ト書きが終わると解除
var is_department_not_found = false


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../🌏Director"


# 背景アーティスト
func get_background_artist():
	return self.get_director().get_node("🌏BackgroundArtist")


# イラストレーター取得
func get_illustrator():
	return self.get_director().get_node("🌏Illustrator")


# メッセージ・ウィンドウズ取得
func get_message_windows_node():
	return self.get_director().get_node("🌏GuiArtist_MessageWindows")


# モンスターの全身像
func get_monster_whole_body():
	return self.get_director().get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func get_monster_faces():
	return self.get_director().get_node("MonsterTrainer/Faces")


# BGM取得
func get_musician_bgm():
	return self.get_director().get_node("🌏Musician_BGM")


# SE取得
func get_musician_se():
	return self.get_director().get_node("🌏Musician_SE")


# プログラマー取得
func get_programmer():
	return self.get_director().get_node("🌏Programmer")


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("🌏ScenarioWriter")


# シナリオライター・ハブ取得
func get_scenario_writers_hub():
	return self.get_director().get_node("🌏ScenarioWriter/🛩️ScenarioWritersHub_🍉VisualNovel")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("🌏TelopCoordinator")


# ーーーーーーーー
# 子パス関連
# ーーーーーーーー


# 背景ノード取得
func get_background_image(
		target_name):			# StringName. `🗻` で始まる名前を想定
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_background_artist(),	# 探す場所
			func():
				return self.cache_dictionary_for_background_image)	# 結果を格納する変数


# BGM取得
func get_bgm(
		target_name):
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_musician_bgm(),			# 探す場所
			func():
				return self.cache_dictionary_for_bgm)	# 結果を格納する変数


# イラスト取得
func get_illust(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_illustrator(),	# 探す場所
			func():
				return self.cache_dictionary_for_illust)	# 結果を格納する変数


# 命令ノード取得
func get_instruction(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_programmer(),	# 探す場所
			func():
				return self.cache_dictionary_for_instruction)	# 結果を格納する変数


# 伝言窓（現在、出力の対象になっているもの）
func get_message_window_gui(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_message_windows_node(),	# 探す場所
			func():
				return self.cache_dictionary_for_message_window_gui)	# 結果を格納する変数


# 効果音取得
func get_se(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_musician_se(),			# 探す場所
			func():
				return self.cache_dictionary_for_se)	# 結果を格納する変数


# テロップ取得
func get_telop(
		target_name):	# StringName
	return MonkeyHelper.find_node_in_folder(
			target_name,
			func():
				return self.get_telop_coordinator(),	# 探す場所
			func():
				return self.cache_dictionary_for_telop)	# 結果を格納する変数


# 全ての部門名一覧
func get_all_department_names():
	if self.all_department_names == null:
		self.all_department_names = []	# StringName の配列

		# 結果は変数に格納される
		self.search_all_department_names(
				self.get_scenario_writer())
			
	return self.all_department_names


# 結果は変数に格納される
func search_all_department_names(current_node):
	for child_node in current_node.get_children():
		# 部門のノード名は `📗` で始まるものとする
		if child_node.name.begins_with("📗"):
			self.all_department_names.append(child_node.name)
		
		# `📂` で始まるノード名は、さらにその中も再帰的に探索されるものとする
		elif child_node.name.begins_with("📂"):
			self.search_all_department_names(child_node)


# 全ての命令コード一覧
func get_all_instruction_codes():
	if self.directory_for_instruction_code_and_node_name == null:
		self.directory_for_instruction_code_and_node_name = {}	# キー：StringName, 値：None

		# 結果は変数に格納される
		self.search_all_instruction_codes(
				self.get_programmer())
			
	return self.directory_for_instruction_code_and_node_name


# 結果は変数に格納される
func search_all_instruction_codes(current_node):
	for child_node in current_node.get_children():
		# 命令のノード名は `📗` で始まるものとする
		if child_node.name.begins_with("📗"):
			self.directory_for_instruction_code_and_node_name[child_node.code] = child_node.name
		
		# `📂` で始まるノード名は、さらにその中も再帰的に探索されるものとする
		elif child_node.name.begins_with("📂"):
			self.search_all_instruction_codes(child_node)


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー


func _ready():
	# メッセージ・ウィンドウに対応関数紐づけ
	for message_window in self.get_message_windows_node().get_children():
		# `■` で始まる名前のノードを、メッセージ・ウィンドウの名前とします
		if message_window.name.begins_with("■"):
			# メッセージ・ウィンドウのページ送り時、パーサーのロックを解除
			message_window.on_message_window_page_forward = func():
				self.get_current_department_value().set_parse_lock(false)

	# デパートメント変数辞書作成
	for department_name in self.get_all_department_names():
		# 生成
		var department_value = Department.new()

		# 部門名をコピー
		department_value.name = department_name		# StringName 型

		# メッセージを出力する対象となるウィンドウの名前。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
		department_value.stack_of_last_displayed_message_window.push_back(&"■FullScreen")	# StringName 型 シンタックス・シュガー

		# 先頭セクションの名前
		department_value.section_name = self.get_scenario_writers_hub().get_merged_scenario_document(department_name).keys()[0]

		self.departments[department_name] = department_value


# ーーーーーーーー
# その他
# ーーーーーーーー


# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
	
	# ［ト書き］かどうか判定
	var first_head_tail = self.split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
	
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［助監］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = self.split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]
			# print("［助監］　second_head：[" + second_head + "]")
			# print("［助監］　second_tail：[" + second_tail + "]")
			# 文字列の配列に分割
			var string_packed_array = second_head.split(":", true, 1)
			var instruction_code = string_packed_array[0] + ":"

			# 以下の命令は、アルファベット順で並べてある
			#
			# コメント
			if second_head.begins_with("#"):
				pass

			else:
				# `bg:` といったコードから、 `📗Bg` といった命令ノードを検索し、それを実行します
				if instruction_code in self.directory_for_instruction_code_and_node_name:
					var instruction_node_name = self.directory_for_instruction_code_and_node_name[instruction_code]
					var instruction = self.get_instruction(instruction_node_name)
					instruction.do_it(second_head)
				
			# さらに先頭行を取得
			second_head_tail = split_head_line_or_tail(second_tail)

		# ーーーーーーーー
		# ［ト書き］終わり
		# ーーーーーーーー
		self.is_department_not_found = false
		return

	var message_window_gui = self.get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)
		return

	# print("［助監］　選択肢ではない")
	self.get_instruction(&"📘NormalText").do_it(paragraph_text)


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
				print("［助監　変数展開］　変数キー：［" + key + "］")
				
				if key in self.get_director().stage_directions_variables:
					var value = self.get_director().stage_directions_variables[key]
					print("［助監　変数展開］　変数値：［" + value + "］")
				
					terget_after_change += value
				
				else:
					print("［助監　変数展開］　変数値が見つかりません")
					
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


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var department_value = self.get_current_department_value()
	var scenario_node_name = department_value.name		# StringName
	var section_name =  department_value.section_name
	
	var section_array = self.get_scenario_writers_hub().get_section_array(scenario_node_name, section_name)
	return section_array.size()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	var merged_scenario_document = self.get_scenario_writers_hub().get_merged_scenario_document(department_value.name)
	return merged_scenario_document[department_value.section_name][message_window_gui.section_item_index]


# 「§」セクションの再生
func play_section():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	# 全部消化済みの場合
	if self.get_current_section_size_of_scenario() <= message_window_gui.section_item_index:
		print("［助監］（" + department_value.name + "　" + department_value.section_name + "）　セクションを読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window_gui.statemachine_of_message_window.is_completed():
			print("［助監］（" + department_value.name + "　"+ department_value.section_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not message_window_gui.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window_gui.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［助監］（" + department_value.name + "　"+ department_value.section_name + "）　パースを開始してよい（本当か？）")
			# パースを開始してよい
			department_value.set_parse_lock(false)


# 伝言窓で選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［助監］　選択肢を確定させた")

	# 伝言窓の状態遷移
	#	ずっと Completed だと、困るから
	print("［助監］　伝言窓を　オール・ページズ・フラッシュド　する")
	self.get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


	var department_value = self.get_current_department_value()
	var department_name = str(department_value.name)
	var section_name = department_value.section_name
	
	print("［助監］　現在の部門名　　　：" + department_name)
	print("［助監］　現在の区画名　　　：" + section_name)
	print("［助監］　選んだ選択肢行番号：" + str(row_number))

	# 辞書
	var choices_mappings_a = self.get_scenario_writers_hub().get_merged_choices_mappings(department_name)

	# 区画名。実質的には選択肢の配列
	var section_obj = choices_mappings_a[section_name]

	# 次のセクション名
	var next_section_name = section_obj[row_number]
	print("［助監］　次の区画名　　　　：" + next_section_name)
	
	self.set_current_section(next_section_name)
	self.play_section()


# ディレクターの `_process(delta)` が呼出す
func on_process(delta):

	if 0.0 < self.get_director().sleep_seconds:
		self.get_director().sleep_seconds -= delta

		# 疑似スリープ値が残っている間は、シナリオを進めません
		return

	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	# パースを開始してよいか？（ここで待機しないと、一瞬で全部消化してしまう）
	if not department_value.is_parse_lock():
		
		# まだあるよ
		if message_window_gui.section_item_index < self.get_current_section_size_of_scenario():
		
			# 現在のシナリオの次のパラグラフを取得
			var paragraph = self.get_current_paragraph_of_scenario()

			# カウントアップ
			message_window_gui.section_item_index += 1
			
			if paragraph is String:
				
				var latest_message = paragraph + ""	# 文字列を参照ではなく、コピーしたい

				# ここで、命令と、台詞は区別する
				self.parse_paragraph(latest_message)
			
			else:
				# TODO 文字列以外のパラグラフに対応したい
				print("［助監］　TODO 匿名関数かもしれない呼出してみよ")
				paragraph.call()

		# もう無いよ
		else:
			if not self.get_current_message_window_gui().statemachine_of_message_window.is_none():
				# 伝言窓を閉じる
				self.get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


# 部門変数取得
func get_department_value(
		department_name):	# StringName
	return self.departments[department_name]


# 現在の部門変数
func get_current_department_value():
	return self.get_department_value(self.current_department_name)


# 伝言窓（現在、出力の対象になっているもの）
func get_current_message_window_gui():
	var department_value = self.get_current_department_value()
	if department_value.stack_of_last_displayed_message_window.size() < 1:
		print("［監督］　▲！　最後に表示したメッセージウィンドウが無い")

	var node_name = department_value.stack_of_last_displayed_message_window[-1]
	#print("［監督］　伝言窓名：［" + node_name + "］")
	return self.get_message_window_gui(str(node_name))


# 現在の「§」セクション設定
func set_current_section(section_name):
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	department_value.section_name = section_name
	message_window_gui.section_item_index = 0


# 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
func dump_last_displayed_message_window():
	print("［監督］　各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示")
	
	# 部門名一覧
	var department_names = self.get_all_department_names()
	for department_name in 	department_names:
		print("　　部門：　" + department_name)

		# 部門変数
		var department = self.get_department_value(department_name)
		
		for window_name in department.node_names_of_currently_displayed_message_window:
			print("　　　　👁 " + window_name)
