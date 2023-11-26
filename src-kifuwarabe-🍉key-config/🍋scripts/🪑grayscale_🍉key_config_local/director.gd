# ディレクター（Director；監督）
#
# キーコンフィグの使い方の実例です。このノード自身はキーコンフィグ本体ではありません
#
extends Node2D


# ーーーーーーーー
# 内パス関連
# ーーーーーーーー


# イラストレーター取得
func get_illustrator():
	return $"🌏Illustrator"


# プログラムズ・ハブ取得
func get_programs_hub():
	return $"🌏Programmer/🛩️Hub"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"🌏TelopCoordinator"


# ーーーーーーーー
# その他
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# テロップ・コーディネーター表示
	self.get_telop_coordinator().show()

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
	self.get_illustrator().visible = true
	self.get_programs_hub().images.find_node("🗻崎川駅前").visible = true


# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.get_programs_hub().images.find_node("🗻崎川駅前").visible = false
