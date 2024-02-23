# メッセージ・ウィンドウ・ステートマシーン（Message Window Statemachine；伝言窓状態機械）
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
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　　＋ーー＋ーーー＋
# ｜　　　　　　　　｜　　None　　｜　※ウィンドウは存在せず、活動もしていない状態だが、
# ｜　　　　　　　　＋ーー＋ーーー＋　　メッセージを溜め込むことはできる
# ｜　　　　　　　　　　　｜
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
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　page_forward　※ページ送りしたが、まだ続きがある。空欄にするだけで、ウィンドウは消さない
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　all_pages_flushed　※すべての文字を吐き出した
#
enum States {None, Typewriter, Completed}

# 状態
var state = States.None

# 関数の変数
var on_talked_2 = null
var on_page_forward = null
var on_all_characters_pushed = null
var on_all_pages_flushed = null


func is_none():
	return self.state == States.None


func is_typewriter():
	return self.state == States.Typewriter


func is_completed():
	return self.state == States.Completed


# TODO こちらを使いたい
func talk():
	if on_talked_2 != null:
		on_talked_2.call()
	
	#print("［状態機械　伝言窓］　シナリオをセットした。タイプライター風表示へ状態遷移")
	self.state = States.Typewriter


func page_forward():
	if on_page_forward != null:
		on_page_forward.call()
	
	#print("［状態機械　伝言窓］　ページ送りした。タイプライター風表示へ状態遷移")
	self.state = States.Typewriter


func all_characters_pushed():
	if on_all_characters_pushed != null:
		on_all_characters_pushed.call()

	#print("［状態機械　伝言窓］　全ての文字を出力した。完全表示中へ状態遷移")	
	self.state = States.Completed


func all_pages_flushed():
	if on_all_pages_flushed != null:
		on_all_pages_flushed.call()

	#print("［状態機械　伝言窓］　全てのページを送った。非表示へ状態遷移")	
	self.state = States.None
