#	アシスタント・ディレクター（Assistant Director；助監督）
extends Node


#	状態機械
var statemachine_of_director = null


#	メッセージが入っている
var scenario_array = []


#	ビジュアル・ノベル部のこの瞬間の状態
func get_director():
	return $"../../Director"


#	メッセージ・ウィンドウ
func get_message_window(
	message_window_name_obj):		# StringName
	return $"../GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))

#	メッセージ・ウィンドウ
func get_current_message_window():
	# TODO ちゃんと作る必要がある
	var message_window_name_obj = $"../System/Snapshots/VisualNovelDepartment".message_window_name_obj
	return $"../GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))


#	ビジュアル・ノベル部のこの瞬間の状態
func get_snapshot(department_node_name):
	return $"../System/Snapshots".get_node(department_node_name)


#	台本の再生の開始の合図
func play_visual_novel(paragraph_name):
	self.get_snapshot("VisualNovelDepartment").paragraph_name = paragraph_name

	# シナリオ・ブックから、内容を取出す
	print("［アシスタント・ディレクター］　シナリオ・ブックから、内容を取出す")
	self.scenario_array = $"../ScenarioWriter/VisualNovelDepartment".document[self.get_snapshot("VisualNovelDepartment").paragraph_name]

	# メッセージ・ウィンドウは、次の指示を待っています
	self.get_snapshot("VisualNovelDepartment").is_message_window_waiting_for_order = true

	# 再生中へ
	self.statemachine_of_director.play_visual_novel()


# メッセージ出力先ウィンドウ変更。ノード名を指定
func redirect_concrete_message_window_by_name(node_name):
	self.get_message_window(node_name).redirect_me()


# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［アシスタント・ディレクター］　現在の段落名　　　：" + self.get_snapshot("VisualNovelDepartment").paragraph_name)
	print("［アシスタント・ディレクター］　選んだ選択肢行番号：" + str(row_number))

	# 次の段落名
	var next_paragraph_name = $"../ScenarioWriter/VisualNovelDepartment".index[self.get_snapshot("VisualNovelDepartment").paragraph_name][row_number]
	print("［アシスタント・ディレクター］　次の段落名　　　　：" + next_paragraph_name)
	
	self.play_visual_novel(next_paragraph_name)


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


# ［ト書き］か、台詞か、によって処理を分けます
func parse_message(temp_text):
	
	# ［ト書き］かどうか判定
	var first_head_tail = split_head_line_or_tail(temp_text)
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
			# 背景切替
			if second_head.begins_with("bg:"):
				$"Bg".do_it(second_head)

			# ＢＧＭ再生／停止
			if second_head.begins_with("bgm:"):
				$"Bgm".do_it(second_head)
			
			# 選択肢かどうか判定
			elif second_head.begins_with("choice:"):
				$"Choice".do_it(second_head)
				
			# 次の段落へ飛ぶ
			elif second_head.begins_with("goto:"):
				$"Goto".do_it(second_head, self.play_visual_novel)

			# メッセージ出力先ウィンドウ変更
			elif second_head.begins_with("m-wnd:"):
				$"MWnd".do_it(second_head)

			# アプリケーション終了
			elif second_head.begins_with("quit:"):
				$"Quit".do_it(second_head)

			# シーンの表示／非表示
			elif second_head.begins_with("scene:"):
				$"Scene".do_it(second_head)
			
			# 効果音
			elif second_head.begins_with("se:"):
				$"Se".do_it(second_head)
			
			# ビューイング・ウィンドウの表示／非表示
			elif second_head.begins_with("v-wnd:"):
				$"VWnd".do_it(second_head)

			# さらに先頭行を取得
			second_head_tail = split_head_line_or_tail(second_tail)

		#	［ト書き］終わり
		return

	# 選択肢だ
	if $"Choice".choice_row_number_array != null:
		$"NormalTextChoice".do_it(temp_text)
		return

	# print("［メッセージ・ウィンドウ］　選択肢ではない")
	$"NormalText".do_it(temp_text)


func _ready():
	#	関数を渡す
	$"MWnd".before_initialize(self.redirect_concrete_message_window_by_name)
	$"NormalText".before_initialize(self.get_snapshot("VisualNovelDepartment").set_message_window_waiting_for_order)
	$"NormalTextChoice".before_initialize(
		$"Choice".get_choice_row_number_array,
		$"Choice".set_choice_row_number_array,
		self.get_snapshot("VisualNovelDepartment").set_message_window_waiting_for_order)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
		
	# ビジュアルノベル再生中
	if self.statemachine_of_director.is_playing_visual_novel():
		
		# メッセージウィンドウが指示待ちか？
		if self.get_snapshot("VisualNovelDepartment").is_message_window_waiting_for_order:
			
			# まだあるよ
			if 0 < self.scenario_array.size():
			
				# 次に表示するべきメッセージを取得
				var latest_message = self.scenario_array.pop_front()

				# TODO ここで、命令と、台詞に分解したい
				self.parse_message(latest_message)

			# もう無いよ
			else:
				if not self.get_current_message_window().statemachine_of_message_window.is_none():
					# メッセージ・ウィンドウを閉じる
					self.get_current_message_window().statemachine_of_message_window.all_pages_flushed()
