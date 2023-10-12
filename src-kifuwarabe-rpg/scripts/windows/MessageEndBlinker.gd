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
	#	透明にして非表示にしておく
	print("［メッセージエンド・ブリンカー］　初期化による透明化")
	self.modulate.a = 0.0	# 初期化による透明化
	self.hide()
	self.is_first_displayed_immediately = false


#	空欄化
#		初期化の一種ですが、ウィンドウを残しておくことが違います
func emptize():
	#	透明にして表示しておく
	print("［メッセージエンド・ブリンカー］　空欄化による透明化")
	self.modulate.a = 0.0	# 空欄化による透明化
	self.show()
	self.is_first_displayed_immediately = false


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	print("［メッセージエンド・ブリンカー］　プロセッシング：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード無し


#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［メッセージエンド・ブリンカー］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード無し


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
				print("［メッセージエンド・ブリンカー］　点滅による透明化")
				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.modulate.a = 0.0	# 点滅による透明化
			else:
				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.modulate.a = 1.0
				
			self.blinker_seconds -= self.blinker_interval

		
		# 完全表示中	
		if self.statemachine.is_completed():

			#	初回はすぐに不透明
			if not self.is_first_displayed_immediately:
				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.modulate.a = 1.0
				self.blinker_seconds = 0.0
				self.is_first_displayed_immediately = true

		# それ以外
		else:
			# 透明
			self.is_first_displayed_immediately = false

			if self.modulate.a != 0.0:
				print("［メッセージエンド・ブリンカー］　遷移状態による透明化")
				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.modulate.a = 0.0	# 透明化
