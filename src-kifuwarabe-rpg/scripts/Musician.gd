#	ミュージシャン（Musician；音楽家）
#		音楽のことは頼んだ
extends Node


# ディレクター取得
func get_director():
	return $"../../Director"


#	BGM 再生
func playBgm(node_name, from = null):
	if self.get_director().current_bgm_name!=null:
		self.stopBgm()
		
	print("［音楽家］　ＢＧＭ開始：[" + node_name + "]")
	self.get_director().current_bgm_name = node_name
	
	var audio_node = $"BGM".get_node(self.get_director().current_bgm_name)
	
	if from == null:
		audio_node.play()
	else:
		audio_node.play(from)

	# $"BGM".get_node(self.get_director().current_bgm_name).play(8.4) # 開始地点を指定できる


#	効果音再生
func playSe(node_name):
	if self.get_director().current_se_name!=null:
		self.stopSe()

	print("［音楽家］　効果音開始：[" + node_name + "]")
	self.get_director().current_se_name = node_name
	$"SE".get_node(self.get_director().current_se_name).play()


#	BGM 停止
func stopBgm():
	if self.get_director().current_bgm_name != null:
		print("［音楽家］　ＢＧＭ停止")
		$"BGM".get_node(self.get_director().current_bgm_name).stop()
		self.get_director().current_bgm_name = null


#	効果音停止
func stopSe():
	if self.get_director().current_se_name != null:
		print("［音楽家］　効果音停止")
		$"SE".get_node(self.get_director().current_se_name).stop()
		self.get_director().current_se_name = null
