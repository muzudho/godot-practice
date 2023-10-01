# メッセージ・ウィンドウ（Message Window）
extends Sprite2D

# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　テキストエリアへ、内容を渡す")
	$"./TextArea".set_scenario_array(scenario_array)
	
