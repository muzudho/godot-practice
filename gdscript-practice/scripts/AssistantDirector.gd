# アシスタント・ディレクター（Assistant Director；助監督）
extends Node

# 状態遷移機械
var statemachine = load("scripts/AssistantDirectorStatemachine.gd").new()

# メッセージウィンドウが指示待ちか？
var is_message_window_waiting_for_order = false

# 現在実行中の段落番号
var current_paragraph_code = null

var scenario_array = []


# 台本の再生の開始の合図
func play_paragraph(paragraph_code):
	self.current_paragraph_code = paragraph_code
	
	# シナリオ・ブックから、内容を取出す
	print("［アシスタント・ディレクター］　シナリオ・ブックから、内容を取出す")
	self.scenario_array = $"../ScenarioBook".document[self.current_paragraph_code]

	# 再生中へ
	self.statemachine.play()


# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［アシスタント・ディレクター］　現在の段落名　　　：" + self.current_paragraph_code)
	print("［アシスタント・ディレクター］　選んだ選択肢行番号：" + str(row_number))

	# 次の段落名
	var next_paragraph_name = $"../ScenarioBook".index[self.current_paragraph_code][row_number]
	print("［アシスタント・ディレクター］　次の段落名　　　　：" + next_paragraph_name)
	
	self.play_paragraph(next_paragraph_name)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self.statemachine.is_none():
		# 停止中
		# 	何もしない
		pass
		
	elif self.statemachine.is_playing():
		# 再生中
		
		# メッセージウィンドウが指示待ちか？
		if is_message_window_waiting_for_order:
			print("［アシスタント・ディレクター］　メッセージ・フォワードをする")
			
			if 0 < self.scenario_array.size():
				# まだあるよ
			
				# 次に表示するべきメッセージを取得
				var latest_message = self.scenario_array.pop_front()

				# メッセージを追加
				$"../MessageWindow".push_message(latest_message)

				# タイプライター風表示へ状態遷移
				$"../MessageWindow".statemachine.scenario_seted()
				
				self.is_message_window_waiting_for_order = false

			else:
				pass

		else:
			#	何もしない
			pass
