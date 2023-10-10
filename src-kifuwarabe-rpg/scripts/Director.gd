#	ディレクター（Director；監督）
#		とりあえず、ゲーム全体をコントロールする
extends Node2D


#	サブツリーが全てインスタンス化されたときに呼び出される
#	Called when the node enters the scene tree for the first time.
func _ready():

	#	開発中にいじったものが残ってるかもしれないから、掃除

	#	グリッドは隠す
	$"Grid".hide()

	#	背景画像は全部隠す
	for sprite2d_node in $"BackgroundArtist".get_children():
		sprite2d_node.hide()

	#	ウィンドウはとにかく隠す
	#
	#	メッセージ・ウィンドウはとにかく隠す
	for sprite2d_node in $"GuiArtist/WindowsOfMessage".get_children():
		sprite2d_node.hide()

	#	ビューイング・ウィンドウはとにかく隠す
	for sprite2d_node in $"GuiArtist/WindowsOfViewing".get_children():
		sprite2d_node.hide()
	$"GuiArtist/WindowsOfViewing/System/Frame".hide()

	#	シーンはとにかく非表示にする
	for canvas_layer in $"LocationCoordinator".get_children():
		canvas_layer.hide()


	#	メッセージ・ウィンドウの is_processing() で false が返ってくるので、 true を入れてやる
	#	ポーズ・ボタンを押したとき、最初の状態が　is_processing() == false なので　ポーズが空振りするので
	#	仕方なく入れた処理
	if not $"GuiArtist/WindowsOfMessage".is_processing():
		print("［ディレクター］　メッセージ・ウィンドウの is_processing() で false が返ってくるので、 true を入れてやる")
		$"GuiArtist/WindowsOfMessage".set_process(true)


	#	台本の再生の開始の合図
	$"./AssistantDirector".play_paragraph("タイトル画面")


#	テキストボックスなどにフォーカスが無いときの入力を拾う
#
#		子要素から親要素の順で呼び出されるようだ。
#		このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	#	何かキーを押したとき
	if event.is_pressed():
		print("［ディレクター］　アンハンドルド・キー　押下")
		
		#	エスケープ・キー
		if event.keycode == KEY_ESCAPE:
			print("［ディレクター］　エスケープ・キーが押された")
			
			#	ポーズ
			#		とりあえず、ウィンドウを止めてみる
			#		is_processing は、初回は false
			if $"GuiArtist/WindowsOfMessage".is_processing():
				print("［ディレクター］　GuiArtist は処理中")
				
				#	停止
				$"GuiArtist/WindowsOfMessage".set_process_subtree(false)
				
			else:
				print("［ディレクター］　GuiArtist は処理中ではない")
				
				#	再開
				$"GuiArtist/WindowsOfMessage".set_process_subtree(true)

			#	表示中の［下］ウィンドウを隠す
			if $"GuiArtist/WindowsOfMessage/下".visible:
				$"GuiArtist/WindowsOfMessage/下".set_visible_subtree(false)

			#	［中央］ウィンドウを表示する
			if $"GuiArtist/WindowsOfMessage/中央".visible:
				$"GuiArtist/WindowsOfMessage/中央".set_visible_subtree(true)

			#	子要素には渡しません
			return

		#	子要素へ渡す
		$"GuiArtist/WindowsOfMessage".on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
