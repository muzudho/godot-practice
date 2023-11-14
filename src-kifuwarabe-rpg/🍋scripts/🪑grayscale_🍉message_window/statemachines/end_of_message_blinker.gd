# エンド・オブ・メッセージ・ブリンカー（End of message Blinker）
extends Node

# 状態遷移図
# ーーーーー
#
# 　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　decide　※決める
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※文末ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　think　※考える
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーー＋
# ｜　　　｜　　　　｜　　Staying 　　｜　※その場に居る
# ｜　　　｜　　　　＋ーー＋ーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　seek　※カーソルを動かす　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーーー＋　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　Floating　　｜　※点滅しながら　　　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーーー＋　　カーソル移動中　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　arrive  　※到着　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, Staying, Floating}

# 状態
var state = States.None

# 関数の変数
var on_none = null
var on_thought = null
var on_sought = null
var on_arrived = null


func is_none():
	return self.state == States.None


func is_staying():
	return self.state == States.Staying


func is_floating():
	return self.state == States.Floating


func decide():
	if on_none != null:
		on_none.call()
	
	#print("［文末ブリンカー］　決めた")
	self.state = States.None


func think():
	if on_thought != null:
		on_thought.call()
	
	#print("［文末ブリンカー］　悩む")
	self.state = States.Staying


func seek():
	if on_sought != null:
		on_sought.call()
	
	#print("［文末ブリンカー］　カーソルを動かす")
	self.state = States.Floating


func arrive():
	if on_arrived != null:
		on_arrived.call()
	
	#print("［文末ブリンカー］　カーソルは移動した")
	self.state = States.Staying
