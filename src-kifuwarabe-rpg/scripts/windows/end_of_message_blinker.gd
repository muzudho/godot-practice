#	エンド・オブ・メッセージ・ブリンカー（End Of Message Blinker；メッセージ末尾で点滅するもの）
extends Label


# 状態機械
var statemachine_of_end_of_message_blinker = load("res://scripts/statemachines/end_of_message_blinker.gd").new()
var statemachine_of_blinker = load("res://scripts/statemachines/blinker.gd").new()


#	関数の変数
var director_get_current_snapshot = null


#	メッセージエンド・ブリンカーの共通項目
#
#		カーソルが点滅するための時間カウント
var blinker_seconds = 0.0
var blinker_interval = 0.5

#	選択肢カーソルのためのもの
#
#		文字の縦幅px
const font_height = 32
#		行間の縦幅
const line_space_height = 16
#		カーソルが移動する前の位置
var src_y = 0.0
#		カーソルが移動する先の位置
var dst_y = 0.0
#		カーソルの移動にかかる全体の時間（秒）
var total_seconds = 0.0
#		経過時間（秒）
var elapsed_seconds = 0.0
#		カーソルが現在指している行番号。序数
var selected_row_number = 1


#	音楽家を取得
func get_musician():
	return $"../../../../../../Musician"


#	メッセージ・ウィンドウ名を取得
func get_message_window_name_obj():
	return $"../../..".name


func get_parent_choice_row_numbers():
	# print("［選択肢カーソル］　選択肢行番号一覧")

	var snapshot = self.director_get_current_snapshot.call()

	return snapshot.choice_row_numbers


#	線形補間
func do_lerp(src, dst, progress):
	return src + (dst - src) * progress


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	print("［文末ブリンカー　”" + str(self.get_message_window_name_obj()) + "/*/" + self.name + "］　プロセス：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード無し


#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［文末ブリンカー　”" + str(self.get_message_window_name_obj()) + "/*/" + self.name + "］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード無し


#	初期化
#		ウィンドウが消えている状態を想定しています。
func on_decided():
	print("［文末ブリンカー　”" + str(self.get_message_window_name_obj()) + "/*/" + self.name + "］　オン・デサイデッド")

	#	ブリンカーのスイッチ・オフ
	self.statemachine_of_blinker.switch_off()

	
func on_thought():
	print("［文末ブリンカー　”" + str(self.get_message_window_name_obj()) + "/*/" + self.name + "］　オン・ソート")
	self.modulate.a = 0.0	# 空欄化による透明化
	self.show()

	#	ブリンカーのスイッチ・オン
	self.statemachine_of_blinker.switch_on()


func on_sought():
	pass
	
	
func on_arrived():
	pass


#	初回点灯
func on_switched_on():
	self.modulate.a = 1.0
	self.blinker_seconds = 0.0


#	終回消灯
func on_switched_off():
	self.modulate.a = 0.0


#	時間経過による点灯
func on_turned_on():
	self.modulate.a = 1.0


#	時間経過による消灯
func on_turned_off():
	self.modulate.a = 0.0


#	カーソルが上に移動します
func on_cursor_up(target_index):
	#	効果音鳴らす
	self.get_musician().playSe("選択肢カーソル移動音")

	var old_selected_row_number = self.selected_row_number
	self.selected_row_number = self.get_parent_choice_row_numbers()[target_index - 1]
	var difference = old_selected_row_number - self.selected_row_number
	
	self.src_y = self.offset_top
	self.dst_y = self.offset_top - difference * (self.font_height + self.line_space_height)
	self.total_seconds = 0.3
	self.elapsed_seconds = 0.0


#	カーソルが下に移動します
func on_cursor_down(target_index):
	# 効果音鳴らす
	self.get_musician().playSe("選択肢カーソル移動音")

	var old_selected_row_number = self.selected_row_number
	self.selected_row_number = self.get_parent_choice_row_numbers()[target_index + 1]
	# print("［選択肢カーソル］　新行番号：" + str(self.selected_row_number))
	var difference = self.selected_row_number - old_selected_row_number

	self.src_y = self.offset_top
	self.dst_y = self.offset_top + difference * (self.font_height + self.line_space_height)
	self.total_seconds = 0.3
	self.elapsed_seconds = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	#	状態機械のセットアップ
	self.statemachine_of_end_of_message_blinker.on_decided = self.on_decided
	self.statemachine_of_end_of_message_blinker.on_thought = self.on_thought
	self.statemachine_of_end_of_message_blinker.on_sought = self.on_sought
	self.statemachine_of_end_of_message_blinker.on_arrived = self.on_arrived

	#	状態機械のセットアップ
	self.statemachine_of_blinker.on_switched_on = self.on_switched_on
	self.statemachine_of_blinker.on_switched_off = self.on_switched_off
	self.statemachine_of_blinker.on_turned_on = self.on_turned_on
	self.statemachine_of_blinker.on_turned_off = self.on_turned_off

	self.statemachine_of_end_of_message_blinker.decide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# 存在するときだけ働く
	if not self.statemachine_of_blinker.is_none():

		#	点滅
		self.blinker_seconds += delta

		if self.blinker_interval <= self.blinker_seconds:
			if 0 < self.modulate.a:
				#	時間経過による消灯
				self.statemachine_of_blinker.turn_off()
			else:
				#	時間経過による点灯
				self.statemachine_of_blinker.turn_on()
				
			self.blinker_seconds -= self.blinker_interval

		# 動くカーソル用
		# カーソルが動く量が指定されているなら
		if 0.0 < self.total_seconds:
			# 自動的にカーソルは移動中
			self.on_cursor_moving_automatically(delta)

			
		# 移動量が残ってないなら
		else:
			# 手動でカーソルは移動開始
			# 上へ移動する分
			if Input.is_action_pressed(&"ui_up"):
				# print("［選択肢カーソル］　上へ")
				var index = selected_cursor_index();
				
				# カーソルは上へ移動できるか？
				if self.can_cursor_up(index):
					# カーソルが上に移動します
					self.on_cursor_up(index)
				
			# 下へ移動する分
			if Input.is_action_pressed(&"ui_down"):
				# print("［選択肢カーソル］　下へ")
				# print("［選択肢カーソル］　選択行番号：" + str(self.selected_row_number))
				var index = selected_cursor_index();

				if self.can_cursor_down(index):
					# カーソルが下に移動します
					self.on_cursor_down(index)


#	自動的にカーソルは移動中
func on_cursor_moving_automatically(delta):
	self.elapsed_seconds += delta
	var progress = self.elapsed_seconds/self.total_seconds
	if 1.0 <= progress:
		progress = 1.0
		self.total_seconds = 0.0
	self.offset_top = self.do_lerp(self.src_y, self.dst_y, progress)


func selected_cursor_index():
	return self.get_parent_choice_row_numbers().find(self.selected_row_number)


#	カーソルは上へ移動できるか？
func can_cursor_up(index):
	return 0 < index


#	カーソルは下へ移動できるか？
func can_cursor_down(index):
	var choice_size = self.get_parent_choice_row_numbers().size()
	# print("［選択肢カーソル］　選択肢数：" + str(choice_size))
	
	# 下へ移動できるか？
	# print("［選択肢カーソル］　インデックス：" + str(index))
	return 0 <= index and index + 1 < choice_size

