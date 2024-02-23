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


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 仮想キー辞書
#
# 	キー：　プログラム内で決まりを作っておいてください。
# 	値：　以下、それぞれ説明
#
#		［０］　ステート（State；状態）。　仮想キーのこの瞬間の入力状態
#			ボタン：　押していないとき 0、押しているとき 1
#			レバー：　実数
#
#		［１］　プロセス（Process；状態変化）。　値は以下の通り。初期値は &"Neutral" とする
#			&"Release?"：　ボタン、レバー等から指を離して、押されている状態から、ホーム位置にある状態へ遷移している途中（省略されることがあります）
#			&"Released"：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態に到達した最初のフレーム
#			&"Neutral" ：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態で、その状態の２フレーム目以降
#			&"Press?"  ：　ボタン、レバー等が、ホーム位置にあった状態から、押されている状態へ遷移している途中（省略されることがあります）
#			&"Pressed" ：　ボタン、レバー等が、押されている状態に到達した最初のフレーム
#			&"Pressing"：　ボタン、レバー等が、押されている状態で、その状態の２フレーム目以降
#
#		［２］　 プレビアス・プロセス（Previous process；１つ前のプロセス）
#
#
var key_record = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : [0, &"Neutral", &"Neutral"],
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : [0, &"Neutral", &"Neutral"],
	# メッセージ早送りボタン
	&"VK_FastForward" : [0, &"Neutral", &"Neutral"],
	# レバーの左右
	&"VK_Right" : [0, &"Neutral", &"Neutral"],
	# レバーの上下
	&"VK_Down" : [0, &"Neutral", &"Neutral"],
}


func get_key_state(vk_name):
	return self.key_record[vk_name][0]


func set_key_state(vk_name, vk_state):
	self.key_record[vk_name][0] = vk_state


func get_key_process(vk_name):
	return self.key_record[vk_name][1]


func set_key_process(vk_name, vk_state):
	self.key_record[vk_name][2] = self.key_record[vk_name][1]
	self.key_record[vk_name][1] = vk_state


func is_process_changed(vk_name):
	var is_changed = self.key_record[vk_name][1] != self.key_record[vk_name][2]
	if is_changed:
		print("［状態変化］　previous:" + self.key_record[vk_name][2] + " current:" + self.key_record[vk_name][1])
	return is_changed


# ーーーーーーーー
# 毎フレーム処理
# ーーーーーーーー

# 毎フレーム実行されるので、処理は軽くしたい
#
# 	入力されたキーが複数ある場合、 `_unhandled_input` が全部終わってから `_process` が呼出されることを期待する
#
func _process(delta):
	#print("［★プロセス］　delta:" + str(delta))

	# 仮想キーの［状態変化］の解析
	self.process_virtual_key(&"VK_Ok")
	self.process_virtual_key(&"VK_Cancel")
	self.process_virtual_key(&"VK_FastForward")
	self.process_virtual_key(&"VK_Right")
	self.process_virtual_key(&"VK_Down")

	# 拡張
	self.extension_node().on_process(delta)

	# 仮想キーの入力状態のクリアー
	self.set_key_state(&"VK_Ok", 0)
	self.set_key_state(&"VK_Cancel", 0)
	self.set_key_state(&"VK_FastForward", 0)
	self.set_key_state(&"VK_Right", 0)
	self.set_key_state(&"VK_Down", 0)


# Parameters
# ==========
# * `vk_name` - Virtual key name
func process_virtual_key(vk_name):
	var old_process = self.get_key_process(vk_name)
	var abs_old_state = abs(self.get_key_state(vk_name))

	# 押すか、放すか、どちらかに達するまで維持します
	if old_process == &"Release?" || old_process == &"Press?":
		if 1 <= abs_old_state:
			print("［入力解析］　浮遊状態から押下確定")
			self.set_key_process(vk_name, &"Pressed")
		elif 0 == abs_old_state:
			print("［入力解析］　浮遊状態から解放確定")
			self.set_key_process(vk_name, &"Released")

	elif old_process == &"Released" || old_process == &"Neutral":
		if 1 <= abs_old_state:
			print("［入力解析］　解放状態から押下確定")
			self.set_key_process(vk_name, &"Pressed")
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　解放状態から押下浮遊")
			self.set_key_process(vk_name, &"Press?")
		elif old_process == &"Released":
			print("［入力解析］　解放確定からニュートラルへ")
			self.set_key_process(vk_name, &"Neutral")


	elif old_process == &"Pressed" || old_process == &"Pressing":
		if 0 == abs_old_state:
			print("［入力解析］　押下状態から解放確定")
			self.set_key_process(vk_name, &"Released")
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　押下状態から解放浮遊")
			self.set_key_process(vk_name, &"Release?")
		elif old_process == &"Pressed":
			print("［入力解析］　押下確定から押しっぱなしへ")
			self.set_key_process(vk_name, &"Pressing")


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
	var button_symbol = self.monkey().key_config().input_parser_node().get_button_symbol_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　button_symbol:" + str(button_symbol))

	# Virtual key name
	var vk_name = self.monkey().key_config_node().get_virtual_key_name_by_hardware_symbol(button_symbol)
	#print("［入力　シナリオ再生中の入力で］　virtual_key_name:" + str(vk_name))

	# レバーでなければ 0.0 を返す
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

	self.set_non_zero_key_state(vk_name, lever_value)

	# 拡張
	self.extension_node().on_unhandled_input(event)


# キー入力を受け取り、その状態を記憶します
func set_non_zero_key_state(vk_name, lever_value):

	if vk_name == &"VK_Ok":
		self.set_key_state(vk_name, 1)

	elif vk_name == &"VK_Cancel":
		self.set_key_state(vk_name, 1)

	elif vk_name == &"VK_FastForward":
		self.set_key_state(vk_name, 1)

	elif vk_name == &"VK_Right":
		self.set_key_state(vk_name, lever_value)

	elif vk_name == &"VK_Down":
		self.set_key_state(vk_name, lever_value)
