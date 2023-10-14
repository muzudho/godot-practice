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
# ｜　　　　　　　　　　　｜　all_pages_flushed　※すべての文字を吐き出した
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーーーーーー＋
# ｜　　　　　　　　｜　　None　　｜　※ウィンドウが存在しない唯一の状態
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　talk　※メッセージ追加、ウィンドウは存在する状態へ
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　　＋ーーーーーーーーーー＋
# ｜　　　｜　　　　｜　　Typewriter 　　｜　※タイプライター風表示中
# ｜　　　｜　　　　＋ーー＋ーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜　all_characters_pushed　※バッファーが空になった
# ｜　　　｜　　　　　　　｜
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
# ｜　　　＋ーーーー＜ーー＋　page_forward　※まだ続きがある。空欄にするだけで、ウィンドウは消さない
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋
#
enum States {None, Typewriter, Completed}

# 状態
var state = States.None

# 関数の変数
var on_talk = null
var on_page_forward = null
var on_all_characters_pushed = null
var on_all_pages_flushed = null


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
	if on_page_forward != null:
		on_page_forward.call()
	
	print("［ステートマシーン］　ページ送りした。タイプライター風表示へ状態遷移")
	self.state = States.Typewriter

func all_characters_pushed():
	if on_all_characters_pushed != null:
		on_all_characters_pushed.call()

	print("［ステートマシーン］　全ての文字を出力した。完全表示中へ状態遷移")	
	self.state = States.Completed

func all_pages_flushed():
	if on_all_pages_flushed != null:
		on_all_pages_flushed.call()

	print("［ステートマシーン］　全てのページを送った。非表示へ状態遷移")	
	self.state = States.None
