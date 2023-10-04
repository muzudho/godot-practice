# シナリオプレイヤー（Scenario Player；台本再生機）
extends Node

# 状態遷移機械
var statemachine = load("scripts/ScenarioPlayerStatemachine.gd").new()

# 現在実行中の段落番号
var current_paragraph_code = null


# 台本の再生の開始の合図
func play_paragraph(paragraph_code):
	self.current_paragraph_code = paragraph_code
	
	# シナリオ・ブックから、内容を取出す
	print("［シナリオプレイヤー］　シナリオ・ブックから、内容を取出す")
	var scenario_array = $"../ScenarioBook".get_paragraph(self.current_paragraph_code)
	
	# シナリオプレイヤーへ、内容を渡す
	print("［シナリオプレイヤー］　メッセージ・ウィンドウへ内容を渡す")
	$"../MessageWindow".set_scenario_array(scenario_array)


var document = {
	# 段落番号
	"1" : {
		# 選択肢の行番号と、移動先段落番号
		1 : "1.1",
		2 : "1.2",
	},
}

# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［シナリオプレイヤー］　選んだ選択肢行番号：" + str(row_number))
	self.play_paragraph(self.document[self.current_paragraph_code][row_number])


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.statemachine.is_none():
		# 停止中
		# 	何もしない
		pass
		
	elif self.statemachine.is_playing():
		# 再生中
		#	何もしない
		pass
