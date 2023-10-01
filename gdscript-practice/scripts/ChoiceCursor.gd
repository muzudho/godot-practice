extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null

# カーソルが移動する前の位置
var src_y = 0.0
# カーソルが移動する先の位置
var dst_y = 0.0
# カーソルの移動にかかる全体の時間（秒）
var total_seconds = 0.0
# 経過時間（秒）
var elapsed_seconds = 0.0


# 線形補間
func lerp(src, dst, progress):
	return src + (dst - src) * progress


# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# 完全表示中	　かつ　選択肢モード
	if self.statemachine.is_completed() and $"..".is_choice_mode:
		
		# 表示
		if not self.visible:
			self.visible = true
		
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

			const font_height = 32
			const space_line = 16

			# 上へ移動する分
			if Input.is_action_pressed(&"ui_up"):
				print("［選択肢カーソル］　上へ")
				self.src_y = self.offset_top
				self.dst_y = self.offset_top - (font_height+space_line)
				self.total_seconds = 0.3
				self.elapsed_seconds = 0.0
				
			# 下へ移動する分
			if Input.is_action_pressed(&"ui_down"):
				print("［選択肢カーソル］　下へ")
				self.src_y = self.offset_top
				self.dst_y = self.offset_top + (font_height+space_line)
				self.total_seconds = 0.3
				self.elapsed_seconds = 0.0
		
	else:
		# 非表示
		self.visible = false


