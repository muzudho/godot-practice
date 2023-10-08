#	ミュージシャン（Musician；音楽家）
#		音楽のことは頼んだ
extends Node

#	現在鳴っている背景音楽のノード名
var current_bgm_name = null

#	現在鳴っている効果音のノード名
var current_se_name = null


#	BGM 再生
func playBgm(node_name):
	if self.current_bgm_name!=null:
		self.stopBgm()
		
	print("［音楽家］　ＢＧＭ開始：[" + node_name + "]")
	self.current_bgm_name = node_name
	$"BGM".get_node(self.current_bgm_name).play()


#	効果音再生
func playSe(node_name):
	if self.current_se_name!=null:
		self.stopSe()

	print("［音楽家］　効果音開始：[" + node_name + "]")
	self.current_se_name = node_name
	$"SE".get_node(self.current_se_name).play()


#	BGM 停止
func stopBgm():
	if self.current_bgm_name != null:
		print("［音楽家］　ＢＧＭ停止")
		$"BGM".get_node(self.current_bgm_name).stop()
		self.current_bgm_name = null


#	効果音停止
func stopSe():
	if self.current_se_name != null:
		print("［音楽家］　効果音停止")
		$"SE".get_node(self.current_se_name).stop()
		self.current_se_name = null
