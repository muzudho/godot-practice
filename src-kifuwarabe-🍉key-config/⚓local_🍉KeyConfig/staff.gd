# スタッフ（Staff；制作者）
#	キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ディレクター・ハブ取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	#
	# 開発中にいじったものが残ってるかもしれないから、掃除
	
	# グリッドは隠す
	self.monkey().grid().hide()

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# テロップ・コーディネーター表示
	self.monkey().telop_coordinator().show()

	# ーーーーーーーー
	# 初期化
	# ーーーーーーーー
	self.monkey().programmer().key_config_node().ready_in_staff()
	self.monkey().programmer().key_config_node().entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キーコンフィグで必要です
	self.monkey().programmer().key_config_node().on_process(delta)


func _unhandled_input(event):
	# キーコンフィグで必要です
	self.monkey().programmer().key_config_node().on_unhandled_input(event)


# キーコンフィグ開始時
func on_key_config_entered():
	# 背景
	self.monkey().illustrator().visible = true
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = true


# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = false
