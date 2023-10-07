#	メッセージエンド・ブリンカー（Message End Blinker；メッセージ末尾で点滅するもの）
extends Label

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null

#	強制的に非表示にする
var is_hide_force = false

#	カーソルが点滅するための時間カウント
var is_first_displayed_immediately = false
var blinker_seconds = 0.0
var blinker_interval = 0.5


func reset():
	self.is_hide_force = false
	self.visible = false
	self.is_first_displayed_immediately = false


func set_hide_force(is_hide_force):
	# 強制的に表示にする
	self.is_hide_force = is_hide_force
	
	if is_hide_force:
		self.visible = false


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	#	点滅
	self.blinker_seconds += delta

	if self.blinker_interval <= self.blinker_seconds:
		if 0 < self.modulate.a:
			self.modulate.a = 0.0
		else:
			self.modulate.a = 1.0
			
		self.blinker_seconds -= self.blinker_interval

	
	# （選択肢など、メッセージ末尾のブリンカーが要らないなら）
	# 強制的に表示にするか？
	if self.is_hide_force:
		if self.visible:
			self.visible = false
		return
	
	# 完全表示中	
	if self.statemachine.is_completed():

		# 初回はすぐに表示
		if not self.is_first_displayed_immediately:
			self.visible = true
			self.modulate.a = 1.0
			self.blinker_seconds = 0.0
			self.is_first_displayed_immediately = true

		#	表示
		elif not self.visible:
			self.visible = true

	# それ以外
	else:
		# 非表示
		self.is_first_displayed_immediately = false
		self.visible = false
