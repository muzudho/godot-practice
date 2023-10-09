#	ビージー（Bg, Background；背景）
#		背景画像の変更
extends Node


#	それをする
func do_it(line):

	var node_name = line.substr(3).strip_edges()
	print("［背景］　名前：[" + node_name + "]")

	# 背景設定
	$"../../BackgroundArtist".show(node_name)
