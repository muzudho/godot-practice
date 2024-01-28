# ステートマシン（Statemachine；状態遷移機械）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# Terminated, IntervalUntilPrompt, Prompt, IntervalUntilInput, WaitingForInput, InputOk の６つ。 Wait を入れないと反応過敏になってしまう
var state = &"Terminated"


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


# プロンプトを表示しろ
func go_prompt():
	self.state = &"Prompt"


# 入力の前に待て
func wait_before_input():
	self.state = &"IntervalUntilInput"


# キー・コンフィグ画面を終了
func exit():
	self.state = &"Terminated"
