#	シーン（Scene；場面）
#		撮影場所変更
extends Node


#	関数の変数
var director_get_current_snapshot = null


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it


#	それをする
func do_it(line):

	var location_node_name = line.substr(6).strip_edges()
	print("［シーン］　名前：[" + location_node_name + "]")
	
	var snapshot = self.director_get_current_snapshot.call()
	
	$"../../LocationCoordinator".move_location(str(snapshot.name), location_node_name)
