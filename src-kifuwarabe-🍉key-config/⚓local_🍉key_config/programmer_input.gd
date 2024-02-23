# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 仮想キーのこの瞬間の入力状態
#
# 	キー：　プログラム内で決まりを作っておいてください。
# 	値：
#		ボタン：　押していないとき 0、押しているとき 1
#		レバー：　実数
#
var key_state = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : 0,
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : 0,
	# メッセージ早送りボタン
	&"VK_FastForward" : 0,
	# レバーの左右
	&"VK_Right" : 0,
	# レバーの上下
	&"VK_Down" : 0,
}


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):
	# キー入力を受け取り、その状態を記憶します
	self.memory_key_state(event)
	
	# キーコンフィグで必要です
	self.monkey().key_config_node().on_unhandled_input(event)

# キー入力を受け取り、その状態を記憶します
func memory_key_state(event):
	print("［入力　シナリオ再生中の入力で　アンハンドルド・インプット］　event:" + event.as_text())
	var button_number = self.monkey().key_config().input_parser_node().get_button_number_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

	var virtual_key_name = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)
	#print("［入力　シナリオ再生中の入力で］　virtual_key_name:" + str(virtual_key_name))

	if virtual_key_name == &"VK_Ok":
		self.key_state[&"VK_Ok"] = 1

	elif virtual_key_name == &"VK_Cancel":
		self.key_state[&"VK_Cancel"] = 1

	elif virtual_key_name == &"VK_FastForward":
		self.key_state[&"VK_FastForward"] = 1

	elif virtual_key_name == &"VK_Right":
		self.key_state[&"VK_Right"] = lever_value

	elif virtual_key_name == &"VK_Down":
		self.key_state[&"VK_Down"] = lever_value
