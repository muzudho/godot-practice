extends Label

# カーソルを動かしたい量
var movement_y = 0.0
# カーソルが動いた量
var moved_y = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("［選択肢カーソル］　_ready()")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# カーソルが動く量が指定されているなら
	if self.movement_y != 0:
		
		# 移動する
		self.offset_top += self.movement_y
		self.movement_y -= self.movement_y
		self.moved_y += self.movement_y

		if abs(self.movement_y) <= abs(self.moved_y):
			# 指定分動いたなら
			self.movement_y = 0
		
	# 移動量が残ってないなら
	else:

		# 上へ移動する分
		# if Input.is_action_pressed(&"move_down"):
		if Input.is_action_pressed(&"ui_up"):
			print("［選択肢カーソル］　上へ")
			self.movement_y = -(32+8)
			self.moved_y = 0
			
		# 下へ移動する分
		# if Input.is_action_pressed(&"move_up"):
		if Input.is_action_pressed(&"ui_down"):
			print("［選択肢カーソル］　下へ")
			self.movement_y = 32+8
			self.moved_y = 0

