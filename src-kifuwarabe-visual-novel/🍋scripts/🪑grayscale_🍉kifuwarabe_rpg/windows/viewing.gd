#	ビューイング・ウィンドウ（Viewing Window；覗き窓）
extends Node2D


#	現在表示中のビューイング・ウィンドウ画像のノード名
var current_name = null


#	ウィンドウを表示する
func show_window(node_name):
	print("［ビューイング・ウィンドウ］　表示：[" + node_name + "]")
	
	#	既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_name != null:
		self.get_node(self.current_name).hide()
	
	self.current_name = node_name
	self.show()
	self.get_node(self.current_name).show()
	$"System".show()
	$"System/Frame".show()


#	ウィンドウを非表示にする
func hide_window():
	if self.current_name == null:
		return

	print("［ビューイング・ウィンドウ］　非表示：[" + str(self.current_name) + "]")
	self.get_node(self.current_name).hide()	
	$"System/Frame".hide()
	self.current_name = null
