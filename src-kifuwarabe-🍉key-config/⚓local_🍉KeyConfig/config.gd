# コンフィグ（Config；構成）
#	初期設定
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ディレクター・ハブ取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# キー・コンフィグ
# ーーーーーーーー


# キーコンフィグ開始時
func on_key_config_entered():
	# 背景
	self.monkey().illustrator_node().visible = true
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = true


# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = false
