#	メッセージエンド・ブリンカー（Message End Blinker；メッセージ末尾で点滅するもの）
extends Label


# 状態機械
var statemachine_of_end_of_message_blinker = load("res://scripts/statemachines/end_of_message_blinker.gd").new()
var statemachine_of_blinker = load("res://scripts/statemachines/blinker.gd").new()


#	メッセージエンド・ブリンカーの共通項目
#
#		メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine_of_message_window = null
#		カーソルが点滅するための時間カウント
var blinker_seconds = 0.0
var blinker_interval = 0.5


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


#	初期化
#		ウィンドウが消えている状態を想定しています。
#		引数を渡さずに呼び出せることが **初期化の前に** との違いです
func on_decided():
	#	透明にして非表示にしておく
	print("［メッセージエンド・ブリンカー］　初期化による透明化")
	self.modulate.a = 0.0	# 初期化による透明化
	self.hide()

	#	ブリンカーのスイッチ・オフ
	self.statemachine_of_blinker.switch_off()

	
func on_thought():
	#	エンプタイズ（Emptize；空欄化）
	#
	#		初期化の一種ですが、ウィンドウを残しておくことが違います
	#		透明にして表示しておく
	print("［メッセージエンド・ブリンカー］　空欄化による透明化")
	self.modulate.a = 0.0	# 空欄化による透明化
	self.show()

	#	ブリンカーのスイッチ・オン
	self.statemachine_of_blinker.switch_on()


func on_sought():
	pass
	
	
func on_arrived():
	pass


#	初回点灯
func on_switched_on():
	self.modulate.a = 1.0
	self.blinker_seconds = 0.0


#	終回消灯
func on_switched_off():
	self.modulate.a = 0.0


#	時間経過による点灯
func on_turned_on():
	self.modulate.a = 1.0


#	時間経過による消灯
func on_turned_off():
	self.modulate.a = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	#	状態機械のセットアップ
	self.statemachine_of_end_of_message_blinker.on_decided = self.on_decided
	self.statemachine_of_end_of_message_blinker.on_thought = self.on_thought
	self.statemachine_of_end_of_message_blinker.on_sought = self.on_sought
	self.statemachine_of_end_of_message_blinker.on_arrived = self.on_arrived

	#	状態機械のセットアップ
	self.statemachine_of_blinker.on_switched_on = self.on_switched_on
	self.statemachine_of_blinker.on_switched_off = self.on_switched_off
	self.statemachine_of_blinker.on_turned_on = self.on_turned_on
	self.statemachine_of_blinker.on_turned_off = self.on_turned_off

	self.statemachine_of_end_of_message_blinker.decide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# 非表示のときは働かない
	if self.visible:

		#	点滅
		self.blinker_seconds += delta

		if self.blinker_interval <= self.blinker_seconds:
			if 0 < self.modulate.a:
				#	時間経過による消灯
				self.statemachine_of_blinker.turn_off()
			else:
				#	時間経過による点灯
				self.statemachine_of_blinker.turn_on()
				
			self.blinker_seconds -= self.blinker_interval
