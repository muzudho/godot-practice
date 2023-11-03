# ディレクター（Director）
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# キー・コンフィグ画面を始める
	$"KeyConfigArtist".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キー・コンフィグで必要
	$"KeyConfigArtist".on_process(delta)


func _unhandled_input(event):
	# キー・コンフィグで必要
	$"KeyConfigArtist".on_unhandled_input(event)
