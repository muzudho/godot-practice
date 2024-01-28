# スリープ（Sleep；眠る）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
#
# 指定秒待つ
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "sleep:"


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
	print("［命令　スリープ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var seconds = float(self.monkey().owner_node().expand_variables(string_packed_array[0].strip_edges()))

	self.sleep(seconds)


# 指定ミリ秒待つ
#
#	シナリオのパラグラフを抜けてから、疑似スリープを行います
func sleep(seconds):
	print("［命令　スリープ］　秒：[" + str(seconds) + "]")
	self.monkey().of_staff().programmer().owner_node().sleep_seconds = seconds
