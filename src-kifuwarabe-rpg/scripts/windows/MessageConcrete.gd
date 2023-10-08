#	コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false


#	初期化の前に
#		 初期化の一種ですが、初期化より前に行います
func before_initialize(parent_statemachine):
	#	親からステートマシンを引き継ぐ
	self.statemachine = parent_statemachine

	#	子どもにもステートマシンを渡す
	self.get_node("CanvasLayer/TextBlock").before_initialize(self.statemachine)


#	初期化
#		ウィンドウが閉じた状態を想定しています
func initialize():

	# 子要素を初期化
	self.get_node("CanvasLayer/TextBlock").initialize()

	# この要素の初期状態は、非表示、透明
	self.hide()
	self.modulate.a = 0.0


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
