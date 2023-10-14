#	ディレクター（Director；監督）
#		とりあえず、ゲーム全体をコントロールする
extends Node2D


# 状態機械
var statemachine_of_director = load("res://scripts/statemachines/director.gd").new()


func play_visual_novel():
	self.statemachine_of_director.play_visual_novel()


func is_playing_visual_novel():
	return self.statemachine_of_director.is_playing_visual_novel()


func play_system_menu():
	self.statemachine_of_director.play_system_menu()


func is_playing_system_menu():
	return self.statemachine_of_director.is_playing_system_menu()


#	部管理人
func get_department_manager(department_name):
	return $"System/Managers/".get_node(department_name)


#	スナップショット
func get_snapshot(department_name):
	return $"System/Snapshots".get_node(department_name)


#	メッセージ・ウィンドウ
func get_message_window():
	# TODO ちゃんと作る必要がある
	var message_window_name_obj = $"System/Snapshots/VisualNovelDepartment".message_window_name_obj
	return $"GuiArtist/WindowsOfMessage".get_node(str(message_window_name_obj))


#	サブツリーが全てインスタンス化されたときに呼び出される
#	Called when the node enters the scene tree for the first time.
func _ready():

	#	関数を渡す
	$"AssistantDirector".director_play_visual_novel = self.play_visual_novel
	$"AssistantDirector".director_is_playing_visual_novel = self.is_playing_visual_novel

	$"AssistantDirector".director_play_system_menu = self.play_system_menu
	$"AssistantDirector".director_is_playing_system_menu = self.is_playing_system_menu

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
	$"./AssistantDirector".play_visual_novel("タイトル画面")


#	テキストボックスなどにフォーカスが無いときの入力を拾う
#
#		子要素から親要素の順で呼び出されるようだ。
#		このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	#	何かキーを押したとき
	if event.is_pressed():
		
		#	エスケープ・キー
		if event.keycode == KEY_ESCAPE:

			#	ビジュアルノベル部　再生中
			if self.statemachine_of_director.is_playing_visual_novel_department():
				print("［ディレクター］　アンハンドルド・キー押下　エスケープ・キー　システム・メニュー部へ遷移")
				
				#	ビジュアル・ノベル部を隠す
				self.get_department_manager("VisualNovelDepartment").disappear()
				#	システム・メニュー部を表示する
				self.get_department_manager("SystemMenuDepartment").appear()

				#	［中央］メッセージ・ウィンドウを表示する
				$"AssistantDirector/MWnd".redirect_message_window("中央")
				$"AssistantDirector/NormalTextChoice".push_message(&"中央", """\
　・再開
　・終了
""",
				[1,2])

				#	システム・メニュー部へ状態遷移
				self.statemachine_of_director.play_system_menu_department()

			else:
				print("［ディレクター］　アンハンドルド・キー押下　エスケープ・キー　ビジュアルノベル部へ遷移")
				
				#	システム・メニュー部を隠す
				self.get_department_manager("SystemMenuDepartment").disappear()
				#	ビジュアルノベル部を表示する
				self.get_department_manager("VisualNovelDepartment").appear()

				#	［下］メッセージ・ウィンドウを表示する
				$"AssistantDirector/MWnd".redirect_message_window("下")
				
				#	TODO 元のメッセージを復元する
				var snapshot = self.get_snapshot("VisualNovelDepartment")
				
				$"AssistantDirector/NormalText".put_message("かいはつちゅう")

				#	ビジュアルノベル再生
				self.statemachine_of_director.play_visual_novel()


			#	子要素には渡しません
			return

		print("［ディレクター］　アンハンドルド・キー押下　その他のキー")

		#	子要素へ渡す
		self.get_message_window().on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
