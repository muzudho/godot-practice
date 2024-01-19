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


# ディレクター・ハブ取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー

func _ready():

	
	self.bg_musics = MonkeyHand.create(
			self.monkey().of_staff().musician_bg_musics())		# 探す場所

	self.images = MonkeyHand.create(
			self.monkey().of_staff().illustrator())			# 探す場所

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
					self.monkey().scenario_player().get_current_department_value().set_parse_lock(false))

	# デパートメント変数辞書作成
	for department_name in self.monkey().get_all_department_names():
		# 生成
		var department_value = Department.new()

		# 部門名をコピー
		department_value.name = department_name		# StringName 型

		# メッセージを出力する対象となるウィンドウの名前。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
		department_value.stack_of_last_displayed_message_window.push_back(&"■FullScreen")	# StringName 型 シンタックス・シュガー

		# 先頭セクションの名前
		department_value.section_name = self.monkey().of_staff().scenario_writer().get_merged_scenario_document(department_name).keys()[0]

		self.departments[department_name] = department_value


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
		self.current_department_name = self.monkey().scenario_writer().department_control().start_department_name

		# パースするな
		self.monkey().scenario_player().get_current_department_value().set_parse_lock(true)

		# 台本の「§」セクションの再生
		self.monkey().scenario_player().play_section()

		# 伝言窓を、一時的に居なくなっていたのを解除する
		self.monkey().scenario_player().get_current_message_window_gui().set_appear_subtree(true)

	# 主な状態に制御を譲る
	elif self.current_state == &"Main":
		self.monkey().scenario_player().on_process(delta)


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
