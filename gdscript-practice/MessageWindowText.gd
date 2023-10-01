# ブリンカー（Blinker）
extends Label

# 状態遷移図
const States = preload("MessageWindowStatemachine.gd").States
# enum States {None, Typewriter, Completed}

# 状態
var state = States.None

var count_of_typewriter = 0
var scenario_array = []
var text_storage = ""


# シナリオ・データ設定
func set_scenario_array(scenario_array):
	print("［テキストエリア］　シナリオ・データを受け取った")
	self.scenario_array = scenario_array

	# タイプライター風表示へ状態遷移
	print("［テキストエリア］　タイプライター風表示へ状態遷移")
	self.state = States.Typewriter


# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初のテキスト
	self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if self.state == States.Typewriter:
		# タイプライター風表示中
		count_of_typewriter += delta
	
		if 0.05 <= count_of_typewriter:
			if 0 < self.text_storage.length():
				# １文字追加
				self.text += text_storage.substr(0, 1)
				text_storage = text_storage.substr(1, self.text_storage.length()-1)
			else:
				# 完全表示中
				print("［テキストエリア］　完全表示中へ状態遷移")
				self.state = States.Completed
			
			count_of_typewriter -= 0.05

func _unhandled_key_input(event):
	
	# 完全表示中
	if self.state == States.Completed:
		# 何かキーを押したとき
		if event.is_pressed():
			# ブリンカーを消す
			$"BlinkerTriangle".reset()
			$"BlinkerUnderscore".reset()
			
			if 0 < self.scenario_array.size():
				# まだあるよ
				# メッセージ送り
				self.text = ""
				
				print("［テキストエリア］　台詞はまだあるよ")
				var text = self.scenario_array.pop_front()
				
				print("［テキストエリア］　テキスト：　" + text)
				self.text_storage = text
				
				# タイプライター風表示へ状態遷移
				print("［テキストエリア］　タイプライター風表示へ状態遷移")
				self.state = States.Typewriter
				
			else:
				# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
				print("［テキストエリア］　台詞は終わった")
				$"..".visible = false
				self.state = States.None
					
