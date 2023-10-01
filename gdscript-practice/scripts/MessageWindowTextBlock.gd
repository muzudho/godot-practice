# テキスト・エリア（TextArea）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false
var count_of_typewriter = 0
var scenario_array = []
var text_buffer = ""


# シナリオ・データ設定
func set_scenario_array(scenario_array):
	print("［テキストエリア］　シナリオ・データを受け取った")
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
	
	print("［テキストエリア］　台詞はまだあるよ")
	# print("［テキストエリア］　台詞はまだあるよ。テキスト：　[" + temp_text + "]")

	
	# 選択肢かどうか判定
	if temp_text.begins_with("!choice "):
		print("［テキストエリア］　選択肢だ")
		
		# じゃあ、先頭行は省きたい
		var index = temp_text.find("\n")
		print(index)
		var head = temp_text.substr(0, index)
		var tail = temp_text.substr(index+1, temp_text.length() - (index+1))
		print("［テキストエリア］　head：　[" + head + "]")
		print("［テキストエリア］　tail：　[" + tail + "]")

		# head
		var csv = head.substr(8, head.length()-8)
		var row_numbers = csv.split(",", true, 0)
		print("［テキストエリア］　行番号")
		for row_number in row_numbers:
			print(row_number)
		
		# tail
		temp_text = tail
	else:
		print("［テキストエリア］　選択肢ではない")
	
	self.text_buffer = temp_text


# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	visible = false
	
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
	
		if 0.05 <= count_of_typewriter:
			if 0 < self.text_buffer.length():
				# １文字追加
				self.text += self.text_buffer.substr(0, 1)
				self.text_buffer = self.text_buffer.substr(1, self.text_buffer.length()-1)
			else:
				# 完全表示中
				self.statemachine.all_character_pushed()
			
			count_of_typewriter -= 0.05

func _unhandled_key_input(event):
	
	# 完全表示中
	if self.statemachine.is_completed():
		# 何かキーを押したとき
		if event.is_pressed():
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
				print("［テキストエリア］　台詞は終わった")
				self.visible = false
				is_visible_initialized = false
				self.statemachine.all_page_flushed()
					
