# スタッフ（Staff；制作者）
extends Node2D


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():
	self.monkey().programmer().owner_node().ready_in_staff()
