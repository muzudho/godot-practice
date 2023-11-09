# 🪑grayscale_🎬key_config_driver
#	キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# キーコンフィグを始めます
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
