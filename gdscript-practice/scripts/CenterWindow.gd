# センター・ウィンドウ（Center Window；中央窓）
extends Node


# 現在表示中の画像名
var current_image_name = null


# ウィンドウを表示する
func show_window(image_name):
	print("［センター・ウィンドウ］　表示：[" + image_name + "]")
	
	# 既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_image_name != null:
		$"Images".get_node(self.current_image_name).hide()
	
	self.current_image_name = image_name
	$"Images".get_node(self.current_image_name).show()
	$"Frame".show()


# ウィンドウを非表示にする
func hide_window():
	if 	self.current_image_name == null:
		return

	print("［センター・ウィンドウ］　非表示：[" + str(self.current_image_name) + "]")
	$"Images".get_node(self.current_image_name).hide()	
	$"Frame".hide()
	self.current_image_name = null


# とにかく、非表示にする（重たい処理）
func hide_window_force():
	for child in $"Images".get_children():
		child.hide()
	$"Frame".hide()


# Called when the node enters the scene tree for the first time.
func _ready():
	print("［センター・ウィンドウ］　準備")
	
	# とにかく非表示にする
	self.hide_window_force()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
