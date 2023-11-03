# 🪑grayscale_🎬kifuwarabe_rpg
#	ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


var DepartmentSnapshot = load("res://🪑grayscale_🎬kifuwarabe_rpg/scripts/department_snapshot.gd")


# 状態。 WaitForKeyConfig, KeyConfig, Ready, Main の４つ
var current_state = &"WaitForKeyConfig"


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

# メッセージの早送り
var is_fast_forward = false

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
	if snapshot.stack_of_last_displayed_message_window.size() < 1:
		print("［監督］　▲！　最後に表示したメッセージウィンドウが無い")

	var node_name = snapshot.stack_of_last_displayed_message_window[-1]
	print("［監督］　伝言窓名：［" + node_name + "］")
	return self.get_message_window(str(node_name))


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

	# ーーーーーーーー
	# 初期化を行う
	# ーーーーーーーー

	# スナップショット辞書作成
	for department_name in self.get_all_department_names():
		var department_node = $"ScenarioWriter".get_node(str(department_name))
		if department_node.name != "SwitchDepartment" and department_node.name != "System":
			self.snapshots[department_node.name] = DepartmentSnapshot.new()

			# （めんどくさいけど） SwitchDepartment からプロパティを移す
			self.snapshots[department_node.name].name = department_node.name		# StringName 型

			# TODO この初期化は必要か？
			# メッセージを出力する対象となるウィンドウの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
			if department_node.name =="📗ビジュアルノベル部門":
				self.snapshots[department_node.name].stack_of_last_displayed_message_window.push_back(&"■下")	# StringName 型 シンタックス・シュガー
			elif department_node.name =="📗システムメニュー部門":
				self.snapshots[department_node.name].stack_of_last_displayed_message_window.push_back(&"■中央")	# StringName 型 シンタックス・シュガー
				#self.snapshots[department_node.name].stack_of_last_displayed_message_window.push_back(&"■左下")	# StringName 型 シンタックス・シュガー
			elif department_node.name =="📗バトル部門":
				self.snapshots[department_node.name].stack_of_last_displayed_message_window.push_back(&"■下")	# StringName 型 シンタックス・シュガー


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


func on_key_config_exited():
	self.current_state = &"Ready"


func _process(delta):

	if self.current_state == &"WaitForKeyConfig":
		$"DirectorForKeyConfig".entry()
		self.current_state = &"KeyConfig"

	elif self.current_state == &"KeyConfig":
		$"DirectorForKeyConfig".on_process(delta)

	elif self.current_state == &"Ready":
		self.current_state = &"Main"
		# ーーーーーーーー
		# 準備
		# ーーーーーーーー

		# 最初に実行する部門名
		self.current_department_name = self.get_switch_department().start_department_name

		var snapshot = self.get_current_snapshot()

		# パースするな
		snapshot.set_parse_lock(true)

		# 台本の「§」セクションの再生
		$"./AssistantDirector".play_section()

		# 伝言窓を、一時的に居なくなっていたのを解除する
		self.get_current_message_window().set_appear_subtree(true)

	elif self.current_state == &"Main":
		self.get_assistant_director().on_process(delta)


# テキストボックスなどにフォーカスが無いときの入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	if self.current_state == &"WaitForKeyConfig":
		pass

	elif self.current_state == &"KeyConfig":
		pass

	elif self.current_state == &"Main":

		var vk_operation = null

		# 何かキーを押したとき
		if event.is_pressed():
			print("［監督］　キー入力　押下")
			vk_operation = &"VKO_Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			print("［監督］　キー入力　リリース")
			vk_operation = &"VKO_Released"
		
		# それ以外には対応してない
		else:
			print("［監督］　キー入力　▲！想定外")
			return

		# 以下、仮想キー

		# このゲーム独自の仮想キーに変換
		var virtual_key = null
		
		# エンターキー押下
		if event.keycode == KEY_ENTER:
			virtual_key = &"VK_Ok"

		# エスケープキー押下
		elif event.keycode == KEY_ESCAPE:
			virtual_key = &"VK_Cancel"

		# ［Ｒ］キー押下（後でスーパーファミコンの R キーにしようと思っていたアルファベット）
		elif event.keycode == KEY_R:
			virtual_key = &"VK_FastForward"
		
		# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
		else:
			return

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key, vk_operation)


# ボタン番号を、仮想キー名に変換。該当がなければ空文字列
func get_virtual_key_name_by_button_number(button_number):
	for key in $"DirectorForKeyConfig".key_config.keys():
		var value = $"DirectorForKeyConfig".key_config[key]
		if button_number == value:
			return key
	return &""


func _unhandled_input(event):

	if self.current_state == &"WaitForKeyConfig":
		pass

	elif self.current_state == &"KeyConfig":
		$"DirectorForKeyConfig".on_unhandled_input(event)

	elif self.current_state == &"Main":

		var vk_operation = null

		# 何かキーを押したとき
		if event.is_pressed():
			print("［監督］　入力　押下")
			vk_operation = &"VKO_Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			print("［監督］　入力　リリース")
			vk_operation = &"VKO_Released"
		
		# それ以外には対応してない
		else:
			print("［監督］　入力　▲！想定外")
			return

		# ーーーーーーーー
		# 以下、仮想キー
		# ーーーーーーーー
		# 文字列だけだと、押したのか放したのか分からない
		var event_as_text = event.as_text()
		
		# 文字列をボタン番号に変換
		var button_number = $"DirectorForKeyConfig".get_button_number_by_text(event_as_text)
		
		# ボタン番号を、仮想キー名に変換
		var virtual_key_name = self.get_virtual_key_name_by_button_number(button_number)
		
		# オーケー相当のボタン押下
		#if event_as_text == &"Joypad Button 0 (Bottom Action, Sony Cross, Xbox A, Nintendo B)":
		#	virtual_key = &"VK_Ok"

		# スタートボタン押下
		#elif event_as_text == &"Joypad Button 4 (Back, Sony Select, Xbox Back, Nintendo -)":
		#	virtual_key = &"VK_Cancel"
		
		# PC-Engine のゲームパッドでは、ページ早送りの機能を持たせるボタンが足りない。キーボードを併用してもらうこと
		
		# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
		#else:
		#	return

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, vk_operation)


# 仮想キーを押下したという建付け
func on_virtual_key_input(virtual_key, vk_operation):
	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if vk_operation == &"VKO_Pressed" and str(self.current_department_name) in self.get_switch_department().key_pressed_stage_directions:
		
		# その要素を取得
		var key_pressed_stage_directions_1 = self.get_switch_department().key_pressed_stage_directions[str(self.current_department_name)]
		
		# 押したキーに紐づく、ト書きは辞書に記載されているか？
		if virtual_key in key_pressed_stage_directions_1:
			
			# そのト書き
			var stage_directions = key_pressed_stage_directions_1[virtual_key]

			print("［監督］　アンハンドルド・キー押下　部門変更")

			# TODO ここで stage_directions をト書きとして実行したいが、できるか？
			self.get_assistant_director().parse_paragraph(stage_directions)

			# 子要素には渡しません
			return

	print("［監督］　アンハンドルド・キー押下　その他のキー（" + virtual_key + "）")

	#	子要素へ渡す
	self.get_current_message_window().on_unhandled_virtual_key_input(virtual_key, vk_operation)
