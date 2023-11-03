# ディレクター（Director）
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"KeyConfigArtist".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$"KeyConfigArtist".on_process(delta)


func _unhandled_input(event):

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if $"KeyConfigArtist".turn_state != &"Input":
		return

	var is_ok = false
	var acception = "受付：　"

	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	if not is_ok:
		var matched = $"KeyConfigArtist".re_button.search(event_as_text)
		if matched:
			$"KeyConfigArtist".button_number = int(matched.get_string(1))
			$"KeyConfigArtist".button_presentation_name = "ボタン" + str($"KeyConfigArtist".button_number)
			is_ok = true

	if not is_ok:
		var matched = $"KeyConfigArtist".re_lever.search(event_as_text)
		if matched:
			var number = int(matched.get_string(1))
			$"KeyConfigArtist".button_presentation_name = "レバー" + str(number)
			$"KeyConfigArtist".button_number = number + 1000
			is_ok = true

	if is_ok:
		print(acception)
		$"KeyConfigArtist".turn_state = &"InputOk"
		$"Musician/SE/🔔キーコンフィグ決定音".play()
		print("入力完了")
