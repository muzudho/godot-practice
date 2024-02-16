# ディスプレイ（Display；画面）
#
#	画面の表示。演奏も含む
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー

# 画面上のオブジェクトの非表示
func ready_in_staff():
	# イラストレーター非表示
	self.monkey().the_illustrator_node().hide()
		
	# テロップ非表示
	self.monkey().get_my_telop("TextBlock").visible = false


# ーーーーーーーー
# その他
# ーーーーーーーー

# 入力がOkなときに表示されるメッセージ
func set_ok_message():
	self.monkey().get_my_telop("TextBlock").text = "＊　＊　＊"


# メッセージの消去
func clear_message():
	self.monkey().get_my_telop("TextBlock").text = ""


# キーコンフィグ　ボタン設定が拒否
func set_key_denied_message(reason):
	if reason == 1:
		self.monkey().get_my_telop("TextBlock").text = "他の操作と被ってはいけません。\n他のキーを選んでください"

	elif reason == 2:
		self.monkey().get_my_telop("TextBlock").text = "下キーがボタンのときは、\n上キーもボタンを選んでください"

	elif reason == 3:
		self.monkey().get_my_telop("TextBlock").text = "右キーがボタンのときは、\n左キーもボタンを選んでください"


# 各項目が空の状態のメッセージ
func set_empty_the_button_message(step):
	if step == 1:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（１）ボタン").text = "（１）"

	elif step == 2:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（２）ボタン").text = "（２）"

	elif step == 3:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（３）ボタン").text = "（３）"

	elif step == 4:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（４）ボタン").text = "（４）"

	elif step == 5:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（５）ボタン").text = "（５）"

	elif step == 6:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（６）ボタン").text = "（６）"

	elif step == 7:
		#						   "１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（７）ボタン").text = "（７）"


# ボタンの押下を促すメッセージ
func set_press_message_to_button(step):
	if step == 1:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（１）ボタン").text = "（１）キャンセルボタン、メニューボタン　を押してください"

	elif step == 2:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（２）ボタン").text = "（２）決定ボタン、メッセージ送りボタン　を押してください"

	elif step == 3:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（３）ボタン").text = "（３）メッセージ早送りボタン　を押してください"

	elif step == 4:
		# ボタンと、レバーでは、対応が異なる
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（４）ボタン").text = "（４）下キー　を入れてください"

	elif step == 5:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（５）ボタン").text = "（５）上キー　を入れてください"
		self.monkey().get_my_telop("TextBlock").text = "下キーと組み合わせられないボタンは\n使えません"

	elif step == 6:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（６）ボタン").text = "（６）右キー　を入れてください"

	elif step == 7:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（７）ボタン").text = "（７）左キー　を入れてください"
		self.monkey().get_my_telop("TextBlock").text = "右キーと組み合わせられないボタンは\n使えません"

	# 完了時
	elif step == 8:
		#											   "１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("TextBlock").text = "完了"
		self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ完了音").play()


# 入力確定メッセージ
func set_done_message_the_button(step, button_number):
	var button_presentation_name = self.monkey().display_node().get_button_name_by_number(button_number)
	
	if step == 1:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０１２３４５６７８９："
		self.monkey().get_my_telop("（１）ボタン").text = "（１）キャンセルボタン、メニューボタン　　　：　" + button_presentation_name

	elif step == 2:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（２）ボタン").text = "（２）決定ボタン、メッセージ送りボタン　　　：　" + button_presentation_name

	elif step == 3:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（３）ボタン").text = "（３）メッセージ早送りボタン　　　　　　　　：　" + button_presentation_name

	elif step == 4:
		# ボタンと、レバーでは、対応が異なる
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（４）ボタン").text = "（４）下キー　　　　　　　　　　　　　　　　：　" + button_presentation_name

	elif step == 5:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（５）ボタン").text = "（５）上キー　　　　　　　　　　　　　　　　：　" + button_presentation_name

	elif step == 6:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（６）ボタン").text = "（６）右キー　　　　　　　　　　　　　　　　：　" + button_presentation_name

	elif step == 7:
		#												"１２３４５６７８９０１２３４５６７８９０１２３４５６７８９０："
		self.monkey().get_my_telop("（７）ボタン").text = "（７）左キー　　　　　　　　　　　　　　　　：　" + button_presentation_name


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_number(button_number_1):
	if button_number_1 < 0:
		return &""
		
	if button_number_1 < 1000:
		return "ボタン" + str(button_number_1)

	return "レバー" + str(button_number_1 - 1000)


# キーコンフィグ画面に入る時の演出
func perform_at_open_scene():
	# 音楽
	self.monkey().the_programmer_node().bg_musics.find_node("🎵キーコンフィグ").play()

	# イラストレーター表示
	self.monkey().the_illustrator_node().show()
	
	# テロップ表示
	self.monkey().of_staff().telop_coordinator_node().show()
	self.monkey().get_my_telop("TextBlock").visible = true

	# GUI - メッセージ・ウィンドウ
	self.monkey().the_programmer_node().images.find_node("■上_大").show()
	self.monkey().the_programmer_node().images.find_node("■下").show()
	self.monkey().the_programmer_node().telops.find_node("Ｔキーコンフィグ").show()

	# テロップ
	self.monkey().display_node().set_empty_the_button_message(1)
	self.monkey().display_node().set_empty_the_button_message(2)
	self.monkey().display_node().set_empty_the_button_message(3)
	self.monkey().display_node().set_ok_message()


# キーコンフィグ終了時
func perform_at_close_scene():
	# GUI - メッセージ・ウィンドウ
	self.monkey().the_programmer_node().images.find_node("■上_大").hide()
	self.monkey().the_programmer_node().images.find_node("■下").hide()
	# テロップ非表示
	self.monkey().display_node().clear_message()
	self.monkey().the_telop_canvas_layer().hide()

	# BGM 停止	
	self.monkey().the_programmer_node().bg_musics.find_node("🎵キーコンフィグ").stop()


# 押下ボタンを受入
func show_pushed_button_accepted(key_config_item_number, button_number):
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ受入音").play()
	self.monkey().display_node().set_done_message_the_button(key_config_item_number, button_number)


# 押下ボタンを拒否
func show_pushed_button_denied(reason):
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ不可音").play()
	self.monkey().display_node().set_key_denied_message(reason)


# キャンセル・ボタンを押した時
func show_cancel():
	self.monkey().the_programmer_node().sound_fx.find_node("🔔キーコンフィグ取消音").play()
	self.monkey().display_node().clear_message()


# 内部では使ってない。外部向け。
# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number_1):
	for key in self.monkey().owner_key_config_node().key_config.keys():
		var value = self.monkey().owner_key_config_node().key_config[key]
		if button_number_1 == value:
			return key
	return &""
