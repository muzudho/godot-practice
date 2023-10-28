extends Node2D


# PC-Engine
func get_pc_engine():
	return $"GuiArtist/PCEngine_CanvasLayer"


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
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	var description = "判定：　"
	# 初期状態は、ボタンを離しているということにする
	var presentation = "."

	# ボタンの状態（何もしていないときはこの関数自体が呼び出されない）

	if event.is_pressed():
		description += "pressed "
		presentation = "■"
	
	if event.is_released():
		description += "released "
		presentation = "."

	# 操作したボタン
	var button_number = -1

	if event_as_text == &"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
		description += "Joypad Button 0"
		button_number = 0
		
	elif event_as_text == &"Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)":
		description += "Joypad Button 1"
		button_number = 1

	elif event_as_text == &"Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)":
		description += "Joypad Button 4"
		button_number = 4

	elif event_as_text == &"Joypad Button 6 (Start, Xbox Menu, Nintendo +)":
		description += "Joypad Button 6"
		button_number = 6
	
	print(description)

	# "Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)"
	if button_number == 0:
		self.get_pc_engine().get_node("I値").text = presentation
			
	# "Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)"
	elif button_number == 1:
		self.get_pc_engine().get_node("II値").text = presentation

	# "Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)"
	elif button_number == 4:
		self.get_pc_engine().get_node("Select値").text = presentation
				
	# "Joypad Button 6 (Start, Xbox Menu, Nintendo +)"
	elif button_number == 6:
		self.get_pc_engine().get_node("Run値").text = presentation


	var is_lever = false

	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			print("action: " + action)
			
			# 十字キーを想定
			if action == &"ui_left" or action == &"ui_right" or action == &"ui_up" or action == &"ui_down":
				is_lever = true

#			if action == &"JOY_AXIS_INVALID":
#				print("JOY_AXIS_INVALID")
#			elif action == &"JOY_AXIS_LEFT_X":
#				print("JOY_AXIS_LEFT_X")
#			elif action == &"JOY_AXIS_LEFT_Y":
#				print("JOY_AXIS_LEFT_Y")
#			elif action == &"JOY_AXIS_MAX":
#				print("JOY_AXIS_MAX")
#			elif action == &"JOY_AXIS_RIGHT_X":
#				print("JOY_AXIS_RIGHT_X")
#			elif action == &"JOY_AXIS_RIGHT_Y":
#				print("JOY_AXIS_RIGHT_Y")
#			elif action == &"JOY_AXIS_SDL_MAX":
#				print("JOY_AXIS_SDL_MAX")
#			elif action == &"JOY_AXIS_TRIGGER_LEFT":
#				print("JOY_AXIS_TRIGGER_LEFT")
#			elif action == &"JOY_AXIS_TRIGGER_RIGHT":
#				print("JOY_AXIS_TRIGGER_RIGHT")
#			elif action == &"JOY_BUTTON_A":
#				print("JOY_BUTTON_A")
#			elif action == &"JOY_BUTTON_B":
#				print("JOY_BUTTON_B")
#			elif action == &"JOY_BUTTON_BACK":
#				print("JOY_BUTTON_BACK")
#			elif action == &"JOY_BUTTON_DPAD_DOWN":
#				print("JOY_BUTTON_DPAD_DOWN")
#			elif action == &"JOY_BUTTON_DPAD_LEFT":
#				print("JOY_BUTTON_DPAD_LEFT")
#			elif action == &"JOY_BUTTON_DPAD_RIGHT":
#				print("JOY_BUTTON_DPAD_RIGHT")
#			elif action == &"JOY_BUTTON_DPAD_UP":
#				print("JOY_BUTTON_DPAD_UP")
#			elif action == &"JOY_BUTTON_GUIDE":
#				print("JOY_BUTTON_GUIDE")
#			elif action == &"JOY_BUTTON_INVALID":
#				print("JOY_BUTTON_INVALID")
#			elif action == &"JOY_BUTTON_LEFT_SHOULDER":
#				print("JOY_BUTTON_LEFT_SHOULDER")
#			elif action == &"JOY_BUTTON_LEFT_STICK":
#				print("JOY_BUTTON_LEFT_STICK")
#			elif action == &"JOY_BUTTON_MAX":
#				print("JOY_BUTTON_MAX")
#			elif action == &"JOY_BUTTON_MISC1":
#				print("JOY_BUTTON_MISC1")
#			elif action == &"JOY_BUTTON_PADDLE1":
#				print("JOY_BUTTON_PADDLE1")
#			elif action == &"JOY_BUTTON_PADDLE2":
#				print("JOY_BUTTON_PADDLE2")
#			elif action == &"JOY_BUTTON_PADDLE3":
#				print("JOY_BUTTON_PADDLE3")
#			elif action == &"JOY_BUTTON_PADDLE4":
#				print("JOY_BUTTON_PADDLE4")
#			elif action == &"JOY_BUTTON_RIGHT_SHOULDER":
#				print("JOY_BUTTON_RIGHT_SHOULDER")
#			elif action == &"JOY_BUTTON_RIGHT_STICK":
#				print("JOY_BUTTON_RIGHT_STICK")
#			elif action == &"JOY_BUTTON_SDL_MAX":
#				print("JOY_BUTTON_SDL_MAX")
#			elif action == &"JOY_BUTTON_START":
#				print("JOY_BUTTON_START")
#			elif action == &"JOY_BUTTON_TOUCHPAD":
#				print("JOY_BUTTON_TOUCHPAD")
#			elif action == &"JOY_BUTTON_X":
#				print("JOY_BUTTON_X")
#			elif action == &"JOY_BUTTON_Y":
#				print("JOY_BUTTON_Y")
				
			# 以上
				
	if is_lever:
		var velocity = Input.get_vector(
				&"ui_left",		# 左の方
				&"ui_right",	# 右の方
				&"ui_up",		# 上の方
				&"ui_down")		# 下の方
		
		self.get_pc_engine().get_node("→値").text = str(velocity.x)
		self.get_pc_engine().get_node("↓値").text = str(velocity.y)
		
		
