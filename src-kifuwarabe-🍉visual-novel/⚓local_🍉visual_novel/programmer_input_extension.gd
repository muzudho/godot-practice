# インプット　＞　エクステンション（Extension；拡張）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../../🐵Monkey"

# オーナー取得
func owner_node():
	return $"../../🕹️Input"


# ーーーーーーーー
# イベント・ハンドラー
# ーーーーーーーー

func on_process(_delta):
	# ［シナリオで］状態
	if self.monkey().owner_node().current_state == &"InScenario":
		self.parse_virtual_key_on_process(&"VK_Ok")
		self.parse_virtual_key_on_process(&"VK_Cancel")
		self.parse_virtual_key_on_process(&"VK_FastForward")
		self.parse_virtual_key_on_process(&"VK_Right")
		self.parse_virtual_key_on_process(&"VK_Down")


# Parameters
# ==========
# * `vk_name` - Virtual key name
func parse_virtual_key_on_process(vk_name):
	# まず、ボタンの押下状態を確認
	var vk_state = self.owner_node().key_state[vk_name]
	var vk_process = self.owner_node().key_process[vk_name]

	# 仮想キーを押下したという建付け
	self.monkey().of_staff().programmer().scenario_player().input_node().on_virtual_key_input(
			vk_name,
			vk_state,
			vk_process)


# ハンドルド・インプットは、キー・コンフィグ用
func on_handled_input(event):
	# ［キー・コンフィグで］状態
	if self.monkey().owner_node().current_state == &"InKeyConfig":
		# キーコンフィグ用
		self.monkey().key_config_node().on_unhandled_input(event)


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	# ［まだ準備ができていません］
	if self.monkey().owner_node().current_state == &"NotReadyYet":
		pass

	# ［キー・コンフィグで］は、何もするな
	elif self.monkey().owner_node().current_state == &"InKeyConfig":
		pass

	# ［シナリオで］状態
	elif self.monkey().owner_node().current_state == &"InScenario":

		# このゲーム独自の仮想キー（virtual key name）に変換
		var vk_name = null
		
		# エンターキー押下
		if event.keycode == KEY_ENTER:
			vk_name = &"VK_Ok"

		# エスケープキー押下
		elif event.keycode == KEY_ESCAPE:
			vk_name = &"VK_Cancel"

		# ［Ｒ］キー押下（後でスーパーファミコンの R キーにしようと思っていたアルファベット）
		elif event.keycode == KEY_R:
			vk_name = &"VK_FastForward"
		
		# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
		else:
			return

		var vk_state = 0.0
		var vk_process = &"Neutral"

		# 何かキーを押したとき
		if event.is_pressed():
			print("［監督］　キー入力　押下")
			vk_process = &"Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			print("［監督］　キー入力　リリース")
			vk_process = &"Released"
		
		# それ以外には対応してない
		else:
			print("［監督］　キー入力　▲！想定外")

		# 仮想キーを押下したという建付け
		self.monkey().of_staff().programmer().scenario_player().input_node().on_virtual_key_input(
				vk_name,
				vk_state,
				vk_process)
