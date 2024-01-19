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

var key_config_background_image_name = &"🗻崎川駅前"

# キーコンフィグ完了時
func on_key_config_exited():
	print("［キーコンフィグ］　完了")

	# 背景
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = false
