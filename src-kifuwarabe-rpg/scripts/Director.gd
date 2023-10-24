# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


var DepartmentSnapshot = load("res://scripts/department_snapshot.gd")


# 現在の部門（StringName型）
var current_department_name = null
# 現在鳴っている背景音楽のノード名
var current_bgm_name = null
# 現在鳴っている効果音のノード名
var current_se_name = null
# スナップショット辞書（キー：StringName型）
var snapshots = {}
# ト書き（シナリオの命令パラグラフ）で使える変数の辞書
var stage_directions_variables = {}
# 疑似的なスリープに使うカウント
var sleep_seconds = 0.0


# 助監取得
func get_assistant_director():
	return $"AssistantDirector"


# 部門切替取得
func get_switch_department():
	return $"ScenarioWriter/SwitchDepartment"


# スナップショット
func get_snapshot(
	department_name):	# StringName
	return self.snapshots[department_name]


func get_current_snapshot():
	return self.get_snapshot(self.current_department_name)


# 伝言窓（現在、出力の対象になっているもの）
func get_message_window(node_name_obj):
	print("［監督］　伝言窓名：［" + str(node_name_obj) + "］")
	return $"GuiArtist/WindowsOfMessage".get_node(str(node_name_obj))


# 伝言窓（現在、出力の対象になっているもの）
func get_current_message_window():
	var snapshot = self.get_current_snapshot()
	var name_str = str(snapshot.message_window_name_obj_stack[-1])
	print("［監督］　伝言窓名：［" + name_str + "］")
	return self.get_message_window(name_str)


# 現在の「§」セクション設定
func set_current_section(section_name):
	var snapshot = self.get_current_snapshot()
	snapshot.section_name = section_name
	snapshot.section_item_index = 0


# 全ての部門名一覧
func get_all_department_names():
	var array = []	# StringName の配列
	
	for department in $"ScenarioWriter".get_children():
		# SwitchDepartment と System は除く
		if department.name != "SwitchDepartment" and department.name != "System":
			array.append(department.name)

	return array


# 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
func dump_last_displayed_message_window():
	print("［監督］　各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示")
	
	# 部門名一覧
	var department_names = self.get_all_department_names()
	for department_name in 	department_names:
		print("　　部門：　" + department_name)

		# スナップショット
		var snapshot = self.get_snapshot(department_name)
		
		for window_name in snapshot.node_names_of_currently_displayed_message_window:
			print("　　　　👁 " + window_name)


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# スナップショット辞書作成
	for department_name in self.get_all_department_names():
		var department_node = $"ScenarioWriter".get_node(str(department_name))
		if department_node.name != "SwitchDepartment" and department_node.name != "System":
			self.snapshots[department_node.name] = DepartmentSnapshot.new()

			# （めんどくさいけど） SwitchDepartment からプロパティを移す
			self.snapshots[department_node.name].name = department_node.name		# StringName 型
			
			# メッセージを出力する対象となるウィンドウの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
			if department_node.name =="📗ビジュアルノベル部門":
				self.snapshots[department_node.name].message_window_name_obj_stack.push_back(&"■下")	# StringName 型 シンタックス・シュガー
			elif department_node.name =="📗システムメニュー部門":
				self.snapshots[department_node.name].message_window_name_obj_stack.push_back(&"■中央")	# StringName 型 シンタックス・シュガー
				#self.snapshots[department_node.name].message_window_name_obj_stack.push_back(&"■左下")	# StringName 型 シンタックス・シュガー
			elif department_node.name =="📗バトル部門":
				self.snapshots[department_node.name].message_window_name_obj_stack.push_back(&"■下")	# StringName 型 シンタックス・シュガー


			# 文書辞書の先頭要素のキー取得
			self.snapshots[department_node.name].section_name = $"ScenarioWriter".get_node(str(department_node.name)).document.keys()[0]

	# 開発中にいじったものが残ってるかもしれないから、掃除
	#
	# 監督は表示する必要がある
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
	#	伝言窓はとにかく隠す
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

	# 最初に実行する部門名
	self.current_department_name = self.get_switch_department().start_department_name

	var snapshot = self.get_current_snapshot()

	# パースするな
	snapshot.set_parse_lock(true)

	# 台本の「§」セクションの再生
	$"./AssistantDirector".play_section()

	# 伝言窓を、一時的に居なくなっていたのを解除する
	self.get_current_message_window().set_appear_subtree(true)


# テキストボックスなどにフォーカスが無いときの入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# 何かキーを押したとき
	if event.is_pressed():

		# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
		if str(self.current_department_name) in self.get_switch_department().key_pressed_stage_directions:
			
			# その要素を取得
			var key_pressed_stage_directions_1 = self.get_switch_department().key_pressed_stage_directions[str(self.current_department_name)]
			
			# 押したキーに紐づく、ト書きは辞書に記載されているか？
			if event.keycode in key_pressed_stage_directions_1:
				
				# そのト書き
				var stage_directions = key_pressed_stage_directions_1[event.keycode]

				print("［監督］　アンハンドルド・キー押下　部門変更")

				# TODO ここで stage_directions をト書きとして実行したいが、できるか？
				self.get_assistant_director().parse_paragraph(stage_directions)

				# 子要素には渡しません
				return

		print("［監督］　アンハンドルド・キー押下　その他のキー")

		#	子要素へ渡す
		self.get_current_message_window().on_unhandled_key_input(event)

	else:
		print("［監督］　アンハンドルド・キー　押下以外")
