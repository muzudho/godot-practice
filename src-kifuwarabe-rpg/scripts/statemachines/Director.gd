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
# ｜　　　　　　　　　　　｜　ビジュアルノベル部＿再生　＃ステートマシーン外部からの開始の合図。段落番号を渡される
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　｜　１．ビジュアルノベル部＿再生中　｜
# ｜　　　｜　　　＋ーーー＋ーーーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　再生　＃別の段落番号が書かれていた
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　停止　＃段落が終わった
#
enum States {None, PlayingVisualNovelDepartment}

# 状態
var state = States.None

# 停止中か？
func is_none():	
	return self.state == States.None

# ビジュアルノベル部　再生中か？
func is_playing_visual_novel_department():
	return self.state == States.PlayingVisualNovelDepartment

# 再生
func play_visual_novel_department():
	print("［ステートマシーン］　ビジュアルノベル部のパラグラフの再生")
	self.state = States.PlayingVisualNovelDepartment

# 停止
func stop():
	print("［ステートマシーン］　停止")
	self.state = States.None
