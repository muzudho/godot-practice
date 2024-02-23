# キー・コンフィグ（Key Config；鍵構成）
#
#	細かな設定は何もできないので、ソースを直接カスタマイズしてください
extends Node2D


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# キー：　プログラム内で決まりを作っておいてください。
# 値：
#		ボタン：　整数。ボタン番号（1000個もないはず）
#		レバー：　整数。レバーの軸の番号に + 1000 したもの
# TODO		キーボードのキー：　文字列。キーの名前
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
# 起動時設定
# ーーーーーーーー

func ready_in_staff():
	self.sub_monkey().display_node().ready_in_staff()


# ーーーーーーーー
# 時計
# ーーーーーーーー

func on_process(delta):
	self.sub_monkey().clock_node().on_process(delta)


# ーーーーーーーー
# 開始
# ーーーーーーーー

# キー・コンフィグ画面を始める
func entry():
	# 状態遷移開始
	self.sub_monkey().statemachine_node().entry()


# ーーーーーーーー
# その他
# ーーーーーーーー

func on_exit():
	# シーンの外側の１階層上の `👥Staff` ノードへアクセス
	self.sub_monkey().of_staff().programmer().owner_node().on_key_config_exited()


func on_unhandled_input(event):
	self.sub_monkey().input_node().on_unhandled_input(event)


# ーーーーーーーー
# アクセッサ―
# ーーーーーーーー

# 仮想キーの追加
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
# * `vk_symbol` - ボタン、レバーなら整数。キーボードのキーなら文字列
func push_virtual_key(vk_name, button_symbol):
	self.key_config[vk_name] = button_symbol


# ボタンが重複するか？
func is_key_duplicated(hardware_symbol_1):
	return hardware_symbol_1 in self.key_config.values()


# キャンセルボタン押下か？
func is_cancel_button_pressed(hardware_symbol_1):
	if not (&"VK_Cancel" in self.key_config):
		return false
	
	return typeof(hardware_symbol_1) == typeof(self.key_config[&"VK_Cancel"]) && hardware_symbol_1 == self.key_config[&"VK_Cancel"]


# ーーーーーーーー
# 以下、有ったら便利な関数
# ーーーーーーーー

# ボタン番号、またはレバー番号を返す。レバー番号は +1000 して返す。該当がなければ -1 を返す
func get_button_symbol_by_text(event_as_text):
	return self.sub_monkey().input_parser_node().get_button_symbol_by_text(event_as_text)


# レバーのイベント文字列から、-1.0 ～ 1.0 の値を取得
func get_lever_value_by_text(event_as_text):
	return self.sub_monkey().input_parser_node().get_lever_value_by_text(event_as_text)


# ❝ボタン１❞ や、 ❝レバー２❞ といった文字列を返す。該当がなければ空文字列を返す
func get_button_name_by_symbol(button_symbol):
	return self.sub_monkey().display_node().get_button_name_by_symbol(button_symbol)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_hardware_symbol(button_symbol):
	return self.sub_monkey().display_node().get_virtual_key_name_by_hardware_symbol(button_symbol)
