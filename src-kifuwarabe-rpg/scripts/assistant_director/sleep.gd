# スリープ（Sleep, 眠る）
#	指定秒待つ
extends Node


# ディレクター取得
func get_director():
	return $"../../../Director"


# アシスタント・ディレクター
func get_assistant_director():
	return $"../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(6).strip_edges()
	print("［ＢＧＭ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var seconds = float(self.get_assistant_director().expand_param(string_packed_array[0].strip_edges()))

	self.sleep(seconds)


# 指定ミリ秒待つ
#
#	シナリオのパラグラフを抜けてから、疑似スリープを行います
func sleep(seconds):
	print("［スリープ］　秒：[" + str(seconds) + "]")
	self.get_director().sleep_seconds = seconds
	
