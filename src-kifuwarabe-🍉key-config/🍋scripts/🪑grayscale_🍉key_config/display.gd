# ディスプレイ（Display；画面）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 親ノード取得
func owner_key_config_node():
	return $"../../📂🍉KeyConfig"


# イラストレーター・ノード取得
func the_illustrator_node():
	return self.owner_key_config_node().monkey_of_staff().illustrator_node()


# ーーーーーーーー
# 起動前設定
# ーーーーーーーー


func ready_in_staff():

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	
	# イラストレーター非表示
	the_illustrator_node().hide()
		
	# テロップ非表示
	self.owner_key_config_node().get_my_telop("TextBlock").visible = false
