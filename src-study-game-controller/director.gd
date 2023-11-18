extends Node2D


# コントローラー・アーティスト取得
func get_controller_artist():
	return $"ControllerArtist"


# The line below is similar to `get_vector()`, except that it handles
# the deadzone in a less optimal way. The resulting deadzone will have
# a square-ish shape when it should ideally have a circular shape.
#var velocity_same = Vector2(
#		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
#		Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
#).limit_length(1.0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#	# `velocity` will be a Vector2 between `Vector2(-1.0, -1.0)` and `Vector2(1.0, 1.0)`.
#	# This handles deadzone in a correct way for most use cases.
#	# The resulting deadzone will have a circular shape as it generally should.
#	var velocity = Input.get_vector(
#			&"ui_left",		# 左の方
#			&"ui_right",	# 右の方
#			&"ui_up",		# 上の方
#			&"ui_down")		# 下の方
#
#	$"GuiArtist/CanvasLayer/→値".text = str(velocity.x)
#	$"GuiArtist/CanvasLayer/↓値".text = str(velocity.y)

# 入力１つ１つに分解されて呼び出されるようだ
func _unhandled_input(event):
	
	self.get_controller_artist().get_node("Test_Input").on_unhandled_input(event)
	self.get_controller_artist().get_node("MegaDrive_Input").on_unhandled_input(event)
	self.get_controller_artist().get_node("PCEngine_Input").on_unhandled_input(event)
	self.get_controller_artist().get_node("XBox_Input").on_unhandled_input(event)
	self.get_controller_artist().get_node("PlayStation_Input").on_unhandled_input(event)
