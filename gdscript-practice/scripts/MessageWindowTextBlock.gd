# テキスト・エリア（TextArea）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false
var count_of_typewriter = 0
var text_buffer = ""
# 選択肢モード
var is_choice_mode = false
var choice_row_numbers = []


# 窓をクリアーします
func initialize():
	print("［テキストブロック］　台詞は終わった")
	self.visible = false
	self.is_visible_initialized = false


# ブリンカーを消す
func clear_blinker():
	$"BlinkerTriangle".reset()
	$"BlinkerUnderscore".reset()


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
