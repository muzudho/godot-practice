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


# ーーーーーーーー
# イベント・ハンドラー
# ーーーーーーーー

# キー・コンフィグ開始時
func on_key_config_entered():
	print("［キーコンフィグ］　開始")
	
	# 背景表示
	self.monkey().of_staff().illustrator_node().visible = true
	self.monkey().of_staff().programmer().owner_node().images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = true


# キー・コンフィグ終了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景消去
	self.monkey().of_staff().programmer().owner_node().images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = false
