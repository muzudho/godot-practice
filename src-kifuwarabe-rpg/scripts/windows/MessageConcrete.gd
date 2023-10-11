#	コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false


#	初期化の前に
#		初期化の一種ですが、初期化より前に行います。
#		引数を渡すことが **初期化** との違いです
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


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	print("［具体的メッセージウィンドウ］　プロセッシング：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード
		for child in $"CanvasLayer".get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［具体的メッセージウィンドウ］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in $"CanvasLayer".get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)


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
