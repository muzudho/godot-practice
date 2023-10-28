extends Node


func on_unhandled_input(event):
	
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	#print("［テスト入力］　入力：" + event_as_text)


	# ーーーーーーーー
	# レバー
	# ーーーーーーーー
	var is_lever = false

	for action in InputMap.get_actions():
		if InputMap.event_is_action(event, action):
			print("action: " + action)
			
			# 十字キーを想定
			# この方法は、１つ目のコントローラーしか反応しない。
			# しかし x軸とy軸を両方押したときに 0.7071... のように出してくれるメリットがあった
			if action == &"ui_left" or action == &"ui_right" or action == &"ui_up" or action == &"ui_down":
				is_lever = true
				
	if is_lever:
		var velocity = Input.get_vector(
				&"ui_left",		# 左の方
				&"ui_right",	# 右の方
				&"ui_up",		# 上の方
				&"ui_down")		# 下の方

		print("［テスト入力］　１つ目のコントローラー　ｘ：" + str(velocity.x) + "　ｙ：" + str(velocity.y))
		#self.get_canvas_layer().get_node("→値").text = str(velocity.x)
		#self.get_canvas_layer().get_node("↓値").text = str(velocity.y)
