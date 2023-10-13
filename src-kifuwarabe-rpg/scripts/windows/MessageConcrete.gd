#	コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D

#	メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null
var is_visible_initialized = false


#	メッセージ追加
func push_message(text, choices_row_numbers):
	print("［”" + self.name + "”メッセージウィンドウ］　メッセージ追加（表示、不透明化）")
	self.get_node("CanvasLayer/TextBlock").push_message(text, choices_row_numbers)
	self.modulate.a = 1.0	# メッセージ追加による不透明化
	

func _process(_delta):
	if self.visible:
		if self.statemachine.is_none():
			# 透明
			if self.modulate.a != 0.0:
				print("［”" + self.name + "”メッセージウィンドウ］　状態が無いので透明化")

				# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.modulate.a = 0.0	# 状態が無いので透明化

		elif self.statemachine.is_typewriter():
			if not self.is_visible_initialized:
				# タイプライター風表示中の初回に可視化				
				# 不透明
				self.modulate.a = 1.0	# TODO ここで自分の状態を変更するコードを書きたくない。エッジ―へ移動したい
				self.is_visible_initialized = true
