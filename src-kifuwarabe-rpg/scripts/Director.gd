# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


# 現在の部門
var current_department = null


# 主シナリオ
func get_main_scenario():
	return $"ScenarioWriter/Main"


# 部管理人
func get_department_manager(department_name):
	return $"System/Managers/".get_node(department_name)


# スナップショット
func get_snapshot(department_name):
	return $"System/Snapshots".get_node(department_name)


func get_current_snapshot():
	return self.get_snapshot(self.current_department)


# メッセージ・ウィンドウ
func get_message_window():
	var snapshot = self.get_current_snapshot()

	return $"GuiArtist/WindowsOfMessage".get_node(str(snapshot.message_window_name_obj))


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# 子要素にメンバーを渡す
	$"AssistantDirector".set_director_get_current_snapshot_subtree(self.get_current_snapshot)

	# メッセージ・ウィンドウ
	for message_window in $"GuiArtist/WindowsOfMessage".get_children():
		message_window.set_director_get_current_snapshot_subtree(self.get_current_snapshot)


	# 開発中にいじったものが残ってるかもしれないから、掃除
	#
	# ディレクターは表示する必要がある
	self.show()
	# グリッドは隠す
	$"Grid".hide()

	# 背景画像は全部隠す
	for sprite2d_node in $"BackgroundArtist".get_children():
		sprite2d_node.hide()

	# ウィンドウはとにかく隠す
	#
	# メッセージ・ウィンドウはとにかく隠す
	for message_window in $"GuiArtist/WindowsOfMessage".get_children():
		message_window.hide()

	# ビューイング・ウィンドウはとにかく隠す
	for sprite2d_node in $"GuiArtist/WindowsOfViewing".get_children():
		sprite2d_node.hide()
	$"GuiArtist/WindowsOfViewing/System/Frame".hide()

	# シーンはとにかく非表示にする
	for canvas_layer in $"LocationCoordinator".get_children():
		canvas_layer.hide()

	# 最初に実行する部門
	self.current_department = self.get_main_scenario().start_department


	var snapshot = self.get_current_snapshot()

	# パースするな
	snapshot.set_parse_lock(true)

	# 台本の段落の再生
	$"./AssistantDirector".play_paragraph()

	# 表示
	snapshot.get_manager().appear()


# テキストボックスなどにフォーカスが無いときの入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# 何かキーを押したとき
	if event.is_pressed():

		# エスケープ・キー
		if event.keycode == KEY_ESCAPE:

			# 現在の部門を隠す
			self.get_current_snapshot().get_manager().disappear()

			# ビジュアルノベル部　再生中
			if self.current_department == "VisualNovelDepartment":
				print("［ディレクター］　アンハンドルド・キー押下　エスケープ・キー　システム・メニュー部へ遷移")

				# システムメニュー再生
				self.current_department = "SystemMenuDepartment"

			elif self.current_department == "SystemMenuDepartment":
				print("［ディレクター］　アンハンドルド・キー押下　エスケープ・キー　ビジュアルノベル部へ遷移")

				# ビジュアルノベル再生
				self.current_department = "VisualNovelDepartment"

			# 現在の部門を再表示
			self.get_current_snapshot().get_manager().appear()

			# 台本の段落の再生
			$"./AssistantDirector".play_paragraph()

			# 子要素には渡しません
			return

		print("［ディレクター］　アンハンドルド・キー押下　その他のキー")

		#	子要素へ渡す
		self.get_message_window().on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
