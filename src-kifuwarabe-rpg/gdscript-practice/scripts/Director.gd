# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# 台本の再生の開始の合図
	$"./AssistantDirector".play_paragraph("タイトル画面")
