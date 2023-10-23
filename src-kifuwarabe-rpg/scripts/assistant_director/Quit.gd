#	クイット（Quit；やめる）
extends Node


#	それをする
func do_it(_line):

	print("［命令　アプリケーション終了］　する")
	self.get_tree().quit()
