extends Label

var count_of_typewriter = 0

var scenario_array = [
	"""お父ん、知ってたら教えてくれだぜ。
	エスフェン（SFEN）の　7g7f　って何だぜ？
	""",
	"""あー。７筋の７段目の駒を
	６段目に突くことだぜ。
	分かったら　もう寝ろ
	""",
	"""3c3d　って何だぜ？
	""",
	"""角換わりだろ。
	もう寝ろ
	""",
	"""お父ん、なんで唐揚げを食べているんだぜ？
	ダイエットはどうした？
	野菜を TABERO だぜ！
	"""
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
