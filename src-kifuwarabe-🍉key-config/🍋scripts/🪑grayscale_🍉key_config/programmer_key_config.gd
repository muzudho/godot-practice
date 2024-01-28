# キー・コンフィグ（Key Config；鍵構成）
#
#	細かな設定は何もできないので、ソースを直接カスタマイズしてください
extends Node2D


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 値はボタン番号。レバーは +1000
var key_config = {
	# 仮想キー（１）決定ボタン、メッセージ送りボタン
	&"VK_Ok" : -1,
	# 仮想キー（２）キャンセルボタン、メニューボタン
	&"VK_Cancel" : -1,
	# 仮想キー（３）メッセージ早送りボタン
	&"VK_FastForward" : -1,
}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 下に居る猿
func sub_monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 起動前設定
# ーーーーーーーー

func ready_in_staff():
	self.sub_monkey().display().ready_in_staff()


# ーーーーーーーー
# 時計
# ーーーーーーーー

func on_process(delta):
	self.sub_monkey().clock().on_process(delta)


# ーーーーーーーー
# 開始
# ーーーーーーーー

# キー・コンフィグ画面を始める
func entry():

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	self.sub_monkey().of_staff().telop_coordinator().show()
	self.sub_monkey().of_staff().illustrator_node().show()
	self.sub_monkey().of_staff().programmer().owner_node().images.find_node("■下").show()
	self.sub_monkey().of_staff().programmer().owner_node().images.find_node("■上_大").show()
	self.sub_monkey().of_staff().programmer().owner_node().telops.find_node("Ｔキーコンフィグ").show()

	# ーーーーーーーー
	# イベント
	# ーーーーーーーー
	# シーンの外側の１階層上の `👥Staff` ノードへアクセス
	self.sub_monkey().of_staff().programmer().owner_node().on_key_config_entered()
	
	# ーーーーーーーー
	# 状態遷移開始
	# ーーーーーーーー
	self.sub_monkey().statemachine().entry()


# ーーーーーーーー
# その他
# ーーーーーーーー

func on_exit():
	# シーンの外側の１階層上の `👥Staff` ノードへアクセス
	self.sub_monkey().of_staff().programmer().owner_node().on_key_config_exited()


func on_unhandled_input(event):
	self.sub_monkey().input().on_unhandled_input(event)


# ーーーーーーーー
# 以下、有ったら便利な関数
# ーーーーーーーー

# ボタン番号、またはレバー番号を返す。レバー番号は +1000 して返す。該当がなければ -1 を返す
func get_button_number_by_text(event_as_text):
	return self.sub_monkey().moderator().get_button_number_by_text(event_as_text)


# レバーのイベント文字列から、-1.0 ～ 1.0 の値を取得
func get_lever_value_by_text(event_as_text):
	return self.sub_monkey().moderator().get_lever_value_by_text(event_as_text)


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_number(button_number):
	return self.sub_monkey().moderator().get_button_name_by_number(button_number)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number):
	return self.sub_monkey().moderator().get_virtual_key_name_by_button_number(button_number)


# 上キーが入力されたか？
func is_key_up_by_text(event_as_text):
	var button_number = self.get_button_number_by_text(event_as_text)
	var virtual_key_name = self.get_virtual_key_name_by_button_number(button_number)
	var lever_value = self.get_lever_value_by_text(event_as_text)
	
	return self.is_key_up(virtual_key_name, lever_value)


# 上キーが入力されたか？
func is_key_up(virtual_key_name, lever_value):

	if virtual_key_name == &"VK_Up":
		return true

	if virtual_key_name == &"VK_Down" and lever_value < 0:
		return true

	return false


# 下キーが入力されたか？
func is_key_down_by_text(event_as_text):
	var button_number = self.get_button_number_by_text(event_as_text)
	var virtual_key_name = self.get_virtual_key_name_by_button_number(button_number)
	var lever_value = self.get_lever_value_by_text(event_as_text)
	
	return self.is_key_down(virtual_key_name, lever_value)


# 下キーが入力されたか？
func is_key_down(virtual_key_name, lever_value):
	return virtual_key_name == &"VK_Down" and 0 <= lever_value
