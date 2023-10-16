# エスイー（SE, Sound Effects；効果音）
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# ミュージシャン取得
func get_musician():
	return $"../../Musician"


#	それをする
func do_it(line):

	var node_name = line.substr(3).strip_edges()
	print("［効果音］　ノード名：[" + node_name + "]")
	node_name = self.get_assistant_director().expand_param(node_name.strip_edges())

	if node_name == "":
		# 効果音 停止
		self.stop_se()
		
	else:
		# 効果音 再生
		self.play_se(node_name)


# 効果音再生
func play_se(node_name):
	if self.get_director().current_se_name!=null:
		self.stop_se()

	print("［効果音］　開始：[" + node_name + "]")
	self.get_director().current_se_name = node_name
	self.get_musician().get_node("SE").get_node(self.get_director().current_se_name).play()


# 効果音停止
func stop_se():
	if self.get_director().current_se_name != null:
		print("［効果音］　停止")
		self.get_musician().get_node("SE").get_node(self.get_director().current_se_name).stop()
		self.get_director().current_se_name = null
