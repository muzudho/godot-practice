# テキスト・エリア（TextArea）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false
var count_of_typewriter = 0
var scenario_array = []
var text_storage = ""


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
	
	print("［テキストエリア］　台詞はまだあるよ")
	var text = self.scenario_array.pop_front()
	
	print("［テキストエリア］　テキスト：　" + text)
	self.text_storage = text


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
			if 0 < self.text_storage.length():
				# １文字追加
				self.text += text_storage.substr(0, 1)
				text_storage = text_storage.substr(1, self.text_storage.length()-1)
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
					
