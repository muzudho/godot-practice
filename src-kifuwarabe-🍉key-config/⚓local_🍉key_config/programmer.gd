# プログラマー（Programmer）
#
#	⚓キーコンフィグ用
extends Node


# ーーーーーーーー
# アドオン・スロット
# ーーーーーーーー


# BGMノードのキャッシュ
var bg_musics = null

# イラスト・ノードのキャッシュ
var images = null

# サウンド・エフェクト（Sound Effect, Sound FX；効果音）のキャッシュ
var sound_fx = null

# テロップのキャッシュ
var telops = null


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ディレクター・ハブ取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 起動前設定
# ーーーーーーーー


func _ready():
	self.bg_musics = MonkeyHand.create(
			self.monkey().of_staff().musician_bg_musics())		# 探す場所

	self.images = MonkeyHand.create(
			self.monkey().of_staff().illustrator_node())			# 探す場所

	self.sound_fx = MonkeyHand.create(
			self.monkey().of_staff().musician_sound_fx())			# 探す場所

	self.telops = MonkeyHand.create(
			self.monkey().of_staff().telop_coordinator())	# 探す場所


func ready_in_staff():
	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	#
	# 開発中にいじったものが残ってるかもしれないから、掃除
	
	# グリッドは隠す
	self.monkey().of_staff().grid_node().hide()

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー

	# テロップ・コーディネーター表示
	self.monkey().of_staff().telop_coordinator().show()

	# ーーーーーーーー
	# 起動前設定
	# ーーーーーーーー
	self.monkey().key_config_node().ready_in_staff()

	# ーーーーーーーー
	# 開始
	# ーーーーーーーー
	self.monkey().key_config_node().entry()


# ーーーーーーーー
# 起動
# ーーーーーーーー


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# キーコンフィグで必要です
	self.monkey().key_config_node().on_process(delta)


# ーーーーーーーー
# 入力
# ーーーーーーーー


func _unhandled_input(event):
	# キーコンフィグで必要です
	self.monkey().key_config_node().on_unhandled_input(event)


func on_key_config_entered():
	print("［キーコンフィグ］　開始")
	
	# 背景表示
	self.monkey().of_staff().illustrator_node().visible = true
	self.monkey().of_staff().programmer().owner_node().images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = true


func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景消去
	self.monkey().of_staff().programmer().owner_node().images.find_node(
		str(self.monkey().of_staff().config_node().key_config_background_image_name)
	).visible = false
