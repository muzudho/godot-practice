# エンド・オブ・メッセージ・ブリンカー（End Of Message Blinker；メッセージ末尾で点滅するもの）
extends Label


# 状態機械
var statemachine_of_end_of_message_blinker = load("res://🪑grayscale_🎬kifuwarabe_rpg/scripts/statemachines/end_of_message_blinker.gd").new()
var statemachine_of_blinker = load("res://🪑grayscale_🎬kifuwarabe_rpg/scripts/statemachines/blinker.gd").new()


var is_appear = true

# メッセージエンド・ブリンカーの共通項目
#
#	カーソルが点滅するための時間カウント
var blinker_seconds = 0.0
var blinker_interval = 0.5

# 選択肢カーソルのためのもの
#
#	文字の縦幅px
const font_height = 32
#	行間の縦幅
const line_space_height = 16
#	カーソルが移動する前の位置
var src_y = 0.0
#	カーソルが移動する先の位置
var dst_y = 0.0
#	カーソルの移動にかかる全体の時間（秒）
var total_seconds = 0.0
#	経過時間（秒）
var elapsed_seconds = 0.0


# 監督取得
func get_director():
	return $"../../../../../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../../../../../AssistantDirector"


# 伝言窓名を取得
func get_message_window_name():
	var temp = $"../..".name
	temp = temp.substr(0, temp.length() - "_CanvasLayer".length())
	return StringName(temp)


# 伝言窓を取得
func get_ancestor_message_window():
	var path = "../../../" + self.get_message_window_name()
	#print("［選択肢］　path:" + path)
	return self.get_node(path)


# キーコンフィグ監督取得
func get_director_for_key_config():
	return $"../../../../../../../Director/🎬key_config_🍉director"


# 線形補間
func do_lerp(src, dst, progress):
	return src + (dst - src) * progress


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	#print("［文末ブリンカー　”" + str(self.get_message_window_name()) + "_CanvasLayer/*/" + self.name + "］　プロセス：" + str(is_process))

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		# 子ノード無し


# サブツリーの visible を設定
func set_visible_subtree(visible_flag):
	#print("［文末ブリンカー　”" + str(self.get_message_window_name()) + "_CanvasLayer/*/" + self.name + "］　可視性：" + str(visible_flag))

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if visible_flag != self.visible:
		self.visible = visible_flag

		# 子ノード無し


# サブツリーの appear を設定
func set_appear_subtree(appear_flag):

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if appear_flag != self.is_appear:
		self.is_appear = appear_flag
		
		if self.is_appear:
			# 画面内に戻す
			self.position += Vector2(0, -720)

		else:
			# 画面下の外に押し出す
			self.position += Vector2(0, 720)

		# 子ノード無し


# 初期化
#	ウィンドウが消えている状態を想定しています。
func on_none_the_end_of_message_blinker():
	print("［文末ブリンカー　”" + str(self.get_message_window_name()) + "_CanvasLayer/*/" + self.name + "］　オン・デサイデッド")

	# ブリンカーのスイッチ・オフ
	self.statemachine_of_blinker.switch_off()
	
	# カーソルを先頭に戻す
	#self.reset_cursor_position()

	
func on_thought():
	#print("［文末ブリンカー　”" + str(self.get_message_window_name()) + "_CanvasLayer/*/" + self.name + "］　オン・ソート")
	self.modulate.a = 0.0	# 空欄化による透明化
	self.show()

	# ブリンカーのスイッチ・オン
	self.statemachine_of_blinker.switch_on()


func on_sought():
	pass
	
	
func on_arrived():
	pass


# 初回点灯
func on_switched_on():
	self.modulate.a = 1.0
	self.blinker_seconds = 0.0


# 終回消灯
func on_switched_off():
	self.modulate.a = 0.0


# 時間経過による点灯
func on_turned_on():
	self.modulate.a = 1.0


# 時間経過による消灯
func on_turned_off():
	self.modulate.a = 0.0


# カーソル位置を算出
func calc_cursor_vector():
	var snapshot = self.get_director().get_current_snapshot()
	var selected_row_number = snapshot.get_row_number_of_choices()

	# 先頭を１行目とし、基数に変換する
	var difference = selected_row_number - 1

	var message_window = self.get_ancestor_message_window()

	# self.get_transform().x と、 self.offset_right 、どっちを変更するのがいい？
	# self.get_transform().y と、 self.offset_top 、どっちを変更するのがいい？
	var scalar_x = message_window.choices_cursor_origin_x
	var scalar_y = difference * (self.font_height + self.line_space_height) + message_window.choices_cursor_origin_y
	return Vector2(scalar_x, scalar_y)


# 選択肢カーソルを先頭へセットします
func reset_cursor_position():
	print("［選択肢カーソル］　先頭へリセット")
	var snapshot = self.get_director().get_current_snapshot()

	snapshot.choices_index = 0
	var vec = self.calc_cursor_vector()

	self.offset_left = vec.x
	self.offset_top = vec.y
	#self.get_transform().x = Vector2(vec.x, 0)
	#self.get_transform().y = Vector2(0, vec.y)


# カーソルが上に移動します
func on_cursor_up(_target_index):
	# 効果音鳴らす
	self.get_assistant_director().get_node("Se").play_se("🔔選択肢カーソル移動音")

	var snapshot = self.get_director().get_current_snapshot()

	var old_vec = self.calc_cursor_vector()
	snapshot.choices_index -= 1
	var new_vec = self.calc_cursor_vector()

	self.src_y = old_vec.y
	self.dst_y = new_vec.y
	self.total_seconds = 0.3
	self.elapsed_seconds = 0.0


# カーソルが下に移動します
func on_cursor_down(_target_index):
	# 効果音鳴らす
	self.get_assistant_director().get_node("Se").play_se("🔔選択肢カーソル移動音")

	var snapshot = self.get_director().get_current_snapshot()

	var old_vec = self.calc_cursor_vector()
	snapshot.choices_index += 1 
	var new_vec = self.calc_cursor_vector()

	self.src_y = old_vec.y
	self.dst_y = new_vec.y
	self.total_seconds = 0.3
	self.elapsed_seconds = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	# 状態機械のセットアップ
	self.statemachine_of_end_of_message_blinker.on_none = self.on_none_the_end_of_message_blinker
	self.statemachine_of_end_of_message_blinker.on_thought = self.on_thought
	self.statemachine_of_end_of_message_blinker.on_sought = self.on_sought
	self.statemachine_of_end_of_message_blinker.on_arrived = self.on_arrived

	# 状態機械のセットアップ
	self.statemachine_of_blinker.on_switched_on = self.on_switched_on
	self.statemachine_of_blinker.on_switched_off = self.on_switched_off
	self.statemachine_of_blinker.on_turned_on = self.on_turned_on
	self.statemachine_of_blinker.on_turned_off = self.on_turned_off

	#self.statemachine_of_end_of_message_blinker.decide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# 存在するときだけ働く
	if not self.statemachine_of_blinker.is_none():

		# 点滅
		self.blinker_seconds += delta

		if self.blinker_interval <= self.blinker_seconds:
			if 0 < self.modulate.a:
				# 時間経過による消灯
				self.statemachine_of_blinker.turn_off()
			else:
				# 時間経過による点灯
				self.statemachine_of_blinker.turn_on()
				
			self.blinker_seconds -= self.blinker_interval

		var snapshot = self.get_director().get_current_snapshot()
		# 動くカーソル用
		if snapshot.is_choices():

			# カーソルが動く量が指定されているなら
			if 0.0 < self.total_seconds:
				# 自動的にカーソルは移動中
				self.on_cursor_moving_automatically(delta)


# 仮想キー入力時
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# 存在しなければ何もしない
	if self.statemachine_of_blinker.is_none():
		return

	# 押下時
	if vk_operation == &"VKO_Pressed":

		var snapshot = self.get_director().get_current_snapshot()

		# 動くカーソル用
		if snapshot.is_choices():
			# カーソルが動く量が指定されているなら
			if 0.0 < self.total_seconds:
				# 自動的にカーソルは移動中
				pass
				
			# 移動量が残ってないなら
			else:
				
				# 手動でカーソルは移動開始
				# 上へ移動する分
				if self.get_director_for_key_config().is_key_up(virtual_key, lever_value):
					#print("［選択肢カーソル］　上へ")

					# カーソルは上へ移動できるか？
					if self.can_cursor_up():
						# カーソルが上に移動します
						self.on_cursor_up(snapshot.choices_index)
					
				# 下へ移動する分
				elif self.get_director_for_key_config().is_key_down(virtual_key, lever_value):
					#print("［選択肢カーソル］　下へ")

					if self.can_cursor_down():
						# カーソルが下に移動します
						self.on_cursor_down(snapshot.choices_index)


# 自動的にカーソルは移動中
func on_cursor_moving_automatically(delta):
	self.elapsed_seconds += delta
	var progress = self.elapsed_seconds/self.total_seconds
	if 1.0 <= progress:
		progress = 1.0
		self.total_seconds = 0.0
	self.offset_top = self.do_lerp(self.src_y, self.dst_y, progress)


# カーソルは上へ移動できるか？
func can_cursor_up():

	var snapshot = self.get_director().get_current_snapshot()
	var index = snapshot.choices_index

	if 0 < index:
		print("［選択肢カーソル］　現在インデックス：" + str(index) + "　上へ移動できる")
		return true
	
	else:
		print("［選択肢カーソル］　現在インデックス：" + str(index) + "　上へ移動できない")
		return false


# カーソルは下へ移動できるか？
func can_cursor_down():

	var snapshot = self.get_director().get_current_snapshot()
	var index = snapshot.choices_index

	# 配列
	var choices_row_numbers = snapshot.choices_row_numbers
	if choices_row_numbers != null:
		var choice_size = choices_row_numbers.size()
	
		# 下へ移動できるか？
		var can_down = 0 <= index and index + 1 < choice_size

		if can_down:
			print("［選択肢カーソル］　選択肢数：" + str(choice_size) + "　現在インデックス：" + str(index) + "　下へ移動できる")
		else:
			print("［選択肢カーソル］　選択肢数：" + str(choice_size) + "　現在インデックス：" + str(index) + "　下へ移動できない")

		return can_down

	return false
