# ビージーエム（BGM, Background Music；背景音楽）
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../AssistantDirector"


# BGM取得
func get_bgm():
	return $"../../Musician/BGM/🎬kifuwarabe_rpg_🍉bgm"


# それをする
func do_it(line):

	var csv = line.substr(4).strip_edges()
	print("［命令　ＢＧＭ］　CSV：[" + csv + "]　Line:［" + line + "］")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges())
	var from = null
	
	if 2 <= string_packed_array.size():
		from = float(self.get_assistant_director().expand_variables(string_packed_array[1].strip_edges()))

	if node_name == "":
		# BGM 停止
		self.stop_bgm()
		
	else:
		# じゃあ BGM 流すか
		self.play_bgm(node_name, from)


# BGM 再生
func play_bgm(node_name, from = null):
	if self.get_director().current_bgm_name!=null:
		self.stop_bgm()
		
	print("［命令　ＢＧＭ］　開始：[" + node_name + "]")
	self.get_director().current_bgm_name = node_name
	
	var bgm_name = self.get_director().current_bgm_name
	var audio_node = self.get_bgm().get_node(bgm_name)
	if audio_node == null:
		print("［命令　ＢＧＭ］　▲エラー　”" + bgm_name + "”　が無い")
	
	if from == null:
		audio_node.play()
	else:
		# 曲を途中から開始（単位は秒）
		audio_node.play(from)


# BGM 停止
func stop_bgm():
	if self.get_director().current_bgm_name != null:
		print("［命令　ＢＧＭ］　停止")
		
		var bgm_name = self.get_director().current_bgm_name
		var audio_node = self.get_bgm().get_node(bgm_name)
		if audio_node == null:
			print("［命令　ＢＧＭ］　▲エラー　”" + bgm_name + "”　が無い")
		
		audio_node.stop()
		self.get_director().current_bgm_name = null
