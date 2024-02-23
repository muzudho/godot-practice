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
#	オカレンス（Occurence；起こった）について
#		- ［押下］（Pressed）と［解放］（Released）は検知できる
#		- アナログの場合、完全な押下を［押下］、完全な解放を［解放］と呼ぶことにする
#		- 何も検知していないとき［ナン］（None；無し）とする
#
#	ドゥ―リング（During；その間）について
#		- ［押しっぱなし］（Pressing）は検知できない
#		- ［押下］後、次の［解放］までの期間を［押しっぱなし］と考える必要がある
#		- ［放しっぱなし］も同様
#	
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
#		TODO プロセスを廃止して、オカレンスとドゥ―リングを使いたい
#		［２］　プロセス（Process；状態変化）。　値は以下の通り。初期値は &"Neutral" とする
#			&"Release?"：　ボタン、レバー等から指を離して、押されている状態から、ホーム位置にある状態へ遷移している途中（省略されることがあります）
#			&"Released"：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態に到達した最初のフレーム
#			&"Neutral" ：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態で、その状態の２フレーム目以降
#			&"Press?"  ：　ボタン、レバー等が、ホーム位置にあった状態から、押されている状態へ遷移している途中（省略されることがあります）
#			&"Pressed" ：　ボタン、レバー等が、押されている状態に到達した最初のフレーム
#			&"Pressing"：　ボタン、レバー等が、押されている状態で、その状態の２フレーム目以降
#
#		［３］　廃止
#
#		［４］　オカレンス。初期値は &"None" とする
#			&"None"：	何も検知していない
#			&"Pressed"：	［押下］を検知
#			&"Release"：［解放］を検知
#
#		［５］　ドゥ―リング。初期値は &"Neutral" とする
#			&"Neutral"：		［解放］を検知したあと、まだ［押下］を検知していない間
#			&"Pressing"：	［押下］を検知したあと、まだ［解放］を検知していない間
#
#
var key_record = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : [0, 0, &"Neutral", null, &"None", &"Neutral"],
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : [0, 0, &"Neutral", null, &"None", &"Neutral"],
	# メッセージ早送りボタン
	&"VK_FastForward" : [0, 0, &"Neutral", null, &"None", &"Neutral"],
	# レバーの左右
	&"VK_Right" : [0, 0, &"Neutral", null, &"None", &"Neutral"],
	# レバーの上下
	&"VK_Down" : [0, 0, &"Neutral", null, &"None", &"Neutral"],
}


func get_occurence(vk_name):
	return self.key_record[vk_name][4]


func set_occurence(vk_name, value):
	self.key_record[vk_name][4] = value


func get_during(vk_name):
	return self.key_record[vk_name][5]


func set_during(vk_name, value):
	self.key_record[vk_name][5] = value


func get_plan_key_state(vk_name):
	return self.key_record[vk_name][0]


func set_plan_key_state(vk_name, vk_state):
	self.key_record[vk_name][0] = vk_state


func get_accepted_key_state(vk_name):
	return self.key_record[vk_name][1]


func set_accepted_key_state(vk_name, vk_state):
	self.key_record[vk_name][1] = vk_state


# TODO 廃止方針
func get_key_process(vk_name):
	return self.key_record[vk_name][2]


# TODO 廃止方針
func set_key_process(vk_name, vk_process):
	self.key_record[vk_name][2] = vk_process


func update_key_process(vk_name, accepted_state, key_process):
	self.set_accepted_key_state(vk_name, accepted_state)

	# 未設定にする
	self.set_plan_key_state(vk_name, 0)

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

	# 拡張
	self.extension_node().on_process(delta)

	# 拡張処理のあとに
	# 仮想キーの状態変化の解析
	self.process_by_virtual_key(&"VK_Ok")
	self.process_by_virtual_key(&"VK_Cancel")
	self.process_by_virtual_key(&"VK_FastForward")
	self.process_by_virtual_key(&"VK_Right")
	self.process_by_virtual_key(&"VK_Down")


# 毎フレーム実行されます
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func process_by_virtual_key(vk_name):
	# 状態変化はどうなったか？
	var plan_state = self.get_plan_key_state(vk_name)
	var abs_plan_state = abs(plan_state)
	var vk_process = self.get_key_process(vk_name)

	# 押すか、放すか、どちらかに達するまで維持します
	if vk_process == &"Release?" || vk_process == &"Press?":
		if 1 <= abs_plan_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、浮遊状態から押下確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressed")
			return
		
		if 0 == abs_plan_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、浮遊状態から解放確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Released")
			return

	elif vk_process == &"Released" || vk_process == &"Neutral":
		# 放しているのにボタン値が 1 というのは矛盾してる
		if 1 <= abs_plan_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressed")
			return
		
		if 0 < abs_plan_state && abs_plan_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下浮遊　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Press?")
			return
		
		if vk_process == &"Released":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放からニュートラルへ　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Neutral")
			return
	
	#elif vk_process == &"Neutral":
	#	# 放しっぱなしなら、継続する
	#	pass

	elif vk_process == &"Pressed" || vk_process == &"Pressing":
		# TODO 押しっぱなしにすると、最初の１回（Pressed）しかイベントが発生しない。２フレーム後には ボタン値は 0 にクリアーされてしまう
		# 押しているときに ボタン値が 0 というのは矛盾してる
		if 0 == abs_plan_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放確定　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Released")
			return
			
		if 0 < abs_plan_state && abs_plan_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放浮遊　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Release?")
			return
			
		if vk_process == &"Pressed":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下から押しっぱなしへ　plan_state:" + str(plan_state) + "　vk_process:" + vk_process)
			self.update_key_process(vk_name, plan_state, &"Pressing")
			return
	
	#elif vk_process == &"Pressing":
	#	# 押しっぱなしなら、継続する
	#	pass

	# 継続
	self.update_key_process(vk_name, plan_state, vk_process)


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	print("［入力　アンハンドルド・キー・インプット］　開始　event_as_text:" + event.as_text())
	
	self.on_key_changed(event)

	# 拡張
	self.extension_node().on_unhandled_key_input(event)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#	- X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#	- ボタンの押下と解放を区別できるか？
#
func _unhandled_input(event):
	print("［入力　アンハンドルド・インプット］　開始　event_as_text:" + event.as_text())
	
	self.on_key_changed(event)
	# 拡張
	self.extension_node().on_unhandled_input(event)


# キー入力を受け取り、その状態を記憶します
#
#	FIXME キー入力ではないのに呼出されているケースがある？
#
func on_key_changed(event):
	# キー入力を受け取り、その状態を記憶します
	var button_symbol = self.monkey().key_config().input_parser_node().get_button_symbol_by_text(event.as_text())

	# Virtual key name
	var vk_name = self.monkey().key_config_node().get_virtual_key_name_by_hardware_symbol(button_symbol)
	
	# 仮想キー名が取れなかったら無視します
	if vk_name == &"":
		print("［入力解析　on_key_changed］　仮想キー名が無いイベントは、無視します　vk_name:" + str(vk_name) + "　event_as_text:" + event.as_text())
		return
	

	# レバーでなければ 0.0 を返す
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())

	# ボタンか？
	if typeof(button_symbol) != TYPE_STRING:
		# ボタンか？
		if button_symbol < 1000:
			if event.is_pressed():
				print("［入力解析　on_key_changed］ ボタンを押したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_plan_key_state(vk_name, 1)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
				
			elif event.is_released():
				print("［入力解析　on_key_changed］　ボタンを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_plan_key_state(vk_name, 0)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
		# レバーかも
		else:
			if 1 <= abs(lever_value):
				print("［入力解析　on_key_changed］　レバーを倒したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_plan_key_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
				
			elif abs(lever_value) == 0:
				print("［入力解析　on_key_changed］　レバーを元に戻したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_plan_key_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
			else:
				print("［入力解析　on_key_changed］　レバーをアナログ操作中か？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_plan_key_state(vk_name, lever_value)
				# 状態はキープ
				return
				
	# キーボードのキーか？
	else:
		if event.is_pressed():
			print("［入力解析　on_key_changed］　キーボードのキーを押したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_plan_key_state(vk_name, 1)
			self.set_occurence(vk_name, &"Pressed")
			self.set_during(vk_name, &"Pressing")
			return
			
		elif event.is_released():
			print("［入力解析　on_key_changed］　キーボードのキーを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_plan_key_state(vk_name, 0)
			self.set_occurence(vk_name, &"Released")
			self.set_during(vk_name, &"Neutral")
			return

	# 入力を検知できなかったなら
	self.set_occurence(vk_name, &"None")

