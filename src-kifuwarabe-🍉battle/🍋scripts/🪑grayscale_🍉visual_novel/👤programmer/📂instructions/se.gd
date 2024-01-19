# サウンド・エフェクト（Sound FX, Sound Effects；効果音）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "sound_fx:"


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

	var node_name = line.substr(self.code.length()).strip_edges()
	print("［命令　効果音］　ノード名：[" + node_name + "]")
	node_name = self.monkey().owner_node().expand_variables(node_name.strip_edges())

	if node_name == "":
		# 効果音 停止
		self.stop_se()
		
	else:
		# 効果音 再生
		self.play_se(node_name)


# 効果音再生
func play_se(node_name):
	if self.monkey().of_staff().programmer().owner_node().current_se_name!=null:
		self.stop_se()

	print("［命令　効果音］　開始：[" + node_name + "]")
	self.monkey().of_staff().programmer().owner_node().current_se_name = node_name

	var se_name = self.monkey().of_staff().programmer().owner_node().current_se_name
	var se_node = self.monkey().owner_node().sound_fx.find_node(se_name)
	if se_node == null:
		print("［命令　効果音］　▲エラー　”" + se_name + "”　が無い")
	
	se_node.play()


# 効果音停止
func stop_se():
	if self.monkey().of_staff().programmer().owner_node().current_se_name != null:
		print("［命令　効果音］　停止")
		
		var se_name = self.monkey().of_staff().programmer().owner_node().current_se_name
		var se_node = self.monkey().owner_node().sound_fx.find_node(se_name)
		if se_node == null:
			print("［命令　効果音］　▲エラー　”" + se_name + "”　が無い")
		
		se_node.stop()
		self.monkey().of_staff().programmer().owner_node().current_se_name = null
