# メッセージ・ウィンドウ（Message Window）
extends Node

# 状態遷移図
var MessageWindowStatemachine = load("scripts/MessageWindowStatemachine.gd")
var statemachine = MessageWindowStatemachine.new()


# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　テキストエリアへ、内容を渡す")
	$"./TextArea".set_scenario_array(scenario_array)


# サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# ステートマシーンを、子にも参照させる
	$"Background".statemachine = self.statemachine
	$"TextArea".statemachine = self.statemachine
	$"TextArea/BlinkerTriangle".statemachine = self.statemachine
	$"TextArea/BlinkerUnderscore".statemachine = self.statemachine


func _process(delta):
	pass
