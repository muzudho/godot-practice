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

func on_key_config_entered():
	# 背景
	self.monkey().owner_node().images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = true


func on_key_config_exited():
	self.monkey().owner_node().current_state = &"Ready"


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	self.monkey().scenario_player().input_node().on_unhandled_key_input(event)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):
	self.monkey().scenario_player().input_node().on_unhandled_input(event)
