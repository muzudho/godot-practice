# ディレクター（Director；監督）
#
# キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ハブ取得
func hub():
	return $"🛩️Hub"


# ーーーーーーーー
# その他
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# テロップ・コーディネーター表示
	self.hub().telop_coordinator().show()

	# ーーーーーーーー
	# 初期化
	# ーーーーーーーー
	$"🛩️KeyConfigHub".entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キーコンフィグで必要です
	$"🛩️KeyConfigHub".on_process(delta)


func _unhandled_input(event):
	# キーコンフィグで必要です
	$"🛩️KeyConfigHub".on_unhandled_input(event)


# キーコンフィグ開始時
func on_key_config_entered():
	# 背景
	self.hub().illustrator().visible = true
	self.hub().programmer_hub().images.find_node("🗻崎川駅前").visible = true


# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.hub().programmer_hub().images.find_node("🗻崎川駅前").visible = false
