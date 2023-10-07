#	シーンズ（Scenes）
extends Node2D


#	現在表示中のシーンのノード名
var current_name = null


# Called when the node enters the scene tree for the first time.
func _ready():
	print("［シーンズ］　準備")
	
	# （開発画面で表示設定が散らかっているだろう）
	# とにかく非表示にする
	self.hide_all_its_force()


# とにかく、非表示にする（重たい処理）
func hide_all_its_force():
	for child in self.get_children():
		child.hide()


# シーンを表示する
func show_scene(name):
	print("［シーンズ］　表示：[" + name + "]")
	
	# 既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_name != null:
		$"Images".get_node(self.current_name).hide()
	
	self.current_name = name
	self.visible = true
	self.get_node(self.current_name).show()


# シーンを非表示にする
func hide_scene():
	if 	self.current_name == null:
		return

	print("［センター・ウィンドウ］　非表示：[" + str(self.current_name) + "]")
	self.get_node(self.current_name).hide()	
	self.current_name = null
