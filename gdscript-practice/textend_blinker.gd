extends Label

# 状態遷移図
const States = preload("MessageWindowStatemachine.gd").States

# 点滅用
var count_of_blink = 0


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# テキスト・エリアの状態確認
	var state = $"..".state

	# 完全表示中	
	if state == States.Completed:
		# 表示して点滅
		if not self.visible:
			self.visible = true
		
		count_of_blink += delta
		if 0.75 <= count_of_blink: 
			visible = not visible
			count_of_blink -= 0.75
	# それ以外
	else:
		# 非表示
		self.visible = false

func reset():
	self.visible = false
	self.count_of_blink = 0
	
