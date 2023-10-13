# メッセージ・ウィンドウ・ステートマシーン（Message Window Statemachine；会話窓状態機械）
extends Node

class_name MessageWindowStatemachine

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　　　　Entry
# 　　　　　　　　　　　　＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※ウィンドウが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　Talk　※メッセージ追加、ウィンドウは存在する状態へ
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーーー＋
# ｜　　　｜　　　　｜　　Typewriter 　　｜　※タイプライター風表示中
# ｜　　　｜　　　　＋ーー＋ーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜　バッファーが空になった
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーー＋
# ｜　　　｜　　　　｜　　Completed 　　｜　※完全表示中
# ｜　　　｜　　　　＋ーー＋ーーーーーー＋
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

# 関数の変数
var on_talk = null


func is_none():
	return self.state == States.None

func is_typewriter():
	return self.state == States.Typewriter

func is_completed():
	return self.state == States.Completed

func talk(text, choices_row_numbers = null):
	if on_talk != null:
		on_talk.call(text, choices_row_numbers)
	
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
