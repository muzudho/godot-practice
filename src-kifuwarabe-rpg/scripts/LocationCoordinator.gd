#	ロケーション・コーディネーター（Location Coordinator；場所手配）
#		撮影場所を手配してくれる人
extends Node2D


#	現在表示中のシーンのノード名
var current_name = null


#	シーンを表示する
func show_scene(node_name):
	print("［ロケーション・コーディネーター］　表示：[" + node_name + "]")

	#	既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.current_name != null:
		$"Images".get_node(self.current_name).hide()

	self.current_name = node_name
	self.visible = true
	self.get_node(self.current_name).show()


#	現在表示中のシーンがあれば、非表示にする
func hide_current_scene():
	if 	self.current_name == null:
		return

	print("［ロケーション・コーディネーター］　非表示：[" + str(self.current_name) + "]")
	self.get_node(self.current_name).hide()	
	self.current_name = null