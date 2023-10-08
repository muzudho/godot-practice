#	センター・ウィンドウ（Center Window；中央窓）
extends Node2D


#	現在表示中のセンターウィンドウ画像のノード名
var current_name = null


#	ウィンドウを表示する
func show_window(name):
	print("［センター・ウィンドウ］　表示：[" + name + "]")
	
	#	既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_name != null:
		self.get_node(self.current_name).hide()
	
	self.current_name = name
	self.show()
	self.get_node(self.current_name).show()
	$"System".show()
	$"System/Frame".show()


#	ウィンドウを非表示にする
func hide_window():
	if self.current_name == null:
		return

	print("［センター・ウィンドウ］　非表示：[" + str(self.current_name) + "]")
	self.get_node(self.current_name).hide()	
	$"System/Frame".hide()
	self.current_name = null
