# アシスタント・ディレクター（Assistant Director；助監督）
extends Node

# 状態遷移機械
var statemachine = load("scripts/AssistantDirectorStatemachine.gd").new()

# メッセージウィンドウが指示待ちか？
var is_message_window_waiting_for_order = false

# 現在実行中の段落名
var current_paragraph_name = null

var scenario_array = []


# 台本の再生の開始の合図
func play_paragraph(paragraph_name):
	self.current_paragraph_name = paragraph_name
	
	# シナリオ・ブックから、内容を取出す
	print("［アシスタント・ディレクター］　シナリオ・ブックから、内容を取出す")
	self.scenario_array = $"../ScenarioBook".document[self.current_paragraph_name]

	# ウィンドウを空っぽにして、次の指示を待ちます（強制的に、そういうことにしておく）
	$"../MessageWindow".clear_and_awaiting_order()

	# 再生中へ
	self.statemachine.play()


# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［アシスタント・ディレクター］　現在の段落名　　　：" + self.current_paragraph_name)
	print("［アシスタント・ディレクター］　選んだ選択肢行番号：" + str(row_number))

	# 次の段落名
	var next_paragraph_name = $"../ScenarioBook".index[self.current_paragraph_name][row_number]
	print("［アシスタント・ディレクター］　次の段落名　　　　：" + next_paragraph_name)
	
	self.play_paragraph(next_paragraph_name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
	# 再生中
	if self.statemachine.is_playing():
		
		# メッセージウィンドウが指示待ちか？
		if is_message_window_waiting_for_order:
			
			# まだあるよ
			if 0 < self.scenario_array.size():
			
				# 次に表示するべきメッセージを取得
				var latest_message = self.scenario_array.pop_front()

				# TODO ここで、命令と、台詞に分解したい
				self.parse_message(latest_message)

			# もう無いよ
			else:
				if not $"../MessageWindow".statemachine.is_none():
					# メッセージ・ウィンドウを閉じる
					$"../MessageWindow".initialize()


#	先頭行と、それ以外に分けます。できなければヌル
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


# 命令か、台詞か、によって処理を分けます
func parse_message(temp_text):
	
	# 命令かどうか判定
	var first_head_tail = split_head_line_or_tail(temp_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
	
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［アシスタント・ディレクター］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]

			# 以下の命令は、アルファベット順で並べてある
			#
			# 背景切替
			if second_head.begins_with("bg:"):
				$"Bg".do_it(second_head)
				return

			# ＢＧＭ再生／停止
			if second_head.begins_with("bgm:"):
				$"Bgm".do_it(second_head)
				return
			
			
			# 選択肢かどうか判定
			elif second_head.begins_with("choice:"):
				$"Choice".do_it(second_head)
				return
			
			
			# センター・ウィンドウの表示／非表示
			elif second_head.begins_with("cwnd:"):
				$"Cwnd".do_it(second_head)
				return
				
				
			# 次の段落へ飛ぶ
			elif second_head.begins_with("goto:"):
				$"Goto".do_it(second_head, self.play_paragraph)
				return


			# アプリケーション終了
			elif second_head.begins_with("quit:"):
				$"Quit".do_it(second_head)
				return


			# シーンの表示／非表示
			elif second_head.begins_with("scene:"):
				$"Scene".do_it(second_head)
				return

			
			# 効果音
			elif second_head.begins_with("se:"):
				$"Se".do_it(second_head)
				return

			# さらに先頭行を取得
			second_head_tail = split_head_line_or_tail(second_tail)


	if $"Choice".choice_row_number_array != null:
		print("［アシスタント・ディレクター］　選択肢だ：[" + temp_text + "]")

		# この台詞は選択肢として扱う
		$"../MessageWindow".push_choices($"Choice".choice_row_number_array, temp_text)
		self.is_message_window_waiting_for_order = false

		#	処理終わり
		$"Choice".choice_row_number_array = null
		return

	# print("［メッセージ・ウィンドウ］　選択肢ではない")
	$"../MessageWindow".push_message(temp_text)
	self.is_message_window_waiting_for_order = false
