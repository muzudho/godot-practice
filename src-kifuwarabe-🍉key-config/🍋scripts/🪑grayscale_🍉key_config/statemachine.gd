# ステートマシン（Statemachine；状態遷移機械）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

func handler():
	return $"Handler"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# Terminated, IntervalUntilPrompt, Prompt, IntervalUntilInput, WaitingForInput, InputOk の６つ。 Wait を入れないと反応過敏になってしまう
var state = &"Terminated"

var behaviour_of_entry = null
var behaviour_of_exit = null


# ーーーーーーーー
# 状態確認
# ーーーーーーーー

# 止まっているか？
func is_terminated():
	return self.state == &"Terminated"


# ーーーーーーーー
# 動作
# ーーーーーーーー

# キー・コンフィグ画面に入る
func entry():
	# これで、入力受付と時計が働きだす
	self.state = &"IntervalUntilPrompt"
	self.behaviour_of_entry.call()


# キー・コンフィグ画面を終了
func exit():
	self.state = &"Terminated"
	self.behaviour_of_exit.call()


# 入力を受け付けた
func input_accepted():
	self.state = &"IntervalUntilPrompt"
	self.handler().on_input_accepted()


# プロンプトを表示しろ
func go_prompt():
	self.state = &"Prompt"


# 入力の前に待て
func wait_before_input(reason):
	self.state = &"IntervalUntilInput"
	self.handler().on_wait_before_input(reason)


# 入力しろ
func go_input():
	self.state = &"WaitingForInput"
	self.handler().on_go_input()
