# アシスタント・ディレクター（Assistant Director；助監督）
extends Node


# ディレクター取得
func get_director():
	return $"../../Director"


# シナリオライター取得
func get_scenario_writer():
	return $"../ScenarioWriter"


# ビジュアル・ノベル部のこの瞬間の状態
func get_snapshot(department_node_name):
	return $"../System/Snapshots".get_node(department_node_name)


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var snapshot = self.get_director().get_current_snapshot()
	return self.get_scenario_writer().get_node(str(snapshot.name)).document[snapshot.section_name].size()


# シナリオの現在セクションのアイテムを返す
func get_current_section_item_of_scenario():
	var snapshot = self.get_director().get_current_snapshot()
	return self.get_scenario_writer().get_node(str(snapshot.name)).document[snapshot.section_name][snapshot.section_item_index]


# 「§」セクションの再生
func play_section():
	var snapshot = self.get_director().get_current_snapshot()
	var message_window = self.get_director().get_current_message_window()

	# 全部消化済みの場合
	if self.get_current_section_size_of_scenario() <= snapshot.section_item_index:
		print("［アシスタント・ディレクター］（" + snapshot.name + "　" + snapshot.section_name + "）　セクションを読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window.statemachine_of_message_window.is_completed():
			print("［アシスタント・ディレクター］（" + snapshot.name + "　"+ snapshot.section_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not snapshot.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［アシスタント・ディレクター］（" + snapshot.name + "　"+ snapshot.section_name + "）　パースを開始してよい（本当か？）")
			# パースを開始してよい
			snapshot.set_parse_lock(false)


# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［アシスタント・ディレクター］　選択肢を確定させた")

	# メッセージ・ウィンドウの状態遷移
	#	ずっと Completed だと、困るから
	print("［アシスタント・ディレクター］　メッセージ・ウィンドウを　オール・ページズ・フラッシュド　する")
	self.get_director().get_current_message_window().statemachine_of_message_window.all_pages_flushed()


	var snapshot = self.get_director().get_current_snapshot()
	var department_name = str(snapshot.name)
	var section_name = snapshot.section_name
	
	print("［アシスタント・ディレクター］　現在の部門名　　　：" + department_name)
	print("［アシスタント・ディレクター］　現在の区画名　　　：" + section_name)
	print("［アシスタント・ディレクター］　選んだ選択肢行番号：" + str(row_number))

	# シナリオ・ノード
	var scenario_node = $"../ScenarioWriter".get_node(department_name)

	# 区画名。実質的には選択肢の配列
	var section_obj = scenario_node.choices_mappings[section_name]

	# 次のセクション名
	var next_section_name = section_obj[row_number]
	print("［アシスタント・ディレクター］　次の区画名　　　　：" + next_section_name)
	
	self.get_director().set_current_section(next_section_name)
	self.play_section()


# 先頭行と、それ以外に分けます。できなければヌル
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	
	if index < 0:
		return null
	
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［メッセージ・ウィンドウ］　head：　[" + head + "]")
	# print("［メッセージ・ウィンドウ］　tail：　[" + tail + "]")
	return [head, tail]


# 引数を変数展開する
func expand_param(line):
	
	line = line.strip_edges()
	
	if line is String:
		# ここで `%arg_1% などの引数を　変数展開したい
		if line.begins_with("%arg_"):

			# 頭の `%arg_` と、末尾の `%` を除去
			var key = line.substr(5, line.length() - 6)
			print("［アシスタント・ディレクター］　実引数キー：［" + key + "］")
			var value = self.get_director().instruction_arguments[key]
			print("［アシスタント・ディレクター］　実引数値：［" + value + "］")
			return value
	
	return line


# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
func trim_double_quotation(line):
	if 2 <= line.length() and line[0]=="\"" and line[-1]=="\"":
		return line.substr(1, line.length()-2)
	
	return line


# ［ト書き］か、［台詞］か、によって処理を分けます
func parse_section_item(paragraph_text):
	
	# ［ト書き］かどうか判定
	var first_head_tail = split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
	
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［アシスタント・ディレクター］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]
			# print("［アシスタント・ディレクター］　second_head：[" + second_head + "]")
			# print("［アシスタント・ディレクター］　second_tail：[" + second_tail + "]")

			# 以下の命令は、アルファベット順で並べてある
			#
			# コメント
			if second_head.begins_with("#"):
				pass
				
			# 実引数セット
			elif second_head.begins_with("arg:"):
				$"Arg".do_it(second_head)
				
			# 背景切替
			elif second_head.begins_with("bg:"):
				$"Bg".do_it(second_head)

			# ＢＧＭ再生／停止
			elif second_head.begins_with("bgm:"):
				$"Bgm".do_it(second_head)
			
			# 選択肢かどうか判定
			elif second_head.begins_with("choice:"):
				$"Choice".do_it(second_head)

			# 部門変更
			elif second_head.begins_with("department:"):
				$"Department".do_it(second_head)
				
			# 次のセクションへ飛ぶ
			elif second_head.begins_with("goto:"):
				$"Goto".do_it(second_head)

			# ラベル設定
			elif second_head.begins_with("label:"):
				$"Label".do_it(second_head)
				
			# モンスター表示
			elif second_head.begins_with("monster:"):
				$"Monster".do_it(second_head)

			# モンスター顔表示
			elif second_head.begins_with("monster_face:"):
				$"MonsterFace".do_it(second_head)

			# メッセージ出力先ウィンドウ変更
			elif second_head.begins_with("m_wnd:"):
				$"MWnd".do_it(second_head)

			# アプリケーション終了
			elif second_head.begins_with("quit:"):
				$"Quit".do_it(second_head)

			# スリープ
			elif second_head.begins_with("sleep:"):
				$"Sleep".do_it(second_head)

			# テロップの表示／非表示
			elif second_head.begins_with("telop:"):
				$"Telop".do_it(second_head)
			
			# 効果音
			elif second_head.begins_with("se:"):
				$"Se".do_it(second_head)
			
			# ビューイング・ウィンドウの表示／非表示
			elif second_head.begins_with("v_wnd:"):
				$"VWnd".do_it(second_head)

			# さらに先頭行を取得
			second_head_tail = split_head_line_or_tail(second_tail)

		#	［ト書き］終わり
		return

	var snapshot = self.get_director().get_current_snapshot()

	# 選択肢だ
	if snapshot.choices_row_numbers != null:
		$"NormalTextChoice".do_it(paragraph_text)
		return

	# print("［メッセージ・ウィンドウ］　選択肢ではない")
	$"NormalText".do_it(paragraph_text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if 0.0 < self.get_director().sleep_seconds:
		self.get_director().sleep_seconds -= delta

		# 疑似スリープ値が残っている間は、シナリオを進めません
		return

	var snapshot = self.get_director().get_current_snapshot()

	# パースを開始してよいか？（ここで待機しないと、一瞬で全部消化してしまう）
	if not snapshot.is_parse_lock():
		
		# まだあるよ
		if snapshot.section_item_index < self.get_current_section_size_of_scenario():
		
			# 次に表示するべきメッセージを取得
			var latest_message = self.get_current_section_item_of_scenario() + ""	# 文字列を参照ではなく、コピーしたい

			# カウントアップ
			snapshot.section_item_index += 1

			# ここで、命令と、台詞は区別する
			self.parse_section_item(latest_message)

		# もう無いよ
		else:
			if not self.get_director().get_current_message_window().statemachine_of_message_window.is_none():
				# メッセージ・ウィンドウを閉じる
				self.get_director().get_current_message_window().statemachine_of_message_window.all_pages_flushed()
