# 🪑grayscale_🎬key_config_driver
#	キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# 背景職人取得
func get_background_artist():
	return $"BackgroundArtist"


# 背景職人取得
func get_gui_artist():
	return $"GuiArtist"


# Called when the node enters the scene tree for the first time.
func _ready():
	# ーーーーーーーー
	# キーコンフィグ
	# ーーーーーーーー
	#
	# 背景
	self.get_background_artist().visible = true
	self.get_background_artist().get_node("🗻崎川駅前").visible = true
	#
	# 開始
	$"Director_KeyConfig".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キーコンフィグで必要です
	$"Director_KeyConfig".on_process(delta)


func _unhandled_input(event):
	# キーコンフィグで必要です
	$"Director_KeyConfig".on_unhandled_input(event)


# キーコンフィグ完了時に呼出されます
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.get_background_artist().get_node("🗻崎川駅前").visible = false
