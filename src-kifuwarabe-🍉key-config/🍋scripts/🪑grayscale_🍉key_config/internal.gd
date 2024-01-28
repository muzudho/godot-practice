# インターナル（Internal；内部）
#
#	内部で共有する変数など
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0

# キーコンフィグのキーの数に対応
var key_config_item_number = 0

# 前回入力したキーの仮想名
var previous_virtual_key_name = &""

# 仮想キー名
var virtual_key_name = &""
