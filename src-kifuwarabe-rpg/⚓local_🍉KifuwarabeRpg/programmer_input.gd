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
func _unhandled_key_input(event):
	# キー・コンフィグのために、何もするな
	if self.monkey().owner_node().current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグ中なので、何もするな
	elif self.monkey().owner_node().current_state == &"KeyConfig":
		pass

	# 主要な状態
	elif self.monkey().owner_node().current_state == &"Main":
		self.monkey().scenario_player().input_node().on_unhandled_key_input(event)

# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):
	# キー・コンフィグのために何もするな、という状態
	if self.monkey().owner_node().current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグに入力の制御を譲れ、という状態
	elif self.monkey().owner_node().current_state == &"KeyConfig":
		self.monkey().key_config_node().on_unhandled_input(event)

	# 主な状態
	elif self.monkey().owner_node().current_state == &"Main":
		self.monkey().scenario_player().input_node().on_unhandled_input(event)
