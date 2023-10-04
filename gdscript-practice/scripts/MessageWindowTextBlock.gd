# テキスト・エリア（TextArea）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false
var count_of_typewriter = 0
var scenario_array = []
var text_buffer = ""
# 選択肢モード
var is_choice_mode = false
var choice_row_numbers = []


# シナリオ・データ設定
func set_scenario_array(scenario_array):
	print("［テキストブロック］　シナリオ・データを受け取った")
	self.scenario_array = scenario_array

	# メッセージ送り
	self.forward_message()

	# タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()


# メッセージ送り
func forward_message():
	self.text = ""
	
	var temp_text = self.scenario_array.pop_front()

	# 先頭行の最初と、最終行の最後の表示されない文字を消去
	temp_text = temp_text.strip_edges()
	
	# print("［テキストブロック］　台詞はまだあるよ")
	print("［テキストブロック］　台詞はまだあるよ。テキスト：　[" + temp_text + "]")

	
	# 選択肢かどうか判定
	if temp_text.begins_with("!choice "):
		print("［テキストブロック］　選択肢だ")
		self.is_choice_mode = true
		
		# じゃあ、先頭行は省きたい
		var index = temp_text.find("\n")
		print(index)
		var head = temp_text.substr(0, index)
		var tail = temp_text.substr(index+1, temp_text.length() - (index+1))
		# print("［テキストブロック］　head：　[" + head + "]")
		# print("［テキストブロック］　tail：　[" + tail + "]")

		# head
		var csv = head.substr(8, head.length()-8)
		# TODO 昇順であること
		var string_packed_array = csv.split(",", true, 0)
		var size = string_packed_array.size()
		# print("［テキストブロック］　選択肢サイズ：" + str(size))
		
		# 文字列型を数値型に変換
		self.choice_row_numbers = []
		self.choice_row_numbers.resize(size)
		# print("［テキストブロック］　行番号一覧")
		for i in range(0, size):
			self.choice_row_numbers[i] = string_packed_array[i].to_int()
			# print(self.choice_row_numbers[i])
					
		# tail
		temp_text = tail
	else:
		# print("［テキストブロック］　選択肢ではない")
		self.is_choice_mode = false
		self.choice_row_numbers = []
	
	self.text_buffer = temp_text


# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	self.visible = false
	
	# 最初のテキスト
	self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.statemachine.is_typewriter():
		# タイプライター風表示中
		
		if not self.is_visible_initialized:
			# 初回に可視化
			self.visible = true
			self.is_visible_initialized = true
		
		count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 0.05
	
		# メッセージの早送り
		if Input.is_key_pressed(KEY_R):
			print("［テキストブロック］　メッセージの早送り")
			wait_time = 0.01
	
		if wait_time <= count_of_typewriter:
			if 0 < self.text_buffer.length():
				# １文字追加
				self.text += self.text_buffer.substr(0, 1)
				self.text_buffer = self.text_buffer.substr(1, self.text_buffer.length()-1)
			else:
				# 完全表示中
				self.statemachine.all_character_pushed()
			
			count_of_typewriter -= wait_time


func _unhandled_key_input(event):
	
	# 完全表示中
	if self.statemachine.is_completed():

		# 選択肢モードなら
		if self.is_choice_mode:
			
			# 何かキーを押したとき
			if event.is_pressed():
				#  and event is InputEventKey and event.pressed
				
				# 確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					print("［テキストブロック］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
					
				else:
					# 選択肢の行番号を、上位ノードへエスカレーションします
					$"..".on_choice_selected($"ChoiceCursor".selected_row_number)
					return
		
		# 非モードなら
		else:
		
			# 何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					print("［テキストブロック］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
					
				# ブリンカーを消す
				$"BlinkerTriangle".reset()
				$"BlinkerUnderscore".reset()
				
				if 0 < self.scenario_array.size():
					# まだあるよ
					
					# メッセージ送り
					self.forward_message()
					
					# タイプライター風表示へ状態遷移
					self.statemachine.page_forward()
					
				else:
					# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
					print("［テキストブロック］　台詞は終わった")
					self.visible = false
					self.is_visible_initialized = false
					self.statemachine.all_page_flushed()
					
