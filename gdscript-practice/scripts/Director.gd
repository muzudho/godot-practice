# ディレクター（Director；監督）
#D 	とりあえず、ゲーム全体をコントロールする
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# シナリオ・ブックから、内容を取出す
	print("［２Ｄプロジェクト］　シナリオ・ブックから、内容を取出す")
	var scenario_array = $"./ScenarioBook".scenario_array
	
	# シナリオプレイヤーへ、内容を渡す
	print("［２Ｄプロジェクト］　シナリオプレイヤーへ、内容を渡す")
	$"./ScenarioPlayer".set_scenario_array(scenario_array)
