extends Label

var count_of_typewriter = 0

var scenario_array = [
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	きふわらべ
	「お父ん、知ってたら教えてくれだぜ。
	　エスフェン(SFEN)の 7g7f って何だぜ？
	""",
	"""\
	お父ん
	「あー。７筋の７段目の駒を６段目に
	　突くことだぜ。分かったら　もう寝ろ
	""",
	"""\
	きふわらべ
	「3c3d　って何だぜ？
	""",
	"""\
	お父ん
	「角換わりだろ。
	　もう寝ろ
	""",
	"""\
	きふわらべ
	「お父ん、なんで唐揚げを食べてるんだぜ？
	　ダイエットはどうした？野菜食べろだぜ！
	""",
	"""\
	お父ん
	「元気になりたくて唐揚げを食べるんだぜ
	""",
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	カロリー計算をしようと思ったときもあった
	限界まで食べてしまうので止めた
	""",
]

var text_storage = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初のテキスト
	self.text = ""
	
	if self.text_storage == "" and 0 < self.scenario_array.size():
		self.text_storage = self.scenario_array.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# タイプライター風出力
	count_of_typewriter += delta
	
	if 0.05 <= count_of_typewriter:
		if 0 < self.text_storage.length():
			self.text += text_storage.substr(0, 1)
			text_storage = text_storage.substr(1, self.text_storage.length()-1)
		count_of_typewriter -= 0.05

func _unhandled_key_input(event):
	# 何かキーを押したとき
	if event.is_pressed():
		# ブリンカーを消す
		$"BlinkerTriangle".reset()
		$"BlinkerUnderscore".reset()
		
		# メッセージ送り
		if self.text_storage == "":
			self.text = ""
			
			if 0 < self.scenario_array.size():
				self.text_storage = self.scenario_array.pop_front()
			else:
				# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
				$"..".visible = false
		
