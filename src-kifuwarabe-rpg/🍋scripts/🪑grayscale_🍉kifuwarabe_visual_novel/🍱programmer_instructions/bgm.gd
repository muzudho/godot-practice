# ビージーエム（BGM, Background Music；背景音楽）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"../../🛩️ProgramsHub"


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr("bgm:".length()).strip_edges()
	print("［命令　ＢＧＭ］　CSV：[" + csv + "]　Line:［" + line + "］")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.hub().expand_variables(string_packed_array[0].strip_edges())
	var from = null
	
	if 2 <= string_packed_array.size():
		from = float(self.hub().expand_variables(string_packed_array[1].strip_edges()))

	if node_name == "":
		# BGM 停止
		self.stop_bgm()
		
	else:
		# じゃあ BGM 流すか
		self.play_bgm(node_name, from)


# BGM 再生
func play_bgm(node_name, from = null):
	if self.hub().get_director().current_bgm_name!=null:
		self.stop_bgm()
		
	print("［命令　ＢＧＭ］　開始：[" + node_name + "]")
	self.hub().get_director().current_bgm_name = node_name
	
	var bgm_name = self.hub().get_director().current_bgm_name
	var audio_node = self.hub().get_bgm().get_node(bgm_name)
	if audio_node == null:
		print("［命令　ＢＧＭ］　▲エラー　”" + bgm_name + "”　が無い")
	
	if from == null:
		audio_node.play()
	else:
		# 曲を途中から開始（単位は秒）
		audio_node.play(from)


# BGM 停止
func stop_bgm():
	if self.hub().get_director().current_bgm_name != null:
		print("［命令　ＢＧＭ］　停止")
		
		var bgm_name = self.hub().get_director().current_bgm_name
		var audio_node = self.hub().get_bgm().get_node(bgm_name)
		if audio_node == null:
			print("［命令　ＢＧＭ］　▲エラー　”" + bgm_name + "”　が無い")
		
		audio_node.stop()
		self.hub().get_director().current_bgm_name = null
