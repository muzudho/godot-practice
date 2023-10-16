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

	var csv = line.substr(6).strip_edges()
	print("［テロップ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = string_packed_array[0]
	var sub_command = null
	
	if 2 <= string_packed_array.size():
		sub_command = string_packed_array[1].strip_edges()
	
	if sub_command == "hide":
		# テロップを隠す
		self.hide_telop(node_name)
		return
	
	var snapshot = self.director_get_current_snapshot.call()
	
	self.change_telop(str(snapshot.name), node_name)


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
		self.hide_telop(old_telop_node_name)

	# 更新
	snapshot.telop_node_name = new_telop_node_name

	# 表示
	if new_telop_node_name != "":
		self.show_telop(new_telop_node_name)


# テロップを見せる
func show_telop(node_name):
	self.get_telop_coordinator().get_node(node_name).show()

# テロップを隠す
func hide_telop(node_name):
	self.get_telop_coordinator().get_node(node_name).hide()
