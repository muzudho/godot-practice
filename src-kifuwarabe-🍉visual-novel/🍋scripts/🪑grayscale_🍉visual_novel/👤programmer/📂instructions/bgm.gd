# ビージーミュージック（Bg Music, Background Music；背景音楽）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "bg_music:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　ＢＧＭ］　CSV：[" + csv + "]　Line:［" + line + "］")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var node_name = self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges())
	var from = null
	
	if 2 <= string_packed_array.size():
		from = float(self.monkey().owner_node().expand_variables(string_packed_array[1].strip_edges()))

	if node_name == "":
		# BGM 停止
		self.stop_bg_music()
		return
		
	# じゃあ BGM 流すか
	self.play_bg_music(node_name, from)


# BGM 再生
func play_bg_music(node_name, from = null):
	if self.monkey().of_staff().programmer().owner_node().current_bg_music_name!=null:
		self.stop_bg_music()
		
	print("［命令　ＢＧＭ］　開始：[" + node_name + "]")
	self.monkey().of_staff().programmer().owner_node().current_bg_music_name = node_name
	
	var bg_music_name = self.monkey().of_staff().programmer().owner_node().current_bg_music_name
	var audio_node = self.monkey().owner_node().bg_musics.find_node(bg_music_name)
	if audio_node == null:
		print("［命令　ＢＧＭ］　▲エラー　”" + bg_music_name + "”　が無い")
	
	if from == null:
		audio_node.play()
	else:
		# 曲を途中から開始（単位は秒）
		audio_node.play(from)


# BGM 停止
func stop_bg_music():
	if self.monkey().of_staff().programmer().owner_node().current_bg_music_name != null:
		print("［命令　ＢＧＭ］　停止")
		
		var bg_music_name = self.monkey().of_staff().programmer().owner_node().current_bg_music_name
		var audio_node = self.monkey().owner_node().bg_musics.find_node(bg_music_name)
		if audio_node == null:
			print("［命令　ＢＧＭ］　▲エラー　”" + bg_music_name + "”　が無い")
		
		audio_node.stop()
		self.monkey().of_staff().programmer().owner_node().current_bg_music_name = null
