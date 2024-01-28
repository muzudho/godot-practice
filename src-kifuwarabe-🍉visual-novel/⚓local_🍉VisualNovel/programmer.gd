# プログラマー（Programmer）
extends Node


var Department = load("res://🍋scripts/🪑grayscale_🍉visual_novel/department.gd")


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 状態。 WaitForKeyConfig, KeyConfig, Ready, Main の４つ
var current_state = &"WaitForKeyConfig"
# 現在の部門（StringName型）
var current_department_name = null
# 現在鳴っている背景音楽のノード名
var current_bg_music_name = null
# 現在鳴っている効果音のノード名
var current_se_name = null

# 全角数字
var zenkaku_numbers = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]
# デパートメント変数辞書（キー：StringName型）
var departments = {}
# ト書き（シナリオの命令パラグラフ）で使える変数の辞書
var stage_directions_variables = {}
# 疑似的なスリープに使うカウント
var sleep_seconds = 0.0


# ーーーーーーーー
# アドオン・スロット
# ーーーーーーーー

# BGMノードのキャッシュ
var bg_musics = null

# メッセージ・ウィンドウ・プログラムのキャッシュ
var message_window_programs = null

# イラスト・ノードのキャッシュ
var images = null

# サウンド・エフェクト（Sound Effect, Sound FX；効果音）のキャッシュ
var sound_fx = null

# テロップのキャッシュ
var telops = null


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー

func _ready():
	self.bg_musics = MonkeyHand.create(
			self.monkey().of_staff().musician_bg_musics())		# 探す場所

	self.images = MonkeyHand.create(
			self.monkey().of_staff().illustrator_node())			# 探す場所

	self.sound_fx = MonkeyHand.create(
			self.monkey().of_staff().musician_sound_fx())			# 探す場所

	self.telops = MonkeyHand.create(
			self.monkey().of_staff().telop_coordinator())	# 探す場所


	self.message_window_programs = MonkeyHand.create(
			self.monkey().of_staff().gui_programmer_message_windows())			# 探す場所

	
	# メッセージ・ウィンドウに対応関数紐づけ
	MonkeyHelper.search_node_name_begins_with(
			# メッセージ・ウィンドウの名前は `■` で始まるものとする
			&"■",
			# 探す場所
			self.monkey().of_staff().gui_programmer_message_windows(),
			func(child_node):
				# メッセージ・ウィンドウのページ送り時、パーサーのロックを解除
				child_node.on_message_window_page_forward = func():
					self.monkey().scenario_player_node().get_current_department_value().set_parse_lock(false))

	# デパートメント変数辞書作成
	for department_name in self.monkey().get_all_department_names():
		# 生成
		var department_value = Department.new()

		# 部門名をコピー
		department_value.name = department_name		# StringName 型

		# メッセージを出力する対象となるウィンドウの名前。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
		department_value.stack_of_last_displayed_message_window.push_back(&"■FullScreen")	# StringName 型 シンタックス・シュガー

		# 先頭セクションの名前
		department_value.section_name = self.monkey().of_staff().scenario_writer().owner_node().get_merged_scenario_document(department_name).keys()[0]

		self.departments[department_name] = department_value


func ready_in_staff():
	# キャッシュを作成するだけ
	var _all_instruction_code = self.monkey().scenario_player().get_all_instruction_codes()

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	#
	# 開発中にいじったものが残ってるかもしれないから、掃除
	
	# グリッドは隠す
	self.monkey().of_staff().grid_node().hide()
	
	# イラストレーターはとにかく隠す
	MonkeyHelper.search_in_folder(
			self.monkey().of_staff().illustrator_node(),		# 探す場所
			func(child_node):
				return child_node is Sprite2D,
			func(child_node):
				child_node.hide())
	
	# テロップはとにかく非表示にする
	MonkeyHelper.search_in_folder(
			self.monkey().of_staff().telop_coordinator(),		# 探す場所
			func(child_node):
				return child_node is CanvasLayer,
			func(child_node):
				child_node.hide())

	self.monkey().key_config_node().ready_in_staff()

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	
	# 監督自身
	self.monkey().of_staff().owner_node().show()
	# イラストレーター
	self.monkey().of_staff().illustrator_node().show()
	# テロップ
	self.monkey().of_staff().telop_coordinator().show()


# ーーーーーーーー
# 入力
# ーーーーーーーー


func on_key_config_entered():
	# 背景
	self.images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = true


func on_key_config_exited():
	self.current_state = &"Ready"


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# キー・コンフィグのために、何もするな
	if self.current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグ中なので、何もするな
	elif self.current_state == &"KeyConfig":
		pass

	# 主要な状態
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

	# キー・コンフィグのために何もするな、という状態
	if self.current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグに入力の制御を譲れ、という状態
	elif self.current_state == &"KeyConfig":
		self.monkey().key_config_node().on_unhandled_input(event)

	# 主な状態
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
		var button_number = self.monkey().key_config_node().get_button_number_by_text(event_as_text)
		
		# ボタン番号を、仮想キー名に変換
		var virtual_key_name = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)

		# レバー値
		var lever_value = self.monkey().key_config_node().get_lever_value_by_text(event_as_text)

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# 仮想キーを押下したという建付け
#
# 呼出し元:
# 	_unhandled_key_input()
#	_unhandled_input()
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if self.monkey().of_staff().scenario_writer().owner_node().on_virtual_key_input(
			virtual_key,
			lever_value,
			vk_operation):
		# 入力されたキーへの対処が完了したなら、処理を抜ける
		return

	# シナリオライター・ハブで　この入力をスルーしたなら、以降の処理を続ける
	print("［監督］　仮想キー（" + virtual_key + "）　レバー値：" + str(lever_value) + "　操作：" + vk_operation)

	# メッセージ・ウィンドウへ渡す
	self.monkey().scenario_player().get_current_message_window_gui().on_virtual_key_input(virtual_key, lever_value, vk_operation)


# ーーーーーーーー
# その他
# ーーーーーーーー


func _process(delta):

	# キー・コンフィグが始まる
	if self.current_state == &"WaitForKeyConfig":
		self.monkey().key_config_node().entry()
		self.current_state = &"KeyConfig"

	# キー・コンフィグに制御を譲る
	elif self.current_state == &"KeyConfig":
		self.monkey().key_config_node().on_process(delta)

	# 主な状態の前に
	elif self.current_state == &"Ready":
		self.current_state = &"Main"
		# ーーーーーーーー
		# 準備
		# ーーーーーーーー

		# 最初に実行する部門名
		self.current_department_name = self.monkey().of_staff().config_node().start_department_name

		# パースするな
		self.monkey().scenario_player_node().get_current_department_value().set_parse_lock(true)

		# 台本の「§」セクションの再生
		self.monkey().scenario_player_node().play_section()

		# 伝言窓を、一時的に居なくなっていたのを解除する
		self.monkey().scenario_player().get_current_message_window_gui().set_appear_subtree(true)

	# 主な状態に制御を譲る
	elif self.current_state == &"Main":
		self.monkey().scenario_player_node().on_process(delta)


# 変数展開する
# `target_before_change` - １行かもしれないし、段落かもしれないし、匿名関数かもしれない
func expand_variables(target_before_change):
	
	target_before_change = target_before_change.strip_edges()
		
	if target_before_change is String:
		# ここで `{{banana}} などの引数を　変数展開したい
		
		# 無限に変数展開することを防ぐため、変換前文字列と、変換後文字列は別途用意する
		var terget_after_change = ""
				
		var from = 0
		
		while from < target_before_change.length():
			var open_index = target_before_change.find("{{", from)
			var close_index = target_before_change.find("}}", from)
			
			if from <= open_index and open_index + 2 < close_index:

				# Head
				terget_after_change += target_before_change.substr(from, open_index - from)

				# 変数名取得
				var key = target_before_change.substr(open_index + 2, close_index - (open_index + 2))
				print("［プログラマーズ・ハブ　変数展開］　変数キー：［" + key + "］")
				
				if key in self.monkey().of_staff().programmer().owner_node().stage_directions_variables:
					var value = self.monkey().of_staff().programmer().owner_node().stage_directions_variables[key]
					print("［プログラマーズ・ハブ　変数展開］　変数値：［" + value + "］")
				
					terget_after_change += value
				
				else:
					print("［プログラマーズ・ハブ　変数展開］　変数値が見つかりません")
					
					# 仕方ないので、カッコ悪いが、キー（ハンドルバー）を画面に表示する
					terget_after_change += "{{" + key + "}}"

				from = close_index + 2
		
			else:
				#print("［助監　変数展開］　対象なし　段落：［" + target_before_change + "］")
				terget_after_change += target_before_change.substr(from)
				break

		return terget_after_change
	
	else:
		#print("［助監　変数展開］　対象なし　非テキスト")
		return target_before_change


# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
func trim_double_quotation(line):
	if 2 <= line.length() and line[0]=="\"" and line[-1]=="\"":
		return line.substr(1, line.length()-2)
	
	return line


# 先頭行と、それ以外に分けます。できなければヌル
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	
	if index < 0:
		return null
	
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［助監］　head：　[" + head + "]")
	# print("［助監］　tail：　[" + tail + "]")
	return [head, tail]


# 数値を全角テキストに変換
func number_to_zenkaku_text(number, figures):
	var zenkaku_text = ""
	
	while 0 < number:
		var zenkaku_num = self.zenkaku_numbers[number % 10]
		number /= 10
		
		zenkaku_text = zenkaku_num + zenkaku_text
	
	# 左側に全角空白を詰める
	var spaces = figures - zenkaku_text.length()
	for i in range(spaces):
		zenkaku_text = "　" + zenkaku_text
		
	return zenkaku_text


# 部門変数取得
func get_department_value(
		department_name):	# StringName
	return self.departments[department_name]
