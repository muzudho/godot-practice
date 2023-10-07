# バックグラウンド（Background；背景）
extends Node


# 現在表示中の背景
var current_name = null


# 背景を設定
func show(name):
	# 現在表示中の背景を消す（上に乗っかるかもしれないから）
	if self.current_name != null:
		$"Images".get_node(self.current_name).visible = false
	
	self.current_name = name
	print("［背景］　名前：[" + self.current_name + "]")
	
	# 表示
	self.visible = true
	$"Images".visible = true		
	$"Images".get_node(self.current_name).visible = true


# とにかく、非表示にする（重たい処理）
func hide_all_its_force():
	for child in $"Images".get_children():
		child.hide()


# Called when the node enters the scene tree for the first time.
func _ready():
	print("［背景］　準備")
	
	# （開発画面で表示設定が散らかっているだろう）
	# とにかく非表示にする
	self.hide_all_its_force()
