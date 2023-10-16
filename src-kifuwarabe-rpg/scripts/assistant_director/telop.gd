# テロップ（Telop, Television opaque projector；テレビ投射映像機）
#	撮影場所変更
extends Node


# 関数の変数
var director_get_current_snapshot = null


# ディレクター取得
func get_director():
	return $"../../../Director"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"../../TelopCoordinator"


# スナップショット取得
func get_snapshot(department_node_name):
	return self.get_director().get_snapshot(department_node_name)


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(line):

	var telop_node_name = line.substr(6).strip_edges()
	print("［テロップ］　名前：[" + telop_node_name + "]")
	
	var snapshot = self.director_get_current_snapshot.call()
	
	self.change_telop(str(snapshot.name), telop_node_name)


# 場所を替える
func change_telop(
	department_node_name,		# str
	new_telop_node_name):		# str
	print("［テロップ］　テロップ名：[" + new_telop_node_name + "]")

	# テロップ・コーディネーター取得
	var telop_coordinator = self.get_telop_coordinator()
	# スナップショット取得
	var snapshot = self.get_snapshot(department_node_name)

	# 旧名というのを強調
	var old_telop_node_name = snapshot.telop_node_name

	# 既に表示中の画像を非表示にする（上に乗っかっていて、表示したい絵が見えないケースがある）
	if old_telop_node_name != "":
		telop_coordinator.get_node(old_telop_node_name).hide()

	# 更新
	snapshot.telop_node_name = new_telop_node_name

	# 表示
	if new_telop_node_name != "":
		telop_coordinator.get_node(new_telop_node_name).show()
