# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


var DepartmentSnapshot = load("res://scripts/department_snapshot.gd")


# 現在の部門
var current_department = null

# スナップショット辞書
var snapshots = {}

# 主シナリオ
func get_main_scenario():
	return $"ScenarioWriter/Main"


# 部門管理人
func get_department_manager():
	return $"System/DepartmentManager"


# スナップショット
func get_snapshot(department_name):
	return self.snapshots[department_name]


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
	# 	メッセージ・ウィンドウ
	for child in $"GuiArtist/WindowsOfMessage".get_children():
		if child is Sprite2D:
			child.set_director_get_current_snapshot_subtree(self.get_current_snapshot)

	# スナップショット辞書作成
	for department in $"ScenarioWriter".get_children():
		# Main は覗く
		if department.name != "Main":
			self.snapshots[department.name] = DepartmentSnapshot.new()
			# （めんどくさいけど）Main シナリオからプロパティを移す
			var department_initial_properties = self.get_main_scenario().department_initial_properties[department.name]
			self.snapshots[department.name].name = department.name		# StringName 型
			self.snapshots[department.name].message_window_name_obj = department_initial_properties["message_window_name_obj"]
			self.snapshots[department.name].paragraph_name = department_initial_properties["paragraph_name"]

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
	self.get_department_manager().appear()


# テキストボックスなどにフォーカスが無いときの入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# 何かキーを押したとき
	if event.is_pressed():

		if self.current_department in self.get_main_scenario().key_pressed_mappings:
			var key_pressed_mappings_1 = self.get_main_scenario().key_pressed_mappings[self.current_department]
			if event.keycode in key_pressed_mappings_1:
				var next_department = key_pressed_mappings_1[event.keycode]
				
				print("［ディレクター］　アンハンドルド・キー押下　部門変更")

				$"AssistantDirector/Department".change_department(next_department)

				# 子要素には渡しません
				return

		print("［ディレクター］　アンハンドルド・キー押下　その他のキー")

		#	子要素へ渡す
		self.get_message_window().on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
