# アシスタント・ディレクター・ステートマシーン（Assistant Director Statemachine；助監督状態機械）
extends Node

class_name AssistantDirectorStatemachine

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　＋ーーーーー＋
# 　　　　　　　　　｜　はじめ　｜
# 　　　　　　　　　＋ーー＋ーー＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　＋ーーーーーーー＋
# ｜　　　　　　　｜　０．停止中　｜
# ｜　　　　　　　＋ーーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　再生　＃ステートマシーン外部からの開始の合図。段落番号を渡される
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーー＋
# ｜　　　｜　　　｜　１．再生中　｜
# ｜　　　｜　　　＋ーーー＋ーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　再生　＃別の段落番号が書かれていた
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　停止　＃段落が終わった
#
enum States {None, Playing}

# 状態
var state = States.None

# 停止中か？
func is_none():	
	return self.state == States.None

# 再生中か？
func is_playing():
	return self.state == States.Playing

# 再生
func play(paragraph_no):
	print("［ステートマシーン］　パラグラフの再生")
	self.state = States.Playing

# 停止
func stop(paragraph_no):
	print("［ステートマシーン］　停止")
	self.state = States.None
