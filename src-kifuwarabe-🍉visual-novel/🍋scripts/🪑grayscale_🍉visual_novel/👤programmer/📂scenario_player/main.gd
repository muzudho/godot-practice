# シナリオ・プレイヤー（Scenario Player；台本再生機）
#
# TODO ここにシナリオを読取る処理を移動したい
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 下に居る猿
func sub_monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 時計
# ーーーーーーーー

func on_process(delta):
	self.sub_monkey().clock().on_process(delta)


# ーーーーーーーー
# プロパティーズ
# ーーーーーーーー

# 現在の部門変数
func get_current_department_value():
	return self.sub_monkey().of_programmer().owner_node().get_department_value(
			self.sub_monkey().of_programmer().owner_node().current_department_name)


# 現在の「§」セクション設定
func set_current_section(section_name):
	var department_value = self.get_current_department_value()
	var message_window_gui = self.sub_monkey().get_current_message_window_gui()

	department_value.section_name = section_name
	message_window_gui.section_item_index = 0


# 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
func dump_last_displayed_message_window():
	print("［プログラマーズ・ハブ］　各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示")
	
	# 部門名一覧
	var department_names = self.sub_monkey().of_programmer().get_all_department_names()
	for department_name in 	department_names:
		print("　　部門：　" + department_name)

		# 部門変数
		var department = self.sub_monkey().of_programmer().owner_node().get_department_value(department_name)
		
		for window_name in department.node_names_of_currently_displayed_message_window:
			print("　　　　👁 " + window_name)


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var department_value = self.get_current_department_value()
	var scenario_node_name = department_value.name		# StringName
	var section_name =  department_value.section_name
	
	var section_array = self.sub_monkey().of_staff().scenario_writer().owner_node().get_section_array(scenario_node_name, section_name)
	return section_array.size()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.sub_monkey().get_current_message_window_gui()

	var merged_scenario_document = self.sub_monkey().of_staff().scenario_writer().owner_node().get_merged_scenario_document(department_value.name)
	return merged_scenario_document[department_value.section_name][message_window_gui.section_item_index]


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー

# 「§」セクションの再生
func play_section():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.sub_monkey().get_current_message_window_gui()

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
	self.sub_monkey().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


	var department_value = self.get_current_department_value()
	var department_name = str(department_value.name)
	var section_name = department_value.section_name
	
	print("［助監］　現在の部門名　　　：" + department_name)
	print("［助監］　現在の区画名　　　：" + section_name)
	print("［助監］　選んだ選択肢行番号：" + str(row_number))

	# 辞書
	var choices_mappings_a = self.sub_monkey().of_staff().scenario_writer().owner_node().get_merged_choices_mappings(department_name)

	# 区画名。実質的には選択肢の配列
	var section_obj = choices_mappings_a[section_name]

	# 次のセクション名
	var next_section_name = section_obj[row_number]
	print("［助監］　次の区画名　　　　：" + next_section_name)
	
	self.set_current_section(next_section_name)
	self.play_section()


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
	self.sub_monkey().of_programmer().get_instruction(&"📘NormalText").do_it(paragraph_text)


# 選択肢なら表示
func print_choices(paragraph_text):
	#print("［シナリオエンジン］　準備中　選択肢なら表示")
	var message_window_gui = self.sub_monkey().get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.sub_monkey().of_programmer().get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)
		return true

	return false


# ト書きなら実行
func execute_stage_directions(paragraph_text):
	print("［シナリオエンジン］　準備中　ト書きなら実行")
	
	# ［ト書き］かどうか判定
	var first_head_tail = StringHelper.split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
		
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［助監］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = StringHelper.split_head_line_or_tail(first_tail)
		
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
				if instruction_code in self.sub_monkey().internal().directory_for_instruction_code_and_node_name:
					var instruction_node_name = self.sub_monkey().internal().directory_for_instruction_code_and_node_name[instruction_code]
					var instruction = self.sub_monkey().of_programmer().get_instruction(instruction_node_name)
					instruction.do_it(second_head)
				
			# さらに先頭行を取得
			second_head_tail = StringHelper.split_head_line_or_tail(second_tail)

		# ーーーーーーーー
		# ［ト書き］終わり
		# ーーーーーーーー
		self.sub_monkey().internal().is_department_not_found = false
		return true

	return false

