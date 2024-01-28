# ディスプレイ（Display；画面）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動前設定
# ーーーーーーーー


func ready_in_staff():

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	
	# イラストレーター非表示
	self.monkey().the_illustrator_node().hide()
		
	# テロップ非表示
	self.monkey().owner_key_config_node().get_my_telop("TextBlock").visible = false
