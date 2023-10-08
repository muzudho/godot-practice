#	メッセージエンド・ブリンカー（Message End Blinker；メッセージ末尾で点滅するもの）
extends Label

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null

#	カーソルが点滅するための時間カウント
var is_first_displayed_immediately = false
var blinker_seconds = 0.0
var blinker_interval = 0.5


#	初期化
#		初期化の一種ですが、初期化より先に行います。
#		引数を渡すことが **初期化** との違いです
func before_initialize(parent_statemachine):
	#	親からステートマシンを受け取る
	self.statemachine = parent_statemachine


#	初期化
#		ウィンドウが消えている状態を想定しています。
#		引数を渡さずに呼び出せることが **初期化の前に** との違いです
func initialize():
	#	最初は非表示、透明
	self.modulate.a = 0.0
	self.hide()
	self.is_first_displayed_immediately = false


#	空欄化
#		初期化の一種ですが、ウィンドウを残しておくことが違います
func emptize():
	#	透明にして表示しておく
	self.modulate.a = 0.0
	self.show()
	self.is_first_displayed_immediately = false


# Called when the node enters the scene tree for the first time.
func _ready():
	self.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# 非表示のときは働かない
	if self.visible:

		#	点滅
		self.blinker_seconds += delta

		if self.blinker_interval <= self.blinker_seconds:
			if 0 < self.modulate.a:
				self.modulate.a = 0.0
			else:
				self.modulate.a = 1.0
				
			self.blinker_seconds -= self.blinker_interval

		
		# 完全表示中	
		if self.statemachine.is_completed():

			#	初回はすぐに不透明
			if not self.is_first_displayed_immediately:
				self.modulate.a = 1.0
				self.blinker_seconds = 0.0
				self.is_first_displayed_immediately = true

		# それ以外
		else:
			# 透明
			self.is_first_displayed_immediately = false
			self.modulate.a = 0.0
