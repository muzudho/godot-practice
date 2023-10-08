# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():

	# 開発中にいじったものが残ってるかもしれないから、掃除

	# グリッドは隠す
	$"Grid".hide()
	
	# 背景画像は全部隠す
	for sprite2d_node in $"Background".get_children():
		sprite2d_node.hide()

	# ウィンドウはとにかく隠す
	for sprite2d_node in $"Windows/メッセージ".get_children():
		sprite2d_node.hide()

	# ビューイング・ウィンドウはとにかく隠す
	for sprite2d_node in $"Windows/ビューイング".get_children():
		sprite2d_node.hide()
	$"Windows/ビューイング/System/Frame".hide()

	# シーンはとにかく非表示にする
	for canvas_layer in $"Scenes".get_children():
		canvas_layer.hide()


	# 台本の再生の開始の合図
	$"./AssistantDirector".play_paragraph("タイトル画面")
