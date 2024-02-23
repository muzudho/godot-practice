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
	var vk_state = self.owner_node().get_key_state(vk_name)
	var vk_process = self.owner_node().get_key_process(vk_name)

	# 仮想キーを押下したという建付け
	self.monkey().of_staff().programmer().scenario_player().input_node().on_virtual_key_input(
			vk_name,
			vk_state,
			vk_process)


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func on_unhandled_key_input(event):
	# ［まだ準備ができていません］
	if self.monkey().owner_node().current_state == &"NotReadyYet":
		pass

	# ［キー・コンフィグで］は、何もするな
	elif self.monkey().owner_node().current_state == &"InKeyConfig":
		pass

	# ［シナリオで］状態
	elif self.monkey().owner_node().current_state == &"InScenario":
		pass


# テキストボックスなどにフォーカスが無いときのキー入力をとにかく拾う
func on_unhandled_input(event):
	# ［キー・コンフィグで］状態
	if self.monkey().owner_node().current_state == &"InKeyConfig":
		# キーコンフィグ用
		self.monkey().key_config_node().on_unhandled_input(event)
