# キー・コンフィグ・ハブ（Key Config Hub；鍵構成の中心地）
#
#	細かな設定は何もできないので、ソースを直接カスタマイズしてください
extends Node2D


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


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


# 監督ハブ取得
func get_director_hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🐵Monkey",
			self.ancestors)


# （外ノード）テロップ取得
func get_my_telop_canvas_layer():
	return self.get_director_hub().programmer_hub().telops.find_node("Ｔキーコンフィグ")


# （外ノード）テロップ取得
func get_my_telop(node_name_str):
	return self.get_my_telop_canvas_layer().get_node(node_name_str)


# 司会進行取得
func get_moderator():
	return $"Moderator"


# ーーーーーーーー
# その他
# ーーーーーーーー


# キー・コンフィグ画面を始めるタイミングで以下を呼出す
func entry():

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	self.get_director_hub().telop_coordinator().show()
	self.get_director_hub().illustrator().show()
	self.get_director_hub().programmer_hub().images.find_node("■下").show()
	self.get_director_hub().programmer_hub().images.find_node("■上_大").show()
	self.get_director_hub().programmer_hub().telops.find_node("Ｔキーコンフィグ").show()

	# ーーーーーーーー
	# イベント
	# ーーーーーーーー
	# シーンの外側の１階層上の `🌏Director` ノードへアクセス
	self.get_director_hub().owner_node().on_key_config_entered()
	
	# ーーーーーーーー
	# 状態遷移開始
	# ーーーーーーーー
	self.get_moderator().entry()


func on_exit():
	# シーンの外側の１階層上の `🌏Director` ノードへアクセス
	self.get_director_hub().owner_node().on_key_config_exited()


func on_process(delta):
	self.get_moderator().on_process(delta)


func on_unhandled_input(event):
	self.get_moderator().on_unhandled_input(event)


# ーーーーーーーー
# 以下、有ったら便利な関数
# ーーーーーーーー


# ボタン番号、またはレバー番号を返す。レバー番号は +1000 して返す。該当がなければ -1 を返す
func get_button_number_by_text(event_as_text):
	return self.get_moderator().get_button_number_by_text(event_as_text)


# レバーのイベント文字列から、-1.0 ～ 1.0 の値を取得
func get_lever_value_by_text(event_as_text):
	return self.get_moderator().get_lever_value_by_text(event_as_text)


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_number(button_number):
	return self.get_moderator().get_button_name_by_number(button_number)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number):
	return self.get_moderator().get_virtual_key_name_by_button_number(button_number)


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
