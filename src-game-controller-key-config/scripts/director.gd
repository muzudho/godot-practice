# ディレクター（Director）
extends Node2D


var re_axis_5 = RegEx.new()

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_boot_ignore = 0.0
var is_input_waiting = false
var current_step = 1
# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""


# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん。Godot はクソだ
	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	re_axis_5.compile("Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value (-?\\d+(?:\\.\\d+)?)")


	$"TelopCoordinator/TextBlock".text = """\
	＊　＊　＊
	"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if counter_of_boot_ignore < 1.0:
		counter_of_boot_ignore += delta
		return
	
	if is_input_waiting:
		return
	
	var is_ok = false
	
	if self.current_step == 1:
		$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン　を押してください"
		is_ok = true
		
	elif self.current_step == 2:
		$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン：　" + self.button_presentation_name
		$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン　を押してください"
		is_ok = true
		
	elif self.current_step == 3:
		$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン：　" + self.button_presentation_name
		$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン　を押してください"
		is_ok = true

	elif self.current_step == 4:
		$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン：　" + self.button_presentation_name
		is_ok = true
	
	if is_ok:
		self.current_step += 1
		self.button_number = -1
		self.button_presentation_name = &""
		self.is_input_waiting = true


func _unhandled_input(event):

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)

	if counter_of_boot_ignore < 1.0:
		return
	
	if not is_input_waiting:
		return

	var is_ok = false
	var acception = "受付：　"

	# Joypad Motion on Axis 5 (Joystick 2 Y-Axis, Right Trigger, Sony R2, Xbox RT) with Value 0.00
	if event_as_text.begins_with(&"Joypad Motion on Axis 5 "):
		acception += &"Joypad Motion on Axis 5 "
		button_presentation_name = "レバー５"
		self.button_number = 1005
		is_ok = true
	
	# Joypad Button 1 (Right Action, Sony Circle, Xbox B, Nintendo A)
	if event_as_text.begins_with(&"Joypad Button 1 "):
		acception += &"Joypad Button 1 "
		self.button_presentation_name = "ボタン１"
		self.button_number = 1
		is_ok = true

	if is_ok:
		print(acception)
		self.is_input_waiting = false
