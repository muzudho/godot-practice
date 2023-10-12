#	ディレクター（Director；監督）
#		とりあえず、ゲーム全体をコントロールする
extends Node2D


# 状態遷移機械
var statemachine = load("res://scripts/statemachines/Director.gd").new()


#	部管理人
func get_department_manager(node_name):
	return $"System/Managers/".get_node(node_name)


func play_paragraph():
	self.statemachine.play()


func is_playing():
	return self.statemachine.is_playing()


#	サブツリーが全てインスタンス化されたときに呼び出される
#	Called when the node enters the scene tree for the first time.
func _ready():

	#	関数を渡す
	$"AssistantDirector".director_play_paragraph = self.play_paragraph
	$"AssistantDirector".director_is_playing = self.is_playing

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


	#	ビジュアル・ノベル部を表示する
	self.get_department_manager("VisualNovelDepartment").appear()


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
			
			#	ビジュアル・ノベル部
			if self.get_department_manager("VisualNovelDepartment").is_appear:
				#	隠す
				self.get_department_manager("VisualNovelDepartment").disappear()
				
			else:
				#	表示する
				self.get_department_manager("VisualNovelDepartment").appear()
			
			#	システム・メニュー部
			if self.get_department_manager("SystemMenuDepartment").is_appear:
				#	隠す
				self.get_department_manager("SystemMenuDepartment").disappear()
				
			else:
				#	表示する
				self.get_department_manager("SystemMenuDepartment").appear()

			#	［中央］メッセージ・ウィンドウを表示する
			$"AssistantDirector/MWnd".redirect_message_window("中央")

			# $"AssistantDirector/NormalText".put_message("かいはつちゅう")
			$"AssistantDirector/NormalTextChoice".push_message("""\
　・再開
　・終了
""",
				[1,2])

			#	［中央］ビューイング・ウィンドウを表示する
			# $"AssistantDirector/VWnd".show_viewing_window("中央", "将棋盤")

			#	子要素には渡しません
			return

		#	子要素へ渡す
		$"GuiArtist/WindowsOfMessage".on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
