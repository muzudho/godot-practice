# エックスボックス
extends Node


var re_axis_0 = RegEx.new()
var re_axis_1 = RegEx.new()
var re_axis_2 = RegEx.new()
var re_axis_3 = RegEx.new()
var re_axis_4 = RegEx.new()
var re_axis_5 = RegEx.new()


func _ready():
	# この文字列がどう変化するのか、さっぱり分からん。Godot はクソだ
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	re_axis_0.compile("Joypad Motion on Axis 0 \\(Left Stick X-Axis, Joystick 0 X-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")
	
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	re_axis_1.compile("Joypad Motion on Axis 1 \\(Left Stick Y-Axis, Joystick 0 Y-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")

	# Joypad Motion on Axis 2 (Right Stick X-Axis, Joystick 1 X-Axis) with Value 0.00
	re_axis_2.compile("Joypad Motion on Axis 2 \\(Right Stick X-Axis, Joystick 1 X-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")

	# Joypad Motion on Axis 3 (Right Stick Y-Axis, Joystick 1 Y-Axis) with Value 1.00
	re_axis_3.compile("Joypad Motion on Axis 3 \\(Right Stick Y-Axis, Joystick 1 Y-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")

	# Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 0.00
	re_axis_4.compile("Joypad Motion on Axis 4 \\(Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT\\) with Value (-?\\d+(?:\\.\\d+)?)")
	
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	re_axis_5.compile("Joypad Motion on Axis 5 \\(Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT\\) with Value (-?\\d+(?:\\.\\d+)?)")


# PC-Engine
func get_canvas_layer():
	return $"../../GuiArtist/XBox_CanvasLayer"


func on_unhandled_input(event):
	
	if not self.get_canvas_layer().visible:
		return
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	var acception = "受付：　"
	# 初期状態は、ボタンを離しているということにする。レバーの場合もある
	var presentation = "."

	# ーーーーーーーー
	# ボタンの状態（何もしていないときはこの関数自体が呼び出されない）
	# ーーーーーーーー
	if event.is_pressed():
		acception += "pressed: "
		presentation = "■"
	
	elif event.is_released():
		acception += "released: "
		presentation = "."


	# ーーーーーーーー
	# 操作したボタン番号　（変数を増やしたくないのでレバーは＋１０００して入れる）
	# ーーーーーーーー
	var button_number = -1
	var lever_value = 0

	# LT
	# Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 0.00
	# Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 0.00
	if event_as_text.begins_with(&"Joypad Motion on Axis 4 "):
		acception += &"Joypad Motion on Axis 4 "
		button_number = 1004
		for result in re_axis_4.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# LB
	# Joypad Button 9 (Left Shoulder, Sony L1, Xbox LB)
	elif event_as_text.begins_with(&"Joypad Button 9 "):
		acception += &"Joypad Button 9 "
		button_number = 9

	# 左レ→
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 0 "):
		acception += &"Joypad Motion on Axis 0 "
		button_number = 1000
		for result in re_axis_0.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# 左レ↓
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 1 "):
		acception += &"Joypad Motion on Axis 1 "
		button_number = 1001
		for result in re_axis_1.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# 左十→
	# Joypad Button 14 (D-pad Right)
	elif event_as_text.begins_with(&"Joypad Button 14 "):
		acception += &"Joypad Button 14 "
		button_number = 14

	# 左十↓
	# Joypad Button 12 (D-pad Down)
	elif event_as_text.begins_with(&"Joypad Button 12 "):
		acception += &"Joypad Button 12 "
		button_number = 12

	# Back
	# Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)
	elif event_as_text.begins_with(&"Joypad Button 4 "):
		acception += &"Joypad Button 4 "
		button_number = 4

	# Start
	# Joypad Button 6 (Start, Xbox Menu, Nintendo +)
	elif event_as_text.begins_with(&"Joypad Button 6 "):
		acception += &"Joypad Button 6 "
		button_number = 6

	# 右レ→
	# Joypad Motion on Axis 2 (Right Stick X-Axis, Joystick 1 X-Axis) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 2 "):
		acception += &"Joypad Motion on Axis 2 "
		button_number = 1002
		for result in re_axis_2.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# 右レ↓
	# Joypad Motion on Axis 3 (Right Stick Y-Axis, Joystick 1 Y-Axis) with Value 1.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 3 "):
		acception += &"Joypad Motion on Axis 3 "
		button_number = 1003
		for result in re_axis_3.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# RT
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 5 "):
		acception += &"Joypad Motion on Axis 5 "
		button_number = 1005
		for result in re_axis_5.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception += ", " + str(lever_value)
			presentation = str(lever_value)
			break
	
	# RB
	# Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)
	elif event_as_text.begins_with(&"Joypad Button 10 "):
		acception += &"Joypad Button 10 "
		button_number = 10

	# X
	# Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)
	elif event_as_text.begins_with(&"Joypad Button 2 "):
		acception += &"Joypad Button 2 "
		button_number = 2
	
	# Y
	# Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)
	elif event_as_text.begins_with(&"Joypad Button 3 "):
		acception += &"Joypad Button 3 "
		button_number = 3
	
	# A
	# Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
	elif event_as_text.begins_with(&"Joypad Button 0 "):
		acception += &"Joypad Button 0 "
		button_number = 0
	
	# B
	# Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
	elif event_as_text.begins_with(&"Joypad Button 1 "):
		acception += &"Joypad Button 1 "
		button_number = 1

	print(acception)


	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	if button_number == 1004:
		self.get_canvas_layer().get_node("LT値").text = presentation

	elif button_number == 9:
		self.get_canvas_layer().get_node("LB値").text = presentation

	elif button_number == 1000:
		self.get_canvas_layer().get_node("左レ→値").text = presentation
			
	elif button_number == 1001:
		self.get_canvas_layer().get_node("左レ↓値").text = presentation
			
	elif button_number == 14:
		self.get_canvas_layer().get_node("左十→値").text = presentation
			
	elif button_number == 12:
		self.get_canvas_layer().get_node("左十↓値").text = presentation

	elif button_number == 4:
		self.get_canvas_layer().get_node("Back値").text = presentation
				
	elif button_number == 6:
		self.get_canvas_layer().get_node("Start値").text = presentation
				
	elif button_number == 1002:
		self.get_canvas_layer().get_node("右レ→値").text = presentation
		
	elif button_number == 1003:
		self.get_canvas_layer().get_node("右レ↓値").text = presentation
				
	elif button_number == 1005:
		self.get_canvas_layer().get_node("RT値").text = presentation
				
	elif button_number == 10:
		self.get_canvas_layer().get_node("RB値").text = presentation
				
	elif button_number == 2:
		self.get_canvas_layer().get_node("X値").text = presentation
				
	elif button_number == 3:
		self.get_canvas_layer().get_node("Y値").text = presentation
				
	elif button_number == 0:
		self.get_canvas_layer().get_node("A値").text = presentation
				
	elif button_number == 1:
		self.get_canvas_layer().get_node("B値").text = presentation
