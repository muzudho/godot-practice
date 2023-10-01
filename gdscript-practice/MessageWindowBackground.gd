# メッセージ・ウィンドウの背景
extends Sprite2D

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false

func _ready():
	# 最初は非表示
	self.visible = false

func _process(delta):
	if self.statemachine.is_typewriter():
		if not self.is_visible_initialized:
			# タイプライター風表示中の初回に可視化
			self.visible = true
			self.is_visible_initialized = true
