#	ミュージシャン（Musician；音楽家）
#		音楽のことは頼んだ
extends Node


# ディレクター取得
func get_director():
	return $"../../Director"


#	効果音再生
func playSe(node_name):
	if self.get_director().current_se_name!=null:
		self.stopSe()

	print("［音楽家］　効果音開始：[" + node_name + "]")
	self.get_director().current_se_name = node_name
	$"SE".get_node(self.get_director().current_se_name).play()


#	効果音停止
func stopSe():
	if self.get_director().current_se_name != null:
		print("［音楽家］　効果音停止")
		$"SE".get_node(self.get_director().current_se_name).stop()
		self.get_director().current_se_name = null
