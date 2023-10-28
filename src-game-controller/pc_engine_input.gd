extends Node


# PC-Engine
func get_canvas_layer():
	return $"../../GuiArtist/PCEngine_CanvasLayer"


func on_unhandled_input(event):
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
		self.get_canvas_layer().get_node("I値").text = presentation
			
	# "Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)"
	elif button_number == 1:
		self.get_canvas_layer().get_node("II値").text = presentation

	# "Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)"
	elif button_number == 4:
		self.get_canvas_layer().get_node("Select値").text = presentation
				
	# "Joypad Button 6 (Start, Xbox Menu, Nintendo +)"
	elif button_number == 6:
		self.get_canvas_layer().get_node("Run値").text = presentation


	var is_lever = false

	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			print("action: " + action)
			
			# 十字キーを想定
			if action == &"ui_left" or action == &"ui_right" or action == &"ui_up" or action == &"ui_down":
				is_lever = true
				
	if is_lever:
		var velocity = Input.get_vector(
				&"ui_left",		# 左の方
				&"ui_right",	# 右の方
				&"ui_up",		# 上の方
				&"ui_down")		# 下の方
		
		self.get_canvas_layer().get_node("→値").text = str(velocity.x)
		self.get_canvas_layer().get_node("↓値").text = str(velocity.y)
		
		
