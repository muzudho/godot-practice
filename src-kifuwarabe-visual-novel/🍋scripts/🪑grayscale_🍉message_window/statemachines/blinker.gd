# ブリンカー（Blinker；点滅するもの）
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
# ｜　　　　　　　　　　　｜　switch_off　※スイッチ・オフ
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※ブリンカーが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　switch_on　※スイッチ・オン
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーーーーーーー＋
# ｜　　　　　　　　｜　　BrightAtFirst 　　｜　※初回はすぐ表示
# ｜　　　　　　　　＋ーー＋ーーーーーーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　turn_off　※時間経過による消灯　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　Off 　　｜　※消える　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　◇ ーーーーーーーーーーーーーーーーーーーー＞＋＜ーー＋
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　turn_on　※時間経過による点灯　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーーーーーーー＋　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　｜　　Bright　　｜　※灯る　　　　　　　　　　　　｜
# ｜　　　｜　　　　＋ーー＋ーーーー＋　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　｜　　　　　　　｜　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　＋ーーーーーーー＋　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ｜　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　｜
# ＋ーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーーー＋
#
enum States {None, BrightAtFirst, Off, Bright}

# 状態
var state = States.None

# 関数の変数
var on_switched_on = null
var on_switched_off = null
var on_turned_on = null
var on_turned_off = null


func is_none():
	return self.state == States.None


func is_bright_at_first():
	return self.state == States.BrightAtFirst


func is_off():
	return self.state == States.Off


func is_bright():
	return self.state == States.Bright


func switch_on():
	if on_switched_on != null:
		on_switched_on.call()
	
	#print("［ブリンカー］　スイッチ・オン")
	self.state = States.BrightAtFirst


func switch_off():
	if on_switched_off != null:
		on_switched_off.call()
	
	#print("［ブリンカー］　スイッチ・オフ")
	self.state = States.None


func turn_on():
	if on_turned_on != null:
		on_turned_on.call()
	
	#print("［ブリンカー］　点灯")
	self.state = States.Bright


func turn_off():
	if on_turned_off != null:
		on_turned_off.call()
	
	#print("［ブリンカー］　消灯")
	self.state = States.Off
