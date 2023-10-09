#	バックグラウンド・アーティスト（Background Artist；背景美術）
#		画面全体を覆う一番後ろの絵を担当する人
extends Node


#	現在表示中の背景のノード名
var current_name = null


#	背景を設定
func show(node_name):
	
	#	現在表示中の背景を消す（上に乗っかるかもしれないから）
	if self.current_name != null:
		self.get_node(self.current_name).visible = false
	
	self.current_name = node_name
	print("［背景］　名前：[" + self.current_name + "]")
	
	#	表示
	self.visible = true
	self.get_node(self.current_name).visible = true
