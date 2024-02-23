# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# 拡張ノード取得
func extension_node():
	return $"Extension"


# 実際上ノード取得
func virtual_node():
	return $"Virtual"


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

# 仮想キーの入力状態の変化の種類
#
# 	キー：　プログラム内で決まりを作っておいてください。
#	値：
#		&"Release?"：　ボタン、レバー等から指を離して、押されている状態から、ホーム位置にある状態へ遷移している途中（省略されることがあります）
#		&"Released"：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態に到達した最初のフレーム
#		&"Neutral" ：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態で、その状態の２フレーム目以降
#		&"Press?"  ：　ボタン、レバー等が、ホーム位置にあった状態から、押されている状態へ遷移している途中（省略されることがあります）
#		&"Pressed" ：　ボタン、レバー等が、押されている状態に到達した最初のフレーム
#		&"Pressing"：　ボタン、レバー等が、押されている状態で、その状態の２フレーム目以降
#		初期値は &"Neutral" とする
#
var key_process = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : &"Neutral",
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : &"Neutral",
	# メッセージ早送りボタン
	&"VK_FastForward" : &"Neutral",
	# レバーの左右
	&"VK_Right" : &"Neutral",
	# レバーの上下
	&"VK_Down" : &"Neutral",
}


# ーーーーーーーー
# 毎フレーム処理
# ーーーーーーーー

# 毎フレーム実行されるので、処理は軽くしたい
#
# 	入力されたキーが複数ある場合、 `_unhandled_input` が全部終わってから `_process` が呼出されることを期待する
#
func _process(delta):
	#print("［★プロセス］　delta:" + str(delta))

	# 仮想キーの状態変化の解析
	self.parse_key_process(&"VK_Ok")
	self.parse_key_process(&"VK_Cancel")
	self.parse_key_process(&"VK_FastForward")
	self.parse_key_process(&"VK_Right")
	self.parse_key_process(&"VK_Down")

	# 拡張
	self.extension_node().on_process(delta)
	
	# 仮想キーの入力状態のクリアー
	self.key_state[&"VK_Ok"] = 0
	self.key_state[&"VK_Cancel"] = 0
	self.key_state[&"VK_FastForward"] = 0
	self.key_state[&"VK_Right"] = 0
	self.key_state[&"VK_Down"] = 0


func parse_key_process(virtual_key_name):
	var old_process = self.key_process[virtual_key_name]
	var abs_old_state = abs(self.key_state[virtual_key_name])

	# 押すか、放すか、どちらかに達するまで維持します
	if old_process == &"Release?" || old_process == &"Press?":
		if 1 <= abs_old_state:
			print("［入力解析］　浮遊状態から押下確定")
			self.key_process[virtual_key_name] = &"Pressed"
		elif 0 == abs_old_state:
			print("［入力解析］　浮遊状態から解放確定")
			self.key_process[virtual_key_name] = &"Released"
	
	elif old_process == &"Released" || old_process == &"Neutral":
		if 1 <= abs_old_state:
			print("［入力解析］　解放状態から押下確定")
			self.key_process[virtual_key_name] = &"Pressed"
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　解放状態から押下浮遊")
			self.key_process[virtual_key_name] = &"Press?"
	
	elif old_process == &"Pressed" || old_process == &"Pressing":
		if 0 == abs_old_state:
			print("［入力解析］　押下状態から解放確定")
			self.key_process[virtual_key_name] = &"Released"
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　押下状態から解放浮遊")
			self.key_process[virtual_key_name] = &"Release?"


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	# 拡張
	self.extension_node().on_unhandled_key_input(event)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#	X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#
func _unhandled_input(event):
	# キー入力を受け取り、その状態を記憶します
	print("［入力　シナリオ再生中の入力で　アンハンドルド・インプット］　event:" + event.as_text())
	var button_number = self.monkey().key_config().input_parser_node().get_button_number_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))

	# Virtual key name
	var vk_name = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)
	#print("［入力　シナリオ再生中の入力で］　virtual_key_name:" + str(vk_name))
	
	# レバーの値
	# レバーでなければ 0.0 を返す
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

	self.set_non_zero_key_state(vk_name, lever_value)

	# 拡張
	self.extension_node().on_unhandled_input(event)


# キー入力を受け取り、その状態を記憶します
func set_non_zero_key_state(vk_name, lever_value):

	if vk_name == &"VK_Ok":
		self.key_state[vk_name] = 1

	elif vk_name == &"VK_Cancel":
		self.key_state[vk_name] = 1

	elif vk_name == &"VK_FastForward":
		self.key_state[vk_name] = 1

	elif vk_name == &"VK_Right":
		self.key_state[vk_name] = lever_value

	elif vk_name == &"VK_Down":
		self.key_state[vk_name] = lever_value
