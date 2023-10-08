#	クイット（Quit；やめる）
extends Node


#	それをする
func do_it(_line):
	print("［アプリケーション終了］　する")
	self.get_tree().quit()
