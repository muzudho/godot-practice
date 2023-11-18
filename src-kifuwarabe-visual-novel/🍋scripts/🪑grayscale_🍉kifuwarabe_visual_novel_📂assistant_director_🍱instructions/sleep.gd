# スリープ（Sleep；眠る）
#	指定秒待つ
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 助監
func get_assistant_director():
	return $"../../../📂Programmer"


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［命令　スリープ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var seconds = float(self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges()))

	self.sleep(seconds)


# 指定ミリ秒待つ
#
#	シナリオのパラグラフを抜けてから、疑似スリープを行います
func sleep(seconds):
	print("［命令　スリープ］　秒：[" + str(seconds) + "]")
	self.get_assistant_director().get_director().sleep_seconds = seconds
	
