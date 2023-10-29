# メガドライブ入力
extends Node


var re_axis_0 = RegEx.new()
var re_axis_1 = RegEx.new()
var re_axis_4 = RegEx.new()


# ［メガドライブ］
func _ready():
	# この文字列がどう変化するのか、さっぱり分からん。Godot はクソだ
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	re_axis_0.compile("Joypad Motion on Axis 0 \\(Left Stick X-Axis, Joystick 0 X-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")
	
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	re_axis_1.compile("Joypad Motion on Axis 1 \\(Left Stick Y-Axis, Joystick 0 Y-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")

	# Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 0.00
	re_axis_4.compile("Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value (-?\\d+(?:\\.\\d+)?)")


# ［メガドライブ］　キャンバスレイヤー取得
func get_canvas_layer():
	return $"../../GuiArtist/MegaDrive_CanvasLayer"


# ［メガドライブ］
func on_unhandled_input(event):
	
	if not self.get_canvas_layer().visible:
		return
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	var acception = "受付：　"
	# 初期状態は、ボタンを離しているということにする
	var presentation = "."

	# ーーーーーーーー
	# ボタンの状態（何もしていないときはこの関数自体が呼び出されない）
	# ーーーーーーーー
	if event.is_pressed():
		acception += "pressed "
		presentation = "■"
	
	if event.is_released():
		acception += "released "
		presentation = "."


	# ーーーーーーーー
	# ボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
	# ーーーーーーーー
	var button_number = -1
	var lever_value = 0

	# ［メガドライブ］　L
	# Joypad Button 9 (Left Shoulder, Sony L1, Xbox LB)
	if event_as_text.begins_with(&"Joypad Button 9 "):
		acception += &"Joypad Button 9 "
		button_number = 9

	# 各々、機種名もボタン名も書かないと、（Godot のUI では）間違えやすいので書いておく
	#
	# ［メガドライブ］　十字キーの左右
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	elif event_as_text.begins_with(&"Joypad Motion on Axis 0 "):
		acception += &"Joypad Motion on Axis 0 "
		button_number = 1000
		for result in re_axis_0.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception = ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# ［メガドライブ］　十字キーの上下
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 1 "):
		acception += &"Joypad Motion on Axis 1 "
		button_number = 1001
		for result in re_axis_1.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception = ", " + str(lever_value)
			presentation = str(lever_value)
			break
				
	# ［メガドライブ］　Start
	# Joypad Button 6 (Start, Xbox Menu, Nintendo +)
	elif event_as_text.begins_with(&"Joypad Button 6 "):
		acception += &"Joypad Button 6 "
		button_number = 6

	# ［メガドライブ］　R
	# Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 1.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 4 "):
		acception += &"Joypad Motion on Axis 4 "
		button_number = 1004
		for result in re_axis_4.search_all(event_as_text):
			lever_value = float(result.get_string(1))
			acception = ", " + str(lever_value)
			presentation = str(lever_value)
			break

	# ［メガドライブ］　A
	# Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
	elif event_as_text.begins_with(&"Joypad Button 0 "):
		acception += &"Joypad Button 0 "
		button_number = 0

	# ［メガドライブ］　B
	# Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
	elif event_as_text.begins_with(&"Joypad Button 1 "):
		acception += &"Joypad Button 1 "
		button_number = 1

	# ［メガドライブ］　C
	#
	# Examples
	# ========
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 1.00
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 5 "):
		acception += &"Joypad Motion on Axis 5 "
		button_number = 5

	# ［メガドライブ］　X
	# Joypad Button 2 (Left Action, Sony Square, Xbox X, Nintendo Y)
	elif event_as_text.begins_with(&"Joypad Button 2 "):
		acception += &"Joypad Button 2 "
		button_number = 2

	# ［メガドライブ］　Y
	# Joypad Button 3 (Top Action, Sony Triangle, Xbox Y, Nintendo X)
	elif event_as_text.begins_with(&"Joypad Button 3 "):
		acception += &"Joypad Button 3 "
		button_number = 3

	# ［メガドライブ］　Z
	# Joypad Button 10 (Right Shoulder, Sony R1, Xbox RB)
	elif event_as_text.begins_with(&"Joypad Button 10 "):
		acception += &"Joypad Button 10 "
		button_number = 10
	
	print(acception)


	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# 各々、機種名もボタン名も書かないと、（Godot のUI では）間違えやすいので書いておく
	#
	# ［メガドライブ］　L
	if button_number == 9:
		self.get_canvas_layer().get_node("L値").text = presentation
		
	# ［メガドライブ］　→
	elif button_number == 1000:
		self.get_canvas_layer().get_node("→値").text = presentation

	# ［メガドライブ］　↓
	elif button_number == 1001:
		self.get_canvas_layer().get_node("↓値").text = presentation
				
	# ［メガドライブ］　Start
	elif button_number == 6:
		self.get_canvas_layer().get_node("Start値").text = presentation
		
	# ［メガドライブ］　R
	elif button_number == 1004:
		self.get_canvas_layer().get_node("R値").text = presentation

	# ［メガドライブ］　A	
	elif button_number == 0:
		self.get_canvas_layer().get_node("A値").text = presentation

	# ［メガドライブ］　B
	elif button_number == 1:
		self.get_canvas_layer().get_node("B値").text = presentation
			
	# ［メガドライブ］　X
	elif button_number == 2:
		self.get_canvas_layer().get_node("X値").text = presentation
			
	# ［メガドライブ］　Y
	elif button_number == 3:
		self.get_canvas_layer().get_node("Y値").text = presentation

	# ［メガドライブ］　C
	elif button_number == 5:
		self.get_canvas_layer().get_node("C値").text = presentation
				
	# ［メガドライブ］　Z
	elif button_number == 10:
		self.get_canvas_layer().get_node("Z値").text = presentation
