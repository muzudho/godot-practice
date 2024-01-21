# シナリオ再生エンジン
# TODO ここにシナリオを読取る処理を移動したい
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}

# 全命令（キー："命令名:"　値：ノード名）
var directory_for_instruction_code_and_node_name = null

# `department:` 命令に失敗すると、次の `goto:` 命令は１回無視されるというルール。
# 次の `goto:` 命令に到達するか、次の `department:` 命令に成功するか、 ト書きが終わると解除
var is_department_not_found = false


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestors)


# 全ての命令コード一覧
func get_all_instruction_codes():
	if self.directory_for_instruction_code_and_node_name == null:
		self.directory_for_instruction_code_and_node_name = {}	# キー：StringName, 値：None

		MonkeyHelper.search_node_name_begins_with(
				# 命令のノード名は `📗` で始まるものとする
				&"📗",
				# 探す場所
				# 本当は `👤Programmer` ノードの下のどこかにある `📂ScenarioPlayer_🍉VisualNovel` ノードのさらに下の `📂Instructions` ノードの下を探して欲しいが。
				self.monkey().of_staff().programmer().owner_node(),
				func(child_node):
					# コードにノード名を紐づける
					self.directory_for_instruction_code_and_node_name[child_node.code] = child_node.name)

	return self.directory_for_instruction_code_and_node_name


# ーーーーーーーー
# プロパティーズ
# ーーーーーーーー


# 現在の部門変数
func get_current_department_value():
	return self.monkey().owner_node().get_department_value(self.monkey().owner_node().current_department_name)


# 現在の「§」セクション設定
func set_current_section(section_name):
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	department_value.section_name = section_name
	message_window_gui.section_item_index = 0


# 伝言窓（現在、出力の対象になっているもの）
func get_current_message_window_gui():
	var department_value = self.get_current_department_value()
	if department_value.stack_of_last_displayed_message_window.size() < 1:
		print("［プログラマーズ・ハブ］　▲！　最後に表示したメッセージウィンドウが無い")

	var node_name = department_value.stack_of_last_displayed_message_window[-1]
	#print("［監督］　伝言窓名：［" + node_name + "］")
	return self.monkey().owner_node().message_window_programs.find_node(str(node_name))


# 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
func dump_last_displayed_message_window():
	print("［プログラマーズ・ハブ］　各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示")
	
	# 部門名一覧
	var department_names = self.monkey().get_all_department_names()
	for department_name in 	department_names:
		print("　　部門：　" + department_name)

		# 部門変数
		var department = self.monkey().owner_node().get_department_value(department_name)
		
		for window_name in department.node_names_of_currently_displayed_message_window:
			print("　　　　👁 " + window_name)


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var department_value = self.get_current_department_value()
	var scenario_node_name = department_value.name		# StringName
	var section_name =  department_value.section_name
	
	var section_array = self.monkey().of_staff().scenario_writer().owner_node().get_section_array(scenario_node_name, section_name)
	return section_array.size()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	var merged_scenario_document = self.monkey().of_staff().scenario_writer().get_merged_scenario_document(department_value.name)
	return merged_scenario_document[department_value.section_name][message_window_gui.section_item_index]


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# 「§」セクションの再生
func play_section():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.get_current_message_window_gui()

	# 全部消化済みの場合
	if self.get_current_section_size_of_scenario() <= message_window_gui.section_item_index:
		print("［シナリオ再生エンジン］（" + department_value.name + "　" + department_value.section_name + "）　セクションを読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window_gui.statemachine_of_message_window.is_completed():
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.section_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not message_window_gui.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window_gui.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.section_name + "）　パースを開始してよい（本当か？）")
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
	var choices_mappings_a = self.monkey().of_staff().scenario_writer().get_merged_choices_mappings(department_name)

	# 区画名。実質的には選択肢の配列
	var section_obj = choices_mappings_a[section_name]

	# 次のセクション名
	var next_section_name = section_obj[row_number]
	print("［助監］　次の区画名　　　　：" + next_section_name)
	
	self.monkey().scenario_player().set_current_section(next_section_name)
	self.monkey().scenario_player().play_section()


# ディレクターの `_process(delta)` が呼出す
func on_process(delta):

	if 0.0 < self.monkey().of_staff().programmer().owner_node().sleep_seconds:
		self.monkey().of_staff().programmer().owner_node().sleep_seconds -= delta

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
				self.monkey().scenario_player().parse_paragraph(latest_message)
			
			else:
				# TODO 文字列以外のパラグラフに対応したい
				print("［助監］　TODO 匿名関数かもしれない呼出してみよ")
				paragraph.call()

		# もう無いよ
		else:
			if not self.get_current_message_window_gui().statemachine_of_message_window.is_none():
				# 伝言窓を閉じる
				self.get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
		
	# ト書きなら実行
	if self.execute_stage_directions(paragraph_text):
		# すれば抜ける
		return

	# 選択肢なら表示
	if self.print_choices(paragraph_text):
		# すれば抜ける
		return

	# 通常文書の表示
	self.print_normal_text(paragraph_text)


# 通常文書の表示	
func print_normal_text(paragraph_text):
	#print("［シナリオエンジン］　準備中　通常文書の表示")
	self.monkey().get_instruction(&"📘NormalText").do_it(paragraph_text)


# 選択肢なら表示
func print_choices(paragraph_text):
	#print("［シナリオエンジン］　準備中　選択肢なら表示")
	var message_window_gui = self.get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.monkey().get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)
		return true

	return false


# ト書きなら実行
func execute_stage_directions(paragraph_text):
	print("［シナリオエンジン］　準備中　ト書きなら実行")
	
	# ［ト書き］かどうか判定
	var first_head_tail = self.monkey().owner_node().split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
		
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［助監］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = self.monkey().owner_node().split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]
			# print("［助監］　second_head：[" + second_head + "]")
			# print("［助監］　second_tail：[" + second_tail + "]")
			# 文字列の配列に分割
			var string_packed_array = second_head.split(":", true, 1)
			var instruction_code = string_packed_array[0] + ":"

			# コメント
			if second_head.begins_with("#"):
				pass

			else:
				# 例えば `img:` といったコードから、 `📗Img` といった命令ノードを検索し、それを実行します
				if instruction_code in self.directory_for_instruction_code_and_node_name:
					var instruction_node_name = self.directory_for_instruction_code_and_node_name[instruction_code]
					var instruction = self.monkey().get_instruction(instruction_node_name)
					instruction.do_it(second_head)
				
			# さらに先頭行を取得
			second_head_tail = self.monkey().owner_node().split_head_line_or_tail(second_tail)

		# ーーーーーーーー
		# ［ト書き］終わり
		# ーーーーーーーー
		self.is_department_not_found = false
		return true

	return false

