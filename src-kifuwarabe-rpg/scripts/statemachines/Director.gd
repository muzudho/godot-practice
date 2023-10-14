# アシスタント・ディレクター・ステートマシーン（Assistant Director Statemachine；助監督状態機械）
extends Node

# class_name AssistantDirectorStatemachine

# 　状態遷移図
# 　ーーーーー
#
#　　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※部が存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　play_visual_novel
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーーーーーー＋
# ｜　　　｜　　　　｜　　PlayVisualNovel　　｜
# ｜　　　｜　　　　＋ーー＋ーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　再生　＃別の段落番号が書かれていた
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　stop　＃段落が終わった
#
enum States {
	None,
	PlayingVisualNovel,
	PlayingSystemMenu,
}

#	状態
var state = States.None

#	関数の変数
var on_played_visual_novel = null
var on_played_system_menu = null


#	停止中か？
func is_none():	
	return self.state == States.None

#	ビジュアルノベル　再生中か？
func is_playing_visual_novel():
	return self.state == States.PlayingVisualNovel

#	システム・メニュー　再生中か？
func is_playing_system_menu():
	return self.state == States.PlayingSystemMenu


#	再生　ビジュアルノベル部
func play_visual_novel():
	if on_played_visual_novel != null:
		on_played_visual_novel.call()
		
	print("［ステートマシーン］　ビジュアルノベルの再生")
	self.state = States.PlayingVisualNovel

#	再生　システム・メニュー部
func play_system_menu():
	if on_played_system_menu != null:
		on_played_system_menu.call()
		
	print("［ステートマシーン］　システム・メニューの再生")
	self.state = States.PlayingSystemMenu

#	停止
func stop():
	print("［ステートマシーン］　停止")
	self.state = States.None
