#	クイット（Quit；やめる）
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "quit:"


#	それをする
func do_it(_line):

	print("［命令　アプリケーション終了］　する")
	self.get_tree().quit()
