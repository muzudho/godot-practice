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
#	レバー・ディレクション（Lever Direction；レバーの向き）について
#		- [-1.0 ～ 1.0] の範囲があるが、ぴったり 0 になることは稀
#		- 例えば (-0.2 ～ 0.2) を［解放］とするようなレンジが要る
#
#	ステート
#		- ボタンや、キーボードのキーなら、［解放］を 0 、［押下］を 1
#		- Ｘ軸レバーなら、右方向を正として [-1.0 ～ 1.0]
#		- Ｙ軸レバーなら、下方向を正として [-1.0 ～ 1.0]
#
# 辞書
# 	キー：　プログラム内で決まりを作っておいてください。
# 	値：　以下、それぞれ説明
#
#		［０］　オカレンス。初期値は &"None" とする
#			&"None"：	何も検知していない
#			&"Pressed"：	［押下］を検知
#			&"Release"：［解放］を検知
#
#		［１］　ドゥ―リング。初期値は &"Neutral" とする
#			&"Neutral"：		［解放］を検知したあと、まだ［押下］を検知していない間
#			&"Pressing"：	［押下］を検知したあと、まだ［解放］を検知していない間
#
#		［２］　ステート
#			ボタン：　整数。［解放］のとき 0、 ［押下］のとき 1、 何もしていないとき、前の値を維持
#			レバー：　実数。-1.0 ～ 1.0。 何もしていないとき、前の値を維持
#
var key_record = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : [&"None", &"Neutral", 0.0],
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : [&"None", &"Neutral", 0.0],
	# メッセージ早送りボタン
	&"VK_FastForward" : [&"None", &"Neutral", 0.0],
	# ボタンの右、または、レバーの左右
	&"VK_Right" : [&"None", &"Neutral", 0.0],
	# ボタンの左
	#&"VK_Left"	
	# ボタンの下、または、レバーの上下
	&"VK_Down" : [&"None", &"Neutral", 0.0],
	# ボタンの上
	#&"VK_Up"
}


func get_occurence(vk_name):
	return self.key_record[vk_name][0]


func set_occurence(vk_name, value):
	self.key_record[vk_name][0] = value


func get_during(vk_name):
	return self.key_record[vk_name][1]


func set_during(vk_name, value):
	self.key_record[vk_name][1] = value


func get_state(vk_name):
	return self.key_record[vk_name][2]


func set_state(vk_name, value):
	self.key_record[vk_name][2] = value


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
	self.end_of_process_by_virtual_key(&"VK_Ok")
	self.end_of_process_by_virtual_key(&"VK_Cancel")
	self.end_of_process_by_virtual_key(&"VK_FastForward")
	self.end_of_process_by_virtual_key(&"VK_Right")
	self.end_of_process_by_virtual_key(&"VK_Down")


# 毎フレーム実行されます
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func end_of_process_by_virtual_key(vk_name):
	# 状態変化はどうなったか？
	var vk_state = self.get_state(vk_name)
	var abs_vk_state = abs(vk_state)
	var vk_occurence = self.get_occurence(vk_name)
	var vk_during = self.get_during(vk_name)

	# オカレンスは毎フレーム、クリアーします
	self.set_occurence(vk_name, &"None")

	# 以下、デバッグ出力
	if vk_occurence == &"Released" || vk_during == &"Neutral":
		# 放しているのにボタン値が 1 というのは矛盾してる
		if 1 <= abs_vk_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下確定 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
		
		if 0 < abs_vk_state && abs_vk_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放状態から押下浮遊 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
		
		if vk_occurence == &"Released":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、解放からニュートラルへ vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return

	elif vk_occurence == &"Pressed" || vk_during == &"Pressing":
		# TODO 押しっぱなしにすると、最初の１回（Pressed）しかイベントが発生しない。２フレーム後には ボタン値は 0 にクリアーされてしまう
		# 押しているときに ボタン値が 0 というのは矛盾してる
		if 0 == abs_vk_state:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放確定 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
			
		if 0 < abs_vk_state && abs_vk_state < 1:
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下状態から解放浮遊 vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
			
		if vk_occurence == &"Pressed":
			print("［入力　process_virtual_key］　［" + vk_name +"］キーについて、押下から押しっぱなしへ vk_occurence:" + vk_occurence + " vk_during:" + vk_during)
			return
	
	# 継続
	pass


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
				self.set_state(vk_name, 1)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
				
			elif event.is_released():
				print("［入力解析　on_key_changed］　ボタンを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, 0)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
		# レバーかも
		else:
			if 1 <= abs(lever_value):
				print("［入力解析　on_key_changed］　レバーを倒したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Pressed")
				self.set_during(vk_name, &"Pressing")
				return
			
			# ぴったり 0 になることは難しいのでレンジで指定する
			elif abs(lever_value) < 0.2:
				print("［入力解析　on_key_changed］　レバーを元に戻したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				self.set_occurence(vk_name, &"Released")
				self.set_during(vk_name, &"Neutral")
				return
				
			else:
				print("［入力解析　on_key_changed］　レバーをアナログ操作中か？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
				self.set_state(vk_name, lever_value)
				# 状態はキープ
				return
				
	# キーボードのキーか？
	else:
		if event.is_pressed():
			print("［入力解析　on_key_changed］　キーボードのキーを押したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_state(vk_name, 1)
			self.set_occurence(vk_name, &"Pressed")
			self.set_during(vk_name, &"Pressing")
			return
			
		elif event.is_released():
			print("［入力解析　on_key_changed］　キーボードのキーを放したか？　event:" + event.as_text() + " button_symbol:" + str(button_symbol) + " vk_name:" + str(vk_name) + " lever_value:" + str(lever_value))
			self.set_state(vk_name, 0)
			self.set_occurence(vk_name, &"Released")
			self.set_during(vk_name, &"Neutral")
			return

	# 入力を検知できなかったなら
	self.set_occurence(vk_name, &"None")
	# その他は維持


# 上キーが入力されたか？
#
#	（レバーではなく）上キーと下キーに別々にボタンを設定しているケースがある
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
# * `vk_state` - Lever value
func is_key_up(
		vk_name,
		vk_state):

	if vk_name == &"VK_Up":
		print("［キー入力］　上キー押下")
		return true

	if vk_name == &"VK_Down" and vk_state < 0:
		print("［キー入力］　下キー押下、かつ　Ｙ軸レバーをマイナス方向に倒した")
		return true

	print("［キー入力］　上キー押下ではない。 vk_name:" + vk_name + " vk_state:" + str(vk_state))
	return false


# 下キーが入力されたか？
#
#	（レバーではなく）上キーと下キーに別々にボタンを設定しているケースがある
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
# * `vk_state` - Lever value
func is_key_down(
		vk_name,
		vk_state):
	
	if vk_name == &"VK_Down" and 0 < vk_state:
		print("［キー入力］　下キー押下、かつ　Ｙ軸レバーをプラス方向に倒した")
		return true

	print("［キー入力］　下キー押下ではない。 vk_name:" + vk_name + " vk_state:" + str(vk_state))
	return false

