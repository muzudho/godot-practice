#	ロケーション・コーディネーター（Location Coordinator；場所手配）
#		撮影場所を手配してくれる人
extends Node2D


func get_visual_novel_department_snapshot():
	return $"../System/Snapshots/VisualNovelDepartment"


#	シーンを表示する
func show_scene(node_name):
	print("［ロケーション・コーディネーター］　表示：[" + node_name + "]")

	#	既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if 	self.get_visual_novel_department_snapshot().location_node_name != null:
		$"Images".get_node(self.get_visual_novel_department_snapshot().location_node_name).hide()

	self.get_visual_novel_department_snapshot().location_node_name = node_name
	self.visible = true
	self.get_node(self.get_visual_novel_department_snapshot().location_node_name).show()


#	現在表示中のシーンがあれば、非表示にする
func hide_current_scene():
	if 	self.get_visual_novel_department_snapshot().location_node_name == null:
		return

	print("［ロケーション・コーディネーター］　非表示：[" + str(self.get_visual_novel_department_snapshot().location_node_name) + "]")
	self.get_node(self.get_visual_novel_department_snapshot().location_node_name).hide()
	self.get_visual_novel_department_snapshot().location_node_name = null
