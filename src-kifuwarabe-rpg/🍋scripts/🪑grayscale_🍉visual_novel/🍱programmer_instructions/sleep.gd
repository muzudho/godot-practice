# スリープ（Sleep；眠る）
#	指定秒待つ
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ProgramsHub")


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr("sleep:".length()).strip_edges()
	print("［命令　スリープ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var seconds = float(self.hub().expand_variables(string_packed_array[0].strip_edges()))

	self.sleep(seconds)


# 指定ミリ秒待つ
#
#	シナリオのパラグラフを抜けてから、疑似スリープを行います
func sleep(seconds):
	print("［命令　スリープ］　秒：[" + str(seconds) + "]")
	self.hub().get_director().sleep_seconds = seconds
	
