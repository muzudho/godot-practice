# PC-Engine入力
extends Node


var re_axis_0 = RegEx.new()
var re_axis_1 = RegEx.new()


# ［ＰＣエンジン］
func _ready():
	# この文字列がどう変化するのか、さっぱり分からん。Godot はクソだ
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	re_axis_0.compile("Joypad Motion on Axis 0 \\(Left Stick X-Axis, Joystick 0 X-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")
	
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	re_axis_1.compile("Joypad Motion on Axis 1 \\(Left Stick Y-Axis, Joystick 0 Y-Axis\\) with Value (-?\\d+(?:\\.\\d+)?)")


# ［ＰＣエンジン］　キャンバス・レイヤー取得
func get_canvas_layer():
	return $"../../GuiArtist/PCEngine_CanvasLayer"


# ［ＰＣエンジン］
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
	# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
	# ーーーーーーーー
	var axis_value = 0
	var button_number = -1

	# 各々、機種名もボタン名も書かないと、（Godot のUI では）間違えやすいので書いておく
	#
	# ［ＰＣエンジン］　十字キーの左右
	# Joypad Motion on Axis 0 (Left Stick X-Axis, Joystick 0 X-Axis) with Value 0.99
	if event_as_text.begins_with(&"Joypad Motion on Axis 0 "):
		acception += &"Joypad Motion on Axis 0 "
		button_number = 1000
		for result in re_axis_0.search_all(event_as_text):
			axis_value = float(result.get_string(1))
			acception = ", " + str(axis_value)
			presentation = str(axis_value)
			break

	# ［ＰＣエンジン］　十字キーの上下
	# Joypad Motion on Axis 1 (Left Stick Y-Axis, Joystick 0 Y-Axis) with Value 1.00
	elif event_as_text.begins_with(&"Joypad Motion on Axis 1 "):
		acception += &"Joypad Motion on Axis 1 "
		button_number = 1001
		for result in re_axis_1.search_all(event_as_text):
			axis_value = float(result.get_string(1))
			acception = ", " + str(axis_value)
			presentation = str(axis_value)
			break

	# ［ＰＣエンジン］　I
	# Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)
	elif event_as_text.begins_with(&"Joypad Button 0 "):
		acception += &"Joypad Button 0 "
		button_number = 0
	
	# ［ＰＣエンジン］　II
	# Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
	elif event_as_text.begins_with(&"Joypad Button 1 "):
		acception += &"Joypad Button 1 "
		button_number = 1

	# ［ＰＣエンジン］　Select
	# Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)
	elif event_as_text.begins_with(&"Joypad Button 4 "):
		acception += &"Joypad Button 4 "
		button_number = 4

	# ［ＰＣエンジン］　Run
	# Joypad Button 6 (Start, Xbox Menu, Nintendo +)
	elif event_as_text.begins_with(&"Joypad Button 6 "):
		acception += &"Joypad Button 6 "
		button_number = 6
	
	print(acception)

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# ［ＰＣエンジン］　→
	if button_number == 1000:
		self.get_canvas_layer().get_node("→値").text = presentation

	# ［ＰＣエンジン］　↓
	elif button_number == 1001:
		self.get_canvas_layer().get_node("↓値").text = presentation

	# ［ＰＣエンジン］　I
	elif button_number == 0:
		self.get_canvas_layer().get_node("I値").text = presentation
			
	# ［ＰＣエンジン］　II
	elif button_number == 1:
		self.get_canvas_layer().get_node("II値").text = presentation

	# ［ＰＣエンジン］　Select
	elif button_number == 4:
		self.get_canvas_layer().get_node("Select値").text = presentation
				
	# ［ＰＣエンジン］　Run
	elif button_number == 6:
		self.get_canvas_layer().get_node("Run値").text = presentation
