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


# 先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1, text.length() - (index+1))
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
		var second_head = second_head_tail[0].strip_edges()
		var second_tail = second_head_tail[1]
	
		# 次の段落へ飛ぶ
		if second_head.begins_with("goto:"):

			# head
			var next_paragraph_name = second_head.substr(5).strip_edges()
			print("［アシスタント・ディレクター］　次の段落へ飛ぶ：[" + next_paragraph_name + "]")
			
			self.play_paragraph(next_paragraph_name)
			return
	
		# 選択肢かどうか判定
		elif second_head.begins_with("choice:"):
			print("［アシスタント・ディレクター］　選択肢だ：[" + second_tail + "]")
			
			# head
			var csv = second_head.substr(7).strip_edges()
			# TODO 昇順であること
			var string_packed_array = csv.split(",", true, 0)
			var size = string_packed_array.size()
			# print("［メッセージ・ウィンドウ］　選択肢サイズ：" + str(size))

			# 文字列型の配列を、数の配列に変換
			var row_numbers = []
			row_numbers.resize(size)
			# print("［メッセージ・ウィンドウ］　行番号一覧")
			for i in range(0, size):
				row_numbers[i] = string_packed_array[i].to_int()
				# print(str(row_numbers[i])

			$"../MessageWindow".push_choices(row_numbers, second_tail)
			
			self.is_message_window_waiting_for_order = false
			return
			
		elif second_head.begins_with("bgm:"):
			print("［アシスタント・ディレクター］　ＢＧＭだ")

			# head
			var name = second_head.substr(4).strip_edges()
			print("［アシスタント・ディレクター］　ノード名：[" + name + "]")

			if name == "":
				# BGM 停止
				$"../Musician".stopBgm()
				
			else:
				# じゃあ BGM 流すか
				$"../Musician".playBgm(name)

			return
			
		elif second_head.begins_with("se:"):
			print("［アシスタント・ディレクター］　効果音だ")

			# head
			var name = second_head.substr(3, second_head.length()-3).strip_edges()
			print("［アシスタント・ディレクター］　ノード名：[" + name + "]")

			if name == "":
				# 効果音 停止
				$"../Musician".stopSe()
				
			else:
				# じゃあ 効果音 流すか
				$"../Musician".playSe(name)

			return
			
	# print("［メッセージ・ウィンドウ］　選択肢ではない")
	$"../MessageWindow".push_message(temp_text)
	self.is_message_window_waiting_for_order = false
