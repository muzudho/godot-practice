# ステートマシン・ビヘイビア（Statemachine Behaviour；状態遷移機械の振る舞い）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー


func _ready():
	self.monkey().statemachine().behaviour_of_entry = behaviour_of_entry
	self.monkey().statemachine().behaviour_of_exit = behaviour_of_exit


# ーーーーーーーー
# イベントハンドラ
# ーーーーーーーー

# 開始時の振る舞い
func behaviour_of_entry():
	# ローカルのプログラマー・ノードへアクセス
	self.monkey().the_programmer_node().on_key_config_entered()

# 終了時の振る舞い
func behaviour_of_exit():
	self.monkey().moderator().clear_count_by_step()
	
	# 画面表示、演奏
	self.monkey().display().on_exit()

	# キーコンフィグ呼出し元
	self.monkey().owner_key_config_node().on_exit()
