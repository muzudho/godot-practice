# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


var DepartmentSnapshot = load("res://scripts/department_snapshot.gd")


# 現在の部門
var current_department = null
# 現在鳴っている背景音楽のノード名
var current_bgm_name = null
# 現在鳴っている効果音のノード名
var current_se_name = null
# スナップショット辞書
var snapshots = {}
# 命令の実引数の辞書
var instruction_arguments = {}
# 疑似的なスリープに使うカウント
var sleep_seconds = 0.0


# アシスタント・ディレクター取得
func get_assistant_director():
	return $"AssistantDirector"


# 主シナリオ取得
func get_main_scenario():
	return $"ScenarioWriter/Main"


# スナップショット
func get_snapshot(department_name):
	return self.snapshots[department_name]


func get_current_snapshot():
	return self.get_snapshot(self.current_department)


# メッセージ・ウィンドウ（現在、出力の対象になっているもの）
func get_message_window(node_name_obj):
	print("［ディレクター］　メッセージ・ウィンドウ名：［" + str(node_name_obj) + "］")
	return $"GuiArtist/WindowsOfMessage".get_node(str(node_name_obj))


# メッセージ・ウィンドウ（現在、出力の対象になっているもの）
func get_current_message_window():
	var snapshot = self.get_current_snapshot()
	var name_str = str(snapshot.message_window_name_obj_stack[-1])
	print("［ディレクター］　メッセージ・ウィンドウ名：［" + name_str + "］")
	return self.get_message_window(name_str)


# 現在の「§」セクション設定
func set_current_section(section_name):
	var snapshot = self.get_current_snapshot()
	snapshot.section_name = section_name
	snapshot.section_item_index = 0


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# 子要素にメンバーを渡す
	# スナップショット辞書作成
	for department in $"ScenarioWriter".get_children():
		# Main は覗く
		if department.name != "Main":
			self.snapshots[department.name] = DepartmentSnapshot.new()
			# （めんどくさいけど）Main シナリオからプロパティを移す
			var department_initial_properties = self.get_main_scenario().department_initial_properties[department.name]
			self.snapshots[department.name].name = department.name		# StringName 型
			self.snapshots[department.name].message_window_name_obj_stack.push_back(department_initial_properties["message_window_name_obj"])
			self.snapshots[department.name].section_name = department_initial_properties["section_name"]

	# 開発中にいじったものが残ってるかもしれないから、掃除
	#
	# ディレクターは表示する必要がある
	self.show()
	# ＧＵＩアーティスト自身は表示する必要がある
	$"GuiArtist".show()
	# モンスター・トレーナー
	$"MonsterTrainer".show()
	$"MonsterTrainer/Faces".show()
	$"MonsterTrainer/WholeBody".show()
	
	# グリッドは隠す
	$"Grid".hide()

	# 背景画像は全部隠す
	for sprite2d_node in $"BackgroundArtist".get_children():
		sprite2d_node.hide()

	# ウィンドウはとにかく隠す
	#
	#	親ノードは例外
	$"GuiArtist/WindowsOfMessage".show()
	#	メッセージ・ウィンドウはとにかく隠す
	for message_window in $"GuiArtist/WindowsOfMessage".get_children():
		message_window.hide()
	#
	#	ビューイング・ウィンドウはとにかく隠す
	for sprite2d_node in $"GuiArtist/WindowsOfViewing".get_children():
		sprite2d_node.hide()
	$"GuiArtist/WindowsOfViewing/System/Frame".hide()
	#
	#	テロップはとにかく非表示にする
	for canvas_layer in $"TelopCoordinator".get_children():
		canvas_layer.hide()
	#
	#	モンスターは、フォルダ―以外は　とにかく非表示にする
	for monster in $"MonsterTrainer/Faces".get_children():
		monster.hide()
	for monster in $"MonsterTrainer/WholeBody".get_children():
		monster.hide()

	#

	# 最初に実行する部門
	self.current_department = self.get_main_scenario().start_department

	var snapshot = self.get_current_snapshot()

	# パースするな
	snapshot.set_parse_lock(true)

	# 台本の「§」セクションの再生
	$"./AssistantDirector".play_section()

	# メッセージ・ウィンドウを、一時的に居なくなっていたのを解除する
	self.get_current_message_window().set_appear_subtree(true)


# テキストボックスなどにフォーカスが無いときの入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# 何かキーを押したとき
	if event.is_pressed():

		# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
		if self.current_department in self.get_main_scenario().key_pressed_stage_directions:
			
			# その要素を取得
			var key_pressed_stage_directions_1 = self.get_main_scenario().key_pressed_stage_directions[self.current_department]
			
			# 押したキーに紐づく、ト書きは辞書に記載されているか？
			if event.keycode in key_pressed_stage_directions_1:
				
				# そのト書き
				var stage_directions = key_pressed_stage_directions_1[event.keycode]

				print("［ディレクター］　アンハンドルド・キー押下　部門変更")

				# TODO ここで stage_directions をト書きとして実行したいが、できるか？
				self.get_assistant_director().parse_section_item(stage_directions)

				# 子要素には渡しません
				return

		print("［ディレクター］　アンハンドルド・キー押下　その他のキー")

		#	子要素へ渡す
		self.get_current_message_window().on_unhandled_key_input(event)

	else:
		print("［ディレクター］　アンハンドルド・キー　押下以外")
