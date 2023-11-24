# 🪑grayscale_🎬kifuwarabe_rpg
#	ディレクター（🌏Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D


# 状態。 WaitForKeyConfig, KeyConfig, Ready, Main の４つ
var current_state = &"WaitForKeyConfig"


# 現在鳴っている背景音楽のノード名
var current_bgm_name = null
# 現在鳴っている効果音のノード名
var current_se_name = null

# ト書き（シナリオの命令パラグラフ）で使える変数の辞書
var stage_directions_variables = {}
# 疑似的なスリープに使うカウント
var sleep_seconds = 0.0


# ーーーーーーーー
# 内パス関連
# ーーーーーーーー


func get_grid():
	return $"Grid"


func get_illustrator():
	return $"🌏Illustrator"


func get_key_config_hub():
	return $"🛩️KeyConfigHub"


func get_gui_programmer_message_windows():
	return $"🌏GuiProgrammer_MessageWindows"


# プログラムズ・ハブ取得
func get_programs_hub():
	return $"🌏Programmer/🛩️ProgramsHub"


func get_scenario_writer():
	return $"🌏ScenarioWriter"


# シナリオライターズ・ハブ取得
func get_scenario_writers_hub():
	return $"🌏ScenarioWriter/🛩️ScenarioWritersHub_🍉VisualNovel"


# 部門切替取得
func get_switch_department():
	return self.get_scenario_writer().get_node("SwitchDepartment")


func get_telop_coordinator():
	return $"🌏TelopCoordinator"


# ーーーーーーーー
# 初期化
# ーーーーーーーー


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# キャッシュを作成するだけ
	var _all_instruction_code = self.get_programs_hub().get_all_instruction_codes()

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	#
	# 開発中にいじったものが残ってるかもしれないから、掃除
	
	# グリッドは隠す
	self.get_grid().hide()

	# 伝言窓はとにかく隠す
	for child_node in self.get_illustrator().get_children():
		# `■` で始まる名前のノードを、メッセージ・ウィンドウの名前とします
		if child_node.name.begins_with("■"):
			child_node.hide()
	
	# イラストレーターはとにかく隠す
	for child_node in self.get_illustrator().get_children():
		if child_node is Sprite2D:
			child_node.hide()
	
	# テロップはとにかく非表示にする
	for canvas_layer in self.get_telop_coordinator().get_children():
		if canvas_layer is CanvasLayer:
			canvas_layer.hide()

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	
	# 監督自身
	self.show()
	# イラストレーター
	self.get_illustrator().show()
	# テロップ
	self.get_telop_coordinator().show()


# ーーーーーーーー
# その他
# ーーーーーーーー


func on_key_config_entered():
	# 背景
	self.get_programs_hub().images.find_node("🗻崎川駅前").visible = true


func on_key_config_exited():
	self.current_state = &"Ready"


func _process(delta):

	if self.current_state == &"WaitForKeyConfig":
		self.get_key_config_hub().entry()
		self.current_state = &"KeyConfig"

	elif self.current_state == &"KeyConfig":
		self.get_key_config_hub().on_process(delta)

	elif self.current_state == &"Ready":
		self.current_state = &"Main"
		# ーーーーーーーー
		# 準備
		# ーーーーーーーー

		# 最初に実行する部門名
		self.get_programs_hub().current_department_name = self.get_switch_department().start_department_name

		# パースするな
		self.get_programs_hub().get_current_department_value().set_parse_lock(true)

		# 台本の「§」セクションの再生
		self.get_programs_hub().play_section()

		# 伝言窓を、一時的に居なくなっていたのを解除する
		self.get_programs_hub().get_current_message_window_gui().set_appear_subtree(true)

	elif self.current_state == &"Main":
		self.get_programs_hub().on_process(delta)


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
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
		var virtual_key_name = null
		
		# エンターキー押下
		if event.keycode == KEY_ENTER:
			virtual_key_name = &"VK_Ok"

		# エスケープキー押下
		elif event.keycode == KEY_ESCAPE:
			virtual_key_name = &"VK_Cancel"

		# ［Ｒ］キー押下（後でスーパーファミコンの R キーにしようと思っていたアルファベット）
		elif event.keycode == KEY_R:
			virtual_key_name = &"VK_FastForward"
		
		# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
		else:
			return

		var lever_value = 0.0

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):

	if self.current_state == &"WaitForKeyConfig":
		pass

	elif self.current_state == &"KeyConfig":
		self.get_key_config_hub().on_unhandled_input(event)

	elif self.current_state == &"Main":

		var vk_operation = null

		# 何かキーを押したとき
		if event.is_pressed():
			#print("［監督］　入力　押下")
			vk_operation = &"VKO_Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			#print("［監督］　入力　リリース")
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
		var button_number = self.get_key_config_hub().get_button_number_by_text(event_as_text)
		
		# ボタン番号を、仮想キー名に変換
		var virtual_key_name = self.get_key_config_hub().get_virtual_key_name_by_button_number(button_number)

		# レバー値
		var lever_value = self.get_key_config_hub().get_lever_value_by_text(event_as_text)

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# 仮想キーを押下したという建付け
func on_virtual_key_input(virtual_key, lever_value, vk_operation):
	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if vk_operation == &"VKO_Pressed" and str(self.get_programs_hub().current_department_name) in self.get_switch_department().key_pressed_stage_directions:
		
		# その要素を取得
		var key_pressed_stage_directions_1 = self.get_switch_department().key_pressed_stage_directions[str(self.get_programs_hub().current_department_name)]
		
		# 押したキーに紐づく、ト書きは辞書に記載されているか？
		if virtual_key in key_pressed_stage_directions_1:
			
			# そのト書き
			var stage_directions = key_pressed_stage_directions_1[virtual_key]

			print("［監督］　アンハンドルド・キー押下　部門変更")

			# TODO ここで stage_directions をト書きとして実行したいが、できるか？
			self.get_programs_hub().parse_paragraph(stage_directions)

			# 子要素には渡しません
			return

	print("［監督］　仮想キー（" + virtual_key + "）　レバー値：" + str(lever_value) + "　操作：" + vk_operation)

	# メッセージ・ウィンドウへ渡す
	self.get_programs_hub().get_current_message_window_gui().on_virtual_key_input(virtual_key, lever_value, vk_operation)
