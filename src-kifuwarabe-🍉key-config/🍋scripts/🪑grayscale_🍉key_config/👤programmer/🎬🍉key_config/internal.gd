# インターナル（Internal；内部）
#
#	内部で共有する変数など
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
#
# 該当なしなら：　整数。-1
# ボタンなら：　整数。ボタン番号（1000個もないはず）
# レバーなら：　整数。レバーの軸の番号に +1000 したもの
# キーボードのキーなら：　キー名
var button_symbol = -1

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0

# キーコンフィグのキーの数に対応
var key_config_item_number = 0

# 前回入力したキーの仮想名
var previous_virtual_key_name = &""

# 仮想キー名
var virtual_key_name = &""


# ーーーーーーーー
# アクセッサ―
# ーーーーーーーー

func clear_count_by_step():
	self.button_symbol = -1
	self.counter_of_wait = 0.0
