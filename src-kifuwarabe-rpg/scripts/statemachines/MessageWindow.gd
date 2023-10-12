# メッセージ・ウィンドウ・ステートマシーン（Message Window Statemachine；会話窓状態機械）
extends Node

class_name MessageWindowStatemachine

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
# ｜　　　　　　　＋ーーーーーーーー＋
# ｜　　　　　　　｜　０．不存在　　｜	※ウィンドウが存在しない唯一の状態
# ｜　　　　　　　＋ーーー＋ーーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　※メッセージ追加、ウィンドウは存在する状態へ
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　｜　１．タイプライター風表示中　｜
# ｜　　　｜　　　＋ーーー＋ーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜　バッファーが空になった
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーーーー＋
# ｜　　　｜　　　｜　２．完全表示中　｜
# ｜　　　｜　　　＋ーーー＋ーーーーー＋
# ｜　　　｜　　　　　　　※上位のオブジェクトに指示待ちの通知を送る
# ｜　　　｜　　　　　　　※これにて自律を停止
# ｜　　　｜
# ｜　　　｜
# ｜　　　｜　　　　　　　※外部からの入力
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　まだ続きがある。ページ・フォワード
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　すべての文字を吐き出した。オール・ページ・フラッシュド
#
enum States {None, Typewriter, Completed}

# 状態
var state = States.None

func is_none():
	return self.state == States.None

func is_typewriter():
	return self.state == States.Typewriter

func is_completed():
	return self.state == States.Completed

func scenario_seted():
	print("［ステートマシーン］　シナリオをセットした。タイプライター風表示へ状態遷移")
	self.state = States.Typewriter

func page_forward():
	print("［ステートマシーン］　ページ送りした。タイプライター風表示へ状態遷移")
	self.state = States.Typewriter

func all_character_pushed():
	print("［ステートマシーン］　全ての文字を出力した。完全表示中へ状態遷移")	
	self.state = States.Completed

func all_page_flushed():
	print("［ステートマシーン］　全てのページを送った。非表示へ状態遷移")	
	self.state = States.None
