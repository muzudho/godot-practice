# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# 開発中にいじったものが残ってるかもしれないから、掃除

	# グリッドは隠す
	$"Grid".hide()

	# 背景画像は全部隠す
	for sprite2d_node in $"BackgroundArtist".get_children():
		sprite2d_node.hide()

	# ウィンドウはとにかく隠す
	#
	# メッセージ・ウィンドウはとにかく隠す
	for sprite2d_node in $"Windows/Message".get_children():
		sprite2d_node.hide()

	# ビューイング・ウィンドウはとにかく隠す
	for sprite2d_node in $"Windows/ビューイング".get_children():
		sprite2d_node.hide()
	$"Windows/ビューイング/System/Frame".hide()

	# シーンはとにかく非表示にする
	for canvas_layer in $"LocationCoordinator".get_children():
		canvas_layer.hide()


	# 台本の再生の開始の合図
	$"./AssistantDirector".play_paragraph("タイトル画面")


#	テキストボックスなどにフォーカスが無いときの入力を拾う
#
#		子要素から親要素の順で呼び出されるようだ。
#		このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):
	print("［ディレクター］　アンハンドルド・キー入力")

	#	何かキーを押したとき
	if event.is_pressed():
		
		#	エスケープ・キー
		if event.keycode == KEY_ESCAPE:
			print("［ディレクター］　エスケープ・キーが押された")
			
			if not get_tree().paused:
				# 全体を止める
				get_tree().paused = true
			else:
				# 全体を止めているのを解除
				get_tree().paused = false
			
			#	子要素には渡しません
			return

		#	子要素へ渡す
		$"Windows/Message".on_unhandled_key_input(event)
