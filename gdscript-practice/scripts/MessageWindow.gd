# メッセージ・ウィンドウ（Message Window）
extends Node

# 状態遷移機械
var statemachine = load("scripts/MessageWindowStatemachine.gd").new()


# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　テキストエリアへ、内容を渡す")
	$"./TextBlock".set_scenario_array(scenario_array)


# 下位ノードで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［メッセージ・ウィンドウ］　選んだ選択肢行番号：" + str(row_number))
	$"../ScenarioPlayer".on_choice_selected(row_number)


# サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# ステートマシーンを、子にも参照させる
	$"Background".statemachine = self.statemachine
	$"TextBlock".statemachine = self.statemachine
	$"TextBlock/BlinkerTriangle".statemachine = self.statemachine
	$"TextBlock/BlinkerUnderscore".statemachine = self.statemachine
	$"TextBlock/ChoiceCursor".statemachine = self.statemachine


func _process(delta):
	pass
