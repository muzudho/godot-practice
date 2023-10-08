#	コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false


#	このウィンドウを閉じます
func initialize():
	# 初期状態は非表示、透明
	self.hide()
	self.modulate.a = 0.0


# 親からステートマシンを受け取る
func set_statemachine(parent_statemachine):
	self.statemachine = parent_statemachine
	
	# 子どもにも渡す
	self.get_node("CanvasLayer/TextBlock").set_statemachine(self.statemachine)
	

func _ready():
	self.initialize()


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
