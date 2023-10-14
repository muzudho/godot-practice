# ロケーション・コーディネーター（Location Coordinator；場所手配）
#	撮影場所を手配してくれる人
extends Node2D


func get_snapshot_data(department_node_name):
	return $"../../Director".get_snapshot_data(department_node_name)


# 場所を替える
func move_location(department_node_name, new_location_node_name):
	print("［ロケーション・コーディネーター］　切替：[" + new_location_node_name + "]")

	# 変数名を短くする
	var old_location_node_name = self.get_snapshot_data(department_node_name).location_node_name
	

	# 既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if old_location_node_name != "":
		self.get_node(old_location_node_name).hide()

	# 記憶
	self.get_snapshot_data(department_node_name).location_node_name = new_location_node_name

	# 表示
	if new_location_node_name != "":
		self.get_node(new_location_node_name).show()


# 場所が非表示中なら、表示にする
func show_current_location(department_node_name):
	# 変数名を短くする
	var current_location_node_name = self.get_snapshot_data(department_node_name).location_node_name

	if current_location_node_name == "":
		return

	print("［ロケーション・コーディネーター］　表示：[" + str(current_location_node_name) + "]")
	self.get_node(current_location_node_name).show()


# 場所が表示中なら、非表示にする
func hide_current_location(department_node_name):
	# 変数名を短くする
	var current_location_node_name = self.get_snapshot_data(department_node_name).location_node_name

	if current_location_node_name == "":
		return

	print("［ロケーション・コーディネーター］　非表示：[" + str(current_location_node_name) + "]")
	self.get_node(current_location_node_name).hide()


func _ready():
	# 自分自身は常に可視
	self.show()
