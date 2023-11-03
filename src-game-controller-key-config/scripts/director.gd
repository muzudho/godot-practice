# ディレクター（Director）
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$"KeyConfigArtist".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if not ($"KeyConfigArtist".turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	var is_ok = false
	
	# 初回
	if $"KeyConfigArtist".current_step == 0:
		$"Musician/BGM/🎵キーコンフィグ".play()
		$"KeyConfigArtist".current_step += 1
		is_ok = true
		
	# （１）決定ボタン、メッセージ送りボタン
	elif $"KeyConfigArtist".current_step == 1:
		if $"KeyConfigArtist".turn_state == &"WaitForPrompt":
			# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視する
			if $"KeyConfigArtist".counter_of_wait < 1.0:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Prompt"
		
		elif $"KeyConfigArtist".turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン　を押してください"
			$"KeyConfigArtist".turn_state = &"WaitForInput"

		elif $"KeyConfigArtist".turn_state == &"WaitForInput":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Input"
			is_ok = true

		elif $"KeyConfigArtist".turn_state == &"InputOk":
			#													"１２３４５６７８９０１２３４５６７８９："
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン：　" + $"KeyConfigArtist".button_presentation_name
			$"KeyConfigArtist".key_config[&"VK_Ok"] = $"KeyConfigArtist".button_number
			$"KeyConfigArtist".current_step += 1
			$"KeyConfigArtist".turn_state = &"WaitForPrompt"
	
	# （２）キャンセルボタン、メニューボタン
	elif $"KeyConfigArtist".current_step == 2:
		if $"KeyConfigArtist".turn_state == &"WaitForPrompt":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Prompt"
		
		elif $"KeyConfigArtist".turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン　を押してください"
			$"KeyConfigArtist".turn_state = &"WaitForInput"

		elif $"KeyConfigArtist".turn_state == &"WaitForInput":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Input"
			is_ok = true
	
		elif $"KeyConfigArtist".turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if $"KeyConfigArtist".is_key_duplicated($"KeyConfigArtist".button_number):
				$"KeyConfigArtist".set_key_denied()
				$"KeyConfigArtist".turn_state = &"WaitForInput"
				is_ok = true

			else:
				$"KeyConfigArtist".set_key_ok()
				#														  "１２３４５６７８９０１２３４５６７８９："
				$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン：　" + $"KeyConfigArtist".button_presentation_name
				$"KeyConfigArtist".key_config[&"VK_Cancel"] = $"KeyConfigArtist".button_number
				$"KeyConfigArtist".current_step += 1
				$"KeyConfigArtist".turn_state = &"WaitForPrompt"
		
	# （３）メッセージ早送りボタン
	elif $"KeyConfigArtist".current_step == 3:
		if $"KeyConfigArtist".turn_state == &"WaitForPrompt":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Prompt"
		
		elif $"KeyConfigArtist".turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン　を押してください"
			$"KeyConfigArtist".turn_state = &"WaitForInput"

		elif $"KeyConfigArtist".turn_state == &"WaitForInput":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Input"
			is_ok = true

		elif $"KeyConfigArtist".turn_state == &"InputOk":

			# 既存のキーと被る場合、やり直しさせる
			if $"KeyConfigArtist".is_key_duplicated($"KeyConfigArtist".button_number):
				$"KeyConfigArtist".set_key_denied()
				$"KeyConfigArtist".turn_state = &"WaitForInput"
				is_ok = true
			
			else:
				$"KeyConfigArtist".set_key_ok()
				#																"１２３４５６７８９０１２３４５６７８９："
				$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン　　　　　：　" + $"KeyConfigArtist".button_presentation_name
				$"KeyConfigArtist".key_config[&"VK_FastForward"] = $"KeyConfigArtist".button_number
				$"KeyConfigArtist".current_step += 1
				$"KeyConfigArtist".turn_state = &"WaitForPrompt"
		
	elif $"KeyConfigArtist".current_step == 4:
		if $"KeyConfigArtist".turn_state == &"WaitForPrompt":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Prompt"
		
		elif $"KeyConfigArtist".turn_state == &"Prompt":
			$"TelopCoordinator/TextBlock".text = "完了"
			$"KeyConfigArtist".turn_state = &"WaitForInput"

		elif $"KeyConfigArtist".turn_state == &"WaitForInput":
			if $"KeyConfigArtist".counter_of_wait < 0.5:
				$"KeyConfigArtist".counter_of_wait += delta
				return
			$"KeyConfigArtist".turn_state = &"Input"
			is_ok = true
	
	else:
		pass
	
	if is_ok:
		$"KeyConfigArtist".counter_of_wait = 0.0
		$"KeyConfigArtist".button_number = -1
		$"KeyConfigArtist".button_presentation_name = &""


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
