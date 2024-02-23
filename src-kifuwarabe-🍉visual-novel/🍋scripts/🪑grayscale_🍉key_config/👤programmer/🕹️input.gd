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
#		［０］　プラン・ステート（Plane State；計画状態）。　ハードウェアから入力があったが、まだ処理していない状態
#			ボタン：　押していないとき 0、押しているとき 1
#			レバー：　実数
#
#		［１］　アクセプテッド・ステート（Accepted State；計画状態）。　受け付けた、入力状態
#			ボタン：　押していないとき 0、押しているとき 1
#			レバー：　実数
#
#		［２］　プロセス（Process；状態変化）。　値は以下の通り。初期値は &"Neutral" とする
#			&"Release?"：　ボタン、レバー等から指を離して、押されている状態から、ホーム位置にある状態へ遷移している途中（省略されることがあります）
#			&"Released"：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態に到達した最初のフレーム
#			&"Neutral" ：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態で、その状態の２フレーム目以降
#			&"Press?"  ：　ボタン、レバー等が、ホーム位置にあった状態から、押されている状態へ遷移している途中（省略されることがあります）
#			&"Pressed" ：　ボタン、レバー等が、押されている状態に到達した最初のフレーム
#			&"Pressing"：　ボタン、レバー等が、押されている状態で、その状態の２フレーム目以降
#
#		［３］　プレビアス・プロセス（Previous process；１つ前のプロセス）
#
#		［４］　入力の有無
#
var key_record = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : [0, 0, &"Neutral", &"Neutral", false],
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : [0, 0, &"Neutral", &"Neutral", false],
	# メッセージ早送りボタン
	&"VK_FastForward" : [0, 0, &"Neutral", &"Neutral", false],
	# レバーの左右
	&"VK_Right" : [0, 0, &"Neutral", &"Neutral", false],
	# レバーの上下
	&"VK_Down" : [0, 0, &"Neutral", &"Neutral", false],
}


func is_receipt(vk_name):
	return self.key_record[vk_name][4]


func set_receipt(vk_name, is_receipt):
	self.key_record[vk_name][4] = is_receipt


func get_plan_key_state(vk_name):
	return self.key_record[vk_name][0]


func set_plan_key_state(vk_name, vk_state):
	self.key_record[vk_name][0] = vk_state


func get_accepted_key_state(vk_name):
	return self.key_record[vk_name][1]


func set_accepted_key_state(vk_name, vk_state):
	self.key_record[vk_name][1] = vk_state


func get_key_process(vk_name):
	return self.key_record[vk_name][2]


func set_key_process(vk_name, vk_process):
	self.key_record[vk_name][2] = vk_process


func get_previous_key_process(vk_name):
	return self.key_record[vk_name][3]


func set_previous_key_process(vk_name, vk_process):
	self.key_record[vk_name][3] = vk_process


func is_process_changed(vk_name):
	return self.get_key_process(vk_name) != self.get_previous_key_process(vk_name)


func update_key_process(vk_name, accepted_state, key_process):
	self.set_accepted_key_state(vk_name, accepted_state)

	# 未設定にする
	self.set_plan_key_state(vk_name, 0)

	self.set_previous_key_process(vk_name, self.get_key_process(vk_name))
	self.set_key_process(vk_name, key_process)


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
	self.process_virtual_key(&"VK_Ok")
	self.process_virtual_key(&"VK_Cancel")
	self.process_virtual_key(&"VK_FastForward")
	self.process_virtual_key(&"VK_Right")
	self.process_virtual_key(&"VK_Down")

	# 拡張
	self.extension_node().on_process(delta)


# Parameters
# ==========
# * `vk_name` - Virtual key name
func process_virtual_key(vk_name):
	# 状態変化はどうなったか？
	var plan_state = self.get_plan_key_state(vk_name)
	var abs_plan_state = abs(plan_state)
	var vk_process = self.get_key_process(vk_name)

	# 押すか、放すか、どちらかに達するまで維持します
	if vk_process == &"Release?" || vk_process == &"Press?":
		if 1 <= abs_plan_state:
			print("［入力解析］　［" + vk_name +"］キーについて、浮遊状態から押下確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressed")
			self.set_receipt(vk_name, false)
			return
		
		if 0 == abs_plan_state:
			print("［入力解析］　［" + vk_name +"］キーについて、浮遊状態から解放確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Released")
			self.set_receipt(vk_name, false)
			return

	elif vk_process == &"Released" || vk_process == &"Neutral":
		if 1 <= abs_plan_state:
			print("［入力解析］　［" + vk_name +"］キーについて、解放状態から押下確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressed")
			self.set_receipt(vk_name, false)
			return
		
		if 0 < abs_plan_state && abs_plan_state < 1:
			print("［入力解析］　［" + vk_name +"］キーについて、解放状態から押下浮遊　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Press?")
			self.set_receipt(vk_name, false)
			return
		
		if vk_process == &"Released":
			print("［入力解析］　［" + vk_name +"］キーについて、解放からニュートラルへ　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Neutral")
			self.set_receipt(vk_name, false)
			return

	elif vk_process == &"Pressed" || vk_process == &"Pressing":
		# TODO 押しっぱなしなのに 0 になることがある？
		if 0 == abs_plan_state:
			print("［入力解析］　［" + vk_name +"］キーについて、押下状態から解放確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Released")
			self.set_receipt(vk_name, false)
			return
			
		if 0 < abs_plan_state && abs_plan_state < 1:
			print("［入力解析］　［" + vk_name +"］キーについて、押下状態から解放浮遊　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Release?")
			self.set_receipt(vk_name, false)
			return
			
		if vk_process == &"Pressed":
			print("［入力解析］　［" + vk_name +"］キーについて、押下から押しっぱなしへ　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressing")
			self.set_receipt(vk_name, false)
			return

	# 継続
	self.update_key_process(vk_name, plan_state, vk_process)
	self.set_receipt(vk_name, false)


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	self.on_key_changed(event)

	# 拡張
	self.extension_node().on_unhandled_key_input(event)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#	X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#
func _unhandled_input(event):
	self.on_key_changed(event)
	
	# 拡張
	self.extension_node().on_unhandled_input(event)


# キー入力を受け取り、その状態を記憶します
func on_key_changed(event):
	# キー入力を受け取り、その状態を記憶します
	var button_symbol = self.monkey().key_config().input_parser_node().get_button_symbol_by_text(event.as_text())

	# Virtual key name
	var vk_name = self.monkey().key_config_node().get_virtual_key_name_by_hardware_symbol(button_symbol)

	# レバーでなければ 0.0 を返す
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())

	print("［入力　シナリオ再生中の入力で　アンハンドルド・インプット］　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))

	if vk_name == &"VK_Ok":
		self.set_receipt(vk_name, true)
		self.set_plan_key_state(vk_name, 1)

	elif vk_name == &"VK_Cancel":
		self.set_receipt(vk_name, true)
		self.set_plan_key_state(vk_name, 1)

	elif vk_name == &"VK_FastForward":
		self.set_receipt(vk_name, true)
		self.set_plan_key_state(vk_name, 1)

	elif vk_name == &"VK_Right":
		self.set_receipt(vk_name, true)
		self.set_plan_key_state(vk_name, lever_value)

	elif vk_name == &"VK_Down":
		self.set_receipt(vk_name, true)
		self.set_plan_key_state(vk_name, lever_value)
