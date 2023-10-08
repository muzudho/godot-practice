# コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false

func _ready():
	# 最初は非表示、透明
	self.hide()
	self.modulate.a = 0.0

func _process(_delta):
	if self.visible:
		if self.statemachine.is_none():
			# 透明
			self.modulate.a = 0.0
			
		elif self.statemachine.is_typewriter():
			if not self.is_visible_initialized:
				# タイプライター風表示中の初回に可視化
				# 不透明
				self.modulate.a = 1.0
				self.is_visible_initialized = true
