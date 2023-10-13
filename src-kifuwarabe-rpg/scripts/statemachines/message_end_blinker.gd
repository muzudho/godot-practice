#	メッセージエンド・ブリンカー（Message-end Blinker）
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
# ｜　　　　　　　　　　　｜　resolved　※解決済み
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※メッセージエンド・ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　worry　※悩む
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
# ｜　　　｜　　　　　　　｜　move　※カーソルを動かす　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーーーーー＋　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　BlinkMoving 　　｜　※点滅しながら　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーーーーー＋　　カーソル移動中　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　moved 　※移動完了　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, BlinkHere, BlinkMoving}

# 状態
var state = States.None

# 関数の変数
var on_resolved = null
var on_worry = null
var on_move = null
var on_moved = null


func is_none():
	return self.state == States.None


func is_blink_here():
	return self.state == States.BlinkHere


func is_blink_moving():
	return self.state == States.BlinkMoving


func resolved():
	if on_resolved != null:
		on_resolved.call()
	
	print("［メッセージエンド・ブリンカー］　解決済み")
	self.state = States.None


func worry():
	if on_worry != null:
		on_worry.call()
	
	print("［メッセージエンド・ブリンカー］　悩む")
	self.state = States.BlinkHere


func move():
	if on_move != null:
		on_move.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルを動かす")
	self.state = States.BlinkMoving


func moved():
	if on_moved != null:
		on_moved.call()
	
	print("［メッセージエンド・ブリンカー］　カーソルは移動した")
	self.state = States.BlinkHere
