#	チョイスカーソル（Choice Cursor；選択肢カーソル）
extends Label

#	文字の縦幅px
const font_height = 32
#	行間の縦幅
const line_space_height = 16

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null

#	カーソルが移動する前の位置
var src_y = 0.0
#	カーソルが移動する先の位置
var dst_y = 0.0
#	カーソルの移動にかかる全体の時間（秒）
var total_seconds = 0.0
#	経過時間（秒）
var elapsed_seconds = 0.0

#	カーソルが現在指している行番号。序数
var selected_row_number = 1

#	カーソルが点滅するための時間カウント
var is_first_displayed_immediately = false
var blinker_seconds = 0.0
var blinker_interval = 0.5


func get_parent_choice_row_numbers():
	# print("［選択肢カーソル］　選択肢行番号一覧")
	# for row_num in $"..".choice_row_numbers:
	# 	print(row_num)
	
	return $"..".choice_row_numbers


# 線形補間
func lerp(src, dst, progress):
	return src + (dst - src) * progress


# カーソルが上に移動します
func on_cursor_up(target_index):
	# 効果音鳴らす
	$"../../../Musician".playSe("選択肢カーソル移動音")

	var old_selected_row_number = self.selected_row_number
	self.selected_row_number = self.get_parent_choice_row_numbers()[target_index - 1]
	var difference = old_selected_row_number - self.selected_row_number
	
	self.src_y = self.offset_top
	self.dst_y = self.offset_top - difference * (self.font_height + self.line_space_height)
	self.total_seconds = 0.3
	self.elapsed_seconds = 0.0


# カーソルが下に移動します
func on_cursor_down(target_index):
	# 効果音鳴らす
	$"../../../Musician".playSe("選択肢カーソル移動音")

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
	# 最初は透明
	self.modulate.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	#	点滅
	self.blinker_seconds += delta

	if self.blinker_interval <= self.blinker_seconds:
		if 0 < self.modulate.a:
			self.modulate.a = 0.0
		else:
			self.modulate.a = 1.0
			
		self.blinker_seconds -= self.blinker_interval


	# 完全表示中	　かつ　選択肢モード
	if self.statemachine.is_completed() and $"..".is_choice_mode:
		
		#	初回はすぐに不透明
		if not self.is_first_displayed_immediately:
			self.modulate.a = 1.0
			self.blinker_seconds = 0.0
			self.is_first_displayed_immediately = true
				
		# カーソルが動く量が指定されているなら
		if 0.0 < self.total_seconds:
			
			# 移動する
			self.elapsed_seconds += delta
			var progress = self.elapsed_seconds/self.total_seconds
			if 1.0 <= progress:
				progress = 1.0
				self.total_seconds = 0.0
			self.offset_top = self.lerp(self.src_y, self.dst_y, progress)

			
		# 移動量が残ってないなら
		else:

			# 上へ移動する分
			if Input.is_action_pressed(&"ui_up"):
				# print("［選択肢カーソル］　上へ")
				
				# 上へ移動できるか？
				var index = self.get_parent_choice_row_numbers().find(self.selected_row_number)
				if index < 1:
					return

				# カーソルが上に移動します
				self.on_cursor_up(index)
				
			# 下へ移動する分
			if Input.is_action_pressed(&"ui_down"):
				# print("［選択肢カーソル］　下へ")
				# print("［選択肢カーソル］　選択行番号：" + str(self.selected_row_number))
				var size = self.get_parent_choice_row_numbers().size()
				# print("［選択肢カーソル］　選択肢数：" + str(size))
				
				# 下へ移動できるか？
				var index = self.get_parent_choice_row_numbers().find(self.selected_row_number)
				# print("［選択肢カーソル］　インデックス：" + str(index))
				if index < 0 or size <= index + 1:
					return

				# カーソルが下に移動します
				self.on_cursor_down(index)
		
	else:
		# 透明
		self.modulate.a = 0.0

