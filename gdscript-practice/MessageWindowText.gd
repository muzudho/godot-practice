extends Label

var count_of_typewriter = 0
var scenario_array = []
var text_storage = ""
var is_completed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初のテキスト
	self.text = ""
	
	#var scenario_array2 = self.scenario_array
	#
	#if self.text_storage == "" and 0 < scenario_array2.size():
	#	self.text_storage = scenario_array2.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# タイプライター風出力
	count_of_typewriter += delta
	
	if 0.05 <= count_of_typewriter:
		if 0 < self.text_storage.length():
			self.text += text_storage.substr(0, 1)
			text_storage = text_storage.substr(1, self.text_storage.length()-1)
		elif not self.is_completed:
			# 表示完了
			self.is_completed = true
			
		count_of_typewriter -= 0.05

func _unhandled_key_input(event):
	# 何かキーを押したとき
	if event.is_pressed():
		# ブリンカーを消す
		$"BlinkerTriangle".reset()
		$"BlinkerUnderscore".reset()
		
		# 表示完了時
		if self.is_completed:
			# メッセージ送り
			self.text = ""
			
			if 0 < self.scenario_array.size():
				self.text_storage = self.scenario_array.pop_front()
			else:
				# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
				$"..".visible = false
		
