# 🪑grayscale_🎬key_config_driver
#	キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# 背景職人取得
func get_background_artist():
	return $"BackgroundArtist/🎬key_config_🍉bg"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"TelopCoordinator"


# 背景職人取得
func get_gui_artist():
	return $"GuiArtist"


# Called when the node enters the scene tree for the first time.
func _ready():
	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# テロップ・コーディネーター表示
	self.get_telop_coordinator().show()

	# ーーーーーーーー
	# 初期化
	# ーーーーーーーー
	$"🎬key_config_🍉director".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キーコンフィグで必要です
	$"🎬key_config_🍉director".on_process(delta)


func _unhandled_input(event):
	# キーコンフィグで必要です
	$"🎬key_config_🍉director".on_unhandled_input(event)


# キーコンフィグ開始時
func on_key_config_entered():
	# 背景
	self.get_background_artist().visible = true
	self.get_background_artist().get_node("🗻崎川駅前").visible = true


# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.get_background_artist().get_node("🗻崎川駅前").visible = false
