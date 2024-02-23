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

# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):
	# キーコンフィグで必要です
	self.monkey().key_config_node().on_unhandled_input(event)
