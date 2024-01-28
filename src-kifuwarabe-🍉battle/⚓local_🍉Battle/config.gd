# コンフィグ（Config；構成）
#	初期設定
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# キー・コンフィグ
# ーーーーーーーー

var key_config_background_image_name = &"🗻崎川駅前"


# ーーーーーーーー
# ビジュアル・ノベル
# ーーーーーーーー

# 最初に実行する部門をここに書く。頭に「📗」を付けているのは見やすさのためで、付けなくても構わない
var start_department_name = &"📗会話部門_🍉Battle"
