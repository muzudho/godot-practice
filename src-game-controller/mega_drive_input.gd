extends Node


var re_axis_0 = RegEx.new()
var re_axis_1 = RegEx.new()


func _ready():
	# この文字列がどう変化するのか、さっぱり分からん。Godot はクソだ
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	re_axis_0.compile("Joypad Motion on Axis 0 \\(Left Stick X-Axis, Joystick 0 X-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")
	
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	re_axis_1.compile("Joypad Motion on Axis 1 \\(Left Stick Y-Axis, Joystick 0 Y-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")


# PC-Engine
func get_canvas_layer():
	return $"../../GuiArtist/MegaDrive_CanvasLayer"


func on_unhandled_input(event):
	
	if not self.get_canvas_layer().visible:
		return
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	var description = "判定：　"
	# 初期状態は、ボタンを離しているということにする
	var presentation = "."

	# ーーーーーーーー
	# ボタンの状態（何もしていないときはこの関数自体が呼び出されない）
	# ーーーーーーーー
	if event.is_pressed():
		description += "pressed "
		presentation = "■"
	
	if event.is_released():
		description += "released "
		presentation = "."


	# ーーーーーーーー
	# 操作したボタン
	# ーーーーーーーー
	var axis_number = -1
	var axis_value = 0
	var button_number = -1

	# 十字キーの左右
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	if event_as_text.begins_with(&"Joypad Motion on Axis 0 "):
		description += &"Joypad Motion on Axis 0 "
		axis_number = 0
		for result in re_axis_0.search_all(event_as_text):
			axis_value = float(result.get_string(1))
			break

	# 十字キーの上下
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 1 "):
		description += &"Joypad Motion on Axis 1 "
		axis_number = 1
		for result in re_axis_1.search_all(event_as_text):
			axis_value = float(result.get_string(1))
			break
			
	# A
	# Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
	elif event_as_text.begins_with(&"Joypad Button 0 "):
		description += &"Joypad Button 0 "
		button_number = 0

	# B
	# Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
	elif event_as_text.begins_with(&"Joypad Button 1 "):
		description += &"Joypad Button 1 "
		button_number = 1

	# C
	#
	# Examples
	# ========
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 1.00
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 5 "):
		description += &"Joypad Motion on Axis 5 "
		button_number = 5

	# X
	# Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)
	elif event_as_text.begins_with(&"Joypad Button 2 "):
		description += &"Joypad Button 2 "
		button_number = 2

	# Y
	# Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)
	elif event_as_text.begins_with(&"Joypad Button 3 "):
		description += &"Joypad Button 3 "
		button_number = 3

	# Z
	# Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)
	elif event_as_text.begins_with(&"Joypad Button 10 "):
		description += &"Joypad Button 10 "
		button_number = 10
	
	# Start
	# Joypad Button 6 (Start, Xbox Menu, Nintendo +)
	elif event_as_text.begins_with(&"Joypad Button 6 "):
		description += &"Joypad Button 6 "
		button_number = 6
	
	print(description)


	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	if axis_number == 0:
		self.get_canvas_layer().get_node("→値").text = str(axis_value)

	elif axis_number == 1:
		self.get_canvas_layer().get_node("↓値").text = str(axis_value)

	elif button_number == 0:
		self.get_canvas_layer().get_node("A値").text = presentation
			
	elif button_number == 1:
		self.get_canvas_layer().get_node("B値").text = presentation
			
	elif button_number == 2:
		self.get_canvas_layer().get_node("X値").text = presentation
			
	elif button_number == 3:
		self.get_canvas_layer().get_node("Y値").text = presentation

	elif button_number == 5:
		self.get_canvas_layer().get_node("C値").text = presentation
				
	elif button_number == 6:
		self.get_canvas_layer().get_node("Start値").text = presentation
				
	elif button_number == 10:
		self.get_canvas_layer().get_node("Z値").text = presentation
