# シナリオプレイヤー（Scenario Player；台本再生機）
extends Node

# 状態遷移機械
var statemachine = load("scripts/ScenarioPlayerStatemachine.gd").new()


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
