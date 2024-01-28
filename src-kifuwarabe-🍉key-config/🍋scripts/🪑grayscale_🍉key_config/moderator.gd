# モデレーター（Moderator；司会進行）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0

# キーコンフィグのキーの数に対応
var key_config_item_number = 0

# `.entry()` を呼び出すと真にする。キー・コンフィグが完了するとまた偽にセットする
var is_enabled = false


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動前設定
# ーーーーーーーー

# キーコンフィグ画面に入る
func entry():
	
	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	
	# イラストレーター表示
	self.monkey().the_illustrator_node().show()
	
	# テロップ表示
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").visible = true


	# ーーーーーーーー
	# 設定
	# ーーーーーーーー
	#
	# GUI - メッセージ・ウィンドウ
	self.monkey().the_programmer_node().images.find_node("■上_大").show()
	self.monkey().the_programmer_node().images.find_node("■下").show()
	#
	# テロップ
	self.set_empty_the_button_message(1)
	self.set_empty_the_button_message(2)
	self.set_empty_the_button_message(3)
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = """\
	＊　＊　＊
	"""
	
	self.is_enabled = true


# ーーーーーーーー
# その他
# ーーーーーーーー


# ボタンが重複するか？
func is_key_duplicated(button_number_1):
	return button_number_1 in self.monkey().owner_key_config_node().key_config.values()


# キャンセルボタン押下か？
func is_cancel_button_pressed(button_number_1):
	if not (&"VK_Cancel" in self.monkey().owner_key_config_node().key_config):
		return false
	
	return button_number_1 == self.monkey().owner_key_config_node().key_config[&"VK_Cancel"]


# キーコンフィグ終了時
func on_exit():
	self.is_enabled = false
	# GUI - メッセージ・ウィンドウ
	self.monkey().the_programmer_node().images.find_node("■上_大").hide()
	self.monkey().the_programmer_node().images.find_node("■下").hide()
	# テロップ非表示
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = ""
	self.monkey().owner_key_config_node().get_my_telop_canvas_layer().hide()

	# BGM 停止	
	self.monkey().the_programmer_node().bg_musics.find_node("🎵キーコンフィグ").stop()

	# ディレクターのイベントハンドラ呼出し
	self.monkey().owner_key_config_node().on_exit()


func set_key_ok():
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "＊　＊　＊"


# キーコンフィグ　ボタン設定を受入
func set_key_accepted():
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ受入音").play()


# キーコンフィグ　ボタン設定が拒否
func set_key_denied(reason):
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ不可音").play()

	if reason == 1:
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "他の操作と被ってはいけません。\n他のキーを選んでください"

	if reason == 2:
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "下キーがボタンのときは、\n上キーもボタンを選んでください"

	if reason == 3:
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "右キーがボタンのときは、\n左キーもボタンを選んでください"


# キーコンフィグ　ボタン設定が拒否
func set_key_canceled():
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ取消音").play()
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = ""


func set_empty_the_button_message(step):
	if step == 1:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（１）ボタン").text = "（１）"

	elif step == 2:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（２）ボタン").text = "（２）"

	elif step == 3:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（３）ボタン").text = "（３）"

	elif step == 4:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（４）ボタン").text = "（４）"

	elif step == 5:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（５）ボタン").text = "（５）"

	elif step == 6:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（６）ボタン").text = "（６）"

	elif step == 7:
		#						"１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（７）ボタン").text = "（７）"


func set_press_message_to_button(step):
	if step == 1:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（１）ボタン").text = "（１）キャンセルボタン、メニューボタン　を押してください"

	elif step == 2:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（２）ボタン").text = "（２）決定ボタン、メッセージ送りボタン　を押してください"

	elif step == 3:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（３）ボタン").text = "（３）メッセージ早送りボタン　を押してください"

	elif step == 4:
		# ボタンと、レバーでは、対応が異なる
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（４）ボタン").text = "（４）下キー　を入れてください"

	elif step == 5:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（５）ボタン").text = "（５）上キー　を入れてください"
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "下キーと組み合わせられないボタンは\n使えません"

	elif step == 6:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（６）ボタン").text = "（６）右キー　を入れてください"

	elif step == 7:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（７）ボタン").text = "（７）左キー　を入れてください"
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "右キーと組み合わせられないボタンは\n使えません"

	# 完了時
	elif step == 8:
		#											"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("TextBlock").text = "完了"
		self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ完了音").play()


func set_done_message_the_button(step):
	if step == 1:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().owner_key_config_node().get_my_telop("（１）ボタン").text = "（１）キャンセルボタン、メニューボタン　　　：　" + self.button_presentation_name

	elif step == 2:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（２）ボタン").text = "（２）決定ボタン、メッセージ送りボタン　　　：　" + self.button_presentation_name

	elif step == 3:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（３）ボタン").text = "（３）メッセージ早送りボタン　　　　　　　　：　" + self.button_presentation_name

	elif step == 4:
		# ボタンと、レバーでは、対応が異なる
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（４）ボタン").text = "（４）下キー　　　　　　　　　　　　　　　　：　" + self.button_presentation_name

	elif step == 5:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（５）ボタン").text = "（５）上キー　　　　　　　　　　　　　　　　：　" + self.button_presentation_name

	elif step == 6:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（６）ボタン").text = "（６）右キー　　　　　　　　　　　　　　　　：　" + self.button_presentation_name

	elif step == 7:
		#											 "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().owner_key_config_node().get_my_telop("（７）ボタン").text = "（７）左キー　　　　　　　　　　　　　　　　：　" + self.button_presentation_name


func clear_count():
	self.counter_of_wait = 0.0
	self.button_number = -1
	self.button_presentation_name = &""
	

func on_step_regular(
		delta,
		previous_virtual_key_name,
		virtual_key_name):
	
	# 起動直後に　レバーが入った状態で始まることがあるから、最初は、入力を数フレーム無視するウェイトから始めること
	if self.monkey().statemachine().state == &"WaitForPrompt":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return
			
		self.monkey().statemachine().state = &"Prompt"
		return

	elif self.monkey().statemachine().state == &"Prompt":
		self.set_press_message_to_button(self.key_config_item_number)
		self.monkey().statemachine().state = &"WaitForInput"
		return
		
	elif self.monkey().statemachine().state == &"WaitForInput":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return

		# 最終ステップ＋１の時、完了
		if self.key_config_item_number == 8:
			# 完了メッセージを見せるために、効果音とも併せて、少し長めに
			if self.counter_of_wait < 1.5:
				self.counter_of_wait += delta
				return
			
			self.monkey().statemachine().state = &"Input"
			self.clear_count()
			self.on_exit()
			return

		self.monkey().statemachine().state = &"Input"
		self.clear_count()
		return

	elif self.monkey().statemachine().state == &"InputOk":
		# キャンセルボタン押下時は、１つか、２つ戻す
		if self.is_cancel_button_pressed(self.button_number):
			self.set_key_canceled()
			
			self.monkey().statemachine().state = &"WaitForInput"
			self.set_empty_the_button_message(self.key_config_item_number)
			
			self.key_config_item_number -= 1
			# さらに連続して戻したいケースもある
			# レバーの上
			if self.key_config_item_number == 5 and self.monkey().owner_key_config_node().key_config[&"VK_Down"] == self.monkey().owner_key_config_node().key_config[&"VK_Up"]:
				self.set_empty_the_button_message(self.key_config_item_number)
				self.key_config_item_number -= 1
				self.monkey().owner_key_config_node().key_config.erase(&"VK_Down")
			# レバーの左
			elif self.key_config_item_number == 7 and self.monkey().owner_key_config_node().key_config[&"VK_Right"] == self.monkey().owner_key_config_node().key_config[&"VK_Left"]:
				self.set_empty_the_button_message(self.key_config_item_number)
				self.key_config_item_number -= 1
				self.monkey().owner_key_config_node().key_config.erase(&"VK_Right")
			
			self.set_press_message_to_button(self.key_config_item_number)
			
			if previous_virtual_key_name != null:
				self.monkey().owner_key_config_node().key_config.erase(previous_virtual_key_name)
			
			self.clear_count()
			return

		# 既存のキーと被る場合、やり直しさせる
		if self.is_key_duplicated(self.button_number):
			self.set_key_denied(1)
			self.monkey().statemachine().state = &"WaitForInput"
			self.clear_count()
			return
			
		# 決定
		self.set_key_accepted()
		self.set_done_message_the_button(self.key_config_item_number)
		self.monkey().owner_key_config_node().key_config[virtual_key_name] = self.button_number

		# レバーの下
		if self.key_config_item_number == 4:
			if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Down"]:
				# 軸を選択したなら、レバーの上の選択はスキップ
				self.monkey().owner_key_config_node().key_config[&"VK_Up"] = self.button_number
				self.set_done_message_the_button(self.key_config_item_number + 1)
				self.key_config_item_number += 2
			else:
				self.key_config_item_number += 1
		# レバーの右
		elif self.key_config_item_number == 6:
			if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Right"]:
				# 軸を選択したなら、レバーの左の選択はスキップ
				self.monkey().owner_key_config_node().key_config[&"VK_Left"] = self.button_number
				self.set_done_message_the_button(self.key_config_item_number + 1)
				self.key_config_item_number += 2
			else:
				self.key_config_item_number += 1
		else:
			self.key_config_item_number += 1
		
		
		self.monkey().statemachine().state = &"WaitForPrompt"


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_number(button_number_1):
	if button_number_1 < 0:
		return &""
		
	if button_number_1 < 1000:
		return "ボタン" + str(button_number_1)

	return "レバー" + str(button_number_1 - 1000)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number_1):
	for key in self.monkey().owner_key_config_node().key_config.keys():
		var value = self.monkey().owner_key_config_node().key_config[key]
		if button_number_1 == value:
			return key
	return &""


func on_unhandled_input(event):

	if not self.is_enabled:
		return

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if self.monkey().statemachine().state != &"Input":
		return


	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	var temp_button_number = self.monkey().parser_for_input().get_button_number_by_text(event_as_text)

	# ーーーーーーーー
	# （５）上キー
	# ーーーーーーーー
	if self.key_config_item_number == 5:
		# 下キーがボタンのときは、上キーはレバーであってはいけません
		if 1000 < temp_button_number:
			self.set_key_denied(2)
			self.monkey().statemachine().state = &"WaitForInput"
			return

	# ーーーーーーーー
	# （７）左キー
	# ーーーーーーーー
	elif self.key_config_item_number == 7:
		# 右キーがボタンのときは、左キーはレバーであってはいけません
		if 1000 < temp_button_number:
			self.set_key_denied(3)
			self.monkey().statemachine().state = &"WaitForInput"
			return


	# 有効なキーなら
	if 0 <= temp_button_number:
		self.button_number = temp_button_number
		self.button_presentation_name = self.get_button_name_by_number(self.button_number)
		
		print("受付：　" + self.button_presentation_name)
		self.monkey().statemachine().state = &"InputOk"
