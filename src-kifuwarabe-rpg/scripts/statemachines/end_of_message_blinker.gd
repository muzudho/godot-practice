#	エンド・オブ・メッセージ・ブリンカー（End of message Blinker）
extends Node

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　deciside　※決める
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※メッセージエンド・ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　think　※考える
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーー＋
# ｜　　　｜　　　　｜　　BlinkHere 　　｜　※その場で点滅中
# ｜　　　｜　　　　＋ーー＋ーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　seek　※カーソルを動かす　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーーーーー＋　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　BlinkMoving 　　｜　※点滅しながら　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーーーーー＋　　カーソル移動中　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　arrive  　※到着　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, BlinkHere, BlinkMoving}

# 状態
var state = States.None

# 関数の変数
var on_decisided = null
var on_thought = null
var on_sought = null
var on_arrived = null


func is_none():
	return self.state == States.None


func is_blink_here():
	return self.state == States.BlinkHere


func is_blink_moving():
	return self.state == States.BlinkMoving


func deciside():
	if on_decisided != null:
		on_decisided.call()
	
	print("［メッセージエンド・ブリンカー］　決めた")
	self.state = States.None


func think():
	if on_thought != null:
		on_thought.call()
	
	print("［メッセージエンド・ブリンカー］　悩む")
	self.state = States.BlinkHere


func seek():
	if on_sought != null:
		on_sought.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルを動かす")
	self.state = States.BlinkMoving


func arrive():
	if on_arrived != null:
		on_arrived.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルは移動した")
	self.state = States.BlinkHere
