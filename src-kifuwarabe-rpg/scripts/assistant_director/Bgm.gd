# ビージーエム（BGM, Background Music；背景音楽）
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# ミュージシャン取得
func get_musician():
	return $"../../Musician"


# それをする
func do_it(line):

	var csv = line.substr(4).strip_edges()
	print("［ＢＧＭ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = string_packed_array[0]
	var from = null
	
	if 2 <= string_packed_array.size():
		from = float(string_packed_array[1])

	if node_name == "":
		# BGM 停止
		self.get_musician().stop_bgm()
		
	else:
		# じゃあ BGM 流すか
		self.play_bgm(node_name, from)


# BGM 再生
func play_bgm(node_name, from = null):
	if self.get_director().current_bgm_name!=null:
		self.get_musician().stop_bgm()
		
	print("［音楽家］　ＢＧＭ開始：[" + node_name + "]")
	self.get_director().current_bgm_name = node_name
	
	var audio_node = self.get_musician().get_node("BGM").get_node(self.get_director().current_bgm_name)
	
	if from == null:
		audio_node.play()
	else:
		# 曲を途中から開始（単位は秒）
		audio_node.play(from)
