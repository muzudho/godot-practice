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


func parse_virtual_key_on_process(virtual_key_name):
	# まず、ボタンの押下状態を確認
	var button_state = self.owner_node().key_state[virtual_key_name]
	var button_process = self.owner_node().key_process[virtual_key_name]

	var vk_operation = null

	# 何かキーを押したとき
	if button_process == &"Pressed":
		#print("［監督］　入力　押下")
		vk_operation = &"VKO_Pressed"
	
	# 何かキーを離したとき
	elif button_process == &"Released":
		#print("［監督］　入力　リリース")
		vk_operation = &"VKO_Released"
	
	# それ以外には対応してない
	else:
		print("［監督］　入力　▲！想定外")
		return

	# 仮想キーを押下したという建付け
	self.monkey().of_staff().programmer().scenario_player().input_node().on_virtual_key_input(virtual_key_name, button_state, vk_operation)


func on_handled_input(event):
	# ［まだ準備ができていません］
	if self.monkey().owner_node().current_state == &"NotReadyYet":
		pass

	# ［キー・コンフィグで］状態
	elif self.monkey().owner_node().current_state == &"InKeyConfig":
		# キーコンフィグで必要です
		self.monkey().key_config_node().on_unhandled_input(event)

	# ［シナリオで］状態
	elif self.monkey().owner_node().current_state == &"InScenario":
		self.monkey().scenario_player().input_node().on_unhandled_input(event)


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
		self.monkey().scenario_player().input_node().on_unhandled_key_input(event)
