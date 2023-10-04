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
	print("［２Ｄプロジェクト］　シナリオ・ブックから、内容を取出す")
	var scenario_array = $"../ScenarioBook".get_paragraph(self.current_paragraph_code)
	
	# シナリオプレイヤーへ、内容を渡す
	print("［２Ｄプロジェクト］　シナリオプレイヤーへ、内容を渡す")
	$"../ScenarioPlayer".set_scenario_array(scenario_array)


# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　メッセージ・ウィンドウへ、内容を渡す")
	$"../MessageWindow".set_scenario_array(scenario_array)


# メッセージ・ウィンドウで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［シナリオプレイヤー］　選んだ選択肢行番号：" + str(row_number))

	if self.current_paragraph_code == "1":
		if row_number == 1:
			self.play_paragraph("1.1")

		elif row_number == 2:
			self.play_paragraph("1.2")



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
