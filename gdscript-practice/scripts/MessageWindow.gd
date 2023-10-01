# メッセージ・ウィンドウ（Message Window）
extends Node

# 状態遷移図
var MessageWindowStatemachine = load("scripts/MessageWindowStatemachine.gd")
var statemachine = MessageWindowStatemachine.new()


# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　テキストエリアへ、内容を渡す")
	$"./TextBlock".set_scenario_array(scenario_array)


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
