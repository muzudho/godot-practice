# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 入力
# ーーーーーーーー


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func on_unhandled_key_input(event):
	var vk_operation = null

	# 何かキーを押したとき
	if event.is_pressed():
		print("［監督］　キー入力　押下")
		vk_operation = &"VKO_Pressed"
	
	# 何かキーを離したとき
	elif event.is_released():
		print("［監督］　キー入力　リリース")
		vk_operation = &"VKO_Released"
	
	# それ以外には対応してない
	else:
		print("［監督］　キー入力　▲！想定外")
		return

	# 以下、仮想キー

	# このゲーム独自の仮想キーに変換
	var virtual_key_name = null
	
	# エンターキー押下
	if event.keycode == KEY_ENTER:
		virtual_key_name = &"VK_Ok"

	# エスケープキー押下
	elif event.keycode == KEY_ESCAPE:
		virtual_key_name = &"VK_Cancel"

	# ［Ｒ］キー押下（後でスーパーファミコンの R キーにしようと思っていたアルファベット）
	elif event.keycode == KEY_R:
		virtual_key_name = &"VK_FastForward"
	
	# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
	else:
		return

	var lever_value = 0.0

	# 仮想キーを押下したという建付け
	self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func on_unhandled_input(event):
	var vk_operation = null

	# 何かキーを押したとき
	if event.is_pressed():
		#print("［監督］　入力　押下")
		vk_operation = &"VKO_Pressed"
	
	# 何かキーを離したとき
	elif event.is_released():
		#print("［監督］　入力　リリース")
		vk_operation = &"VKO_Released"
	
	# それ以外には対応してない
	else:
		print("［監督］　入力　▲！想定外")
		return

	# ーーーーーーーー
	# 以下、仮想キー
	# ーーーーーーーー
	# 文字列だけだと、押したのか放したのか分からない
	var event_as_text = event.as_text()
	
	# 文字列をボタン番号に変換
	var button_number = self.monkey().of_programmer().key_config_node().get_button_number_by_text(event_as_text)
	
	# ボタン番号を、仮想キー名に変換
	var virtual_key_name = self.monkey().of_programmer().key_config_node().get_virtual_key_name_by_button_number(button_number)

	# レバー値
	var lever_value = self.monkey().of_programmer().key_config_node().get_lever_value_by_text(event_as_text)

	# 仮想キーを押下したという建付け
	self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# 仮想キーを押下したという建付け
#
# 呼出し元:
# 	on_unhandled_key_input()
#	on_unhandled_input()
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if self.monkey().of_staff().programmer().department_controller_node().sub_monkey().input().on_virtual_key_input(
			virtual_key,
			lever_value,
			vk_operation):
		# 入力されたキーへの対処が完了したなら、処理を抜ける
		return

	# シナリオライター・ハブで　この入力をスルーしたなら、以降の処理を続ける
	print("［監督］　仮想キー（" + virtual_key + "）　レバー値：" + str(lever_value) + "　操作：" + vk_operation)

	# メッセージ・ウィンドウへ渡す
	self.monkey().of_programmer().scenario_player().get_current_message_window_gui().on_virtual_key_input(virtual_key, lever_value, vk_operation)
