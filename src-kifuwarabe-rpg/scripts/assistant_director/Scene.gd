# シーン（Scene；場面）
#	撮影場所変更
extends Node


# 関数の変数
var director_get_current_snapshot = null


# ディレクター取得
func get_director():
	return $"../../../Director"


# ロケーション・コーディネーター取得
func get_location_coordinator():
	return $"../../LocationCoordinator"


# スナップショット取得
func get_snapshot(department_node_name):
	return self.get_director().get_snapshot(department_node_name)


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(line):

	var location_node_name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + location_node_name + "]")
	
	var snapshot = self.director_get_current_snapshot.call()
	
	self.move_location(str(snapshot.name), location_node_name)


# 場所を替える
func move_location(
	department_node_name,		# str
	new_location_node_name):	# str
	print("［シーン］　切替：[" + new_location_node_name + "]")

	# ロケーション・コーディネーター取得
	var location_coordinator = self.get_location_coordinator()
	# スナップショット取得
	var snapshot = self.get_snapshot(department_node_name)

	# 旧名というのを強調
	var old_location_node_name = snapshot.location_node_name

	# 既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if old_location_node_name != "":
		location_coordinator.get_node(old_location_node_name).hide()

	# 更新
	snapshot.location_node_name = new_location_node_name

	# 表示
	if new_location_node_name != "":
		location_coordinator.get_node(new_location_node_name).show()
