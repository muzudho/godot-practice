# ステートマシン（Statemachine；状態遷移機械）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# `.entry()` を呼び出すと真にする。キー・コンフィグが完了するとまた偽にセットする
var is_enabled = false

# Terminated, IntervalUntilPrompt, Prompt, IntervalUntilInput, WaitingForInput, InputOk の６つ。 Wait を入れないと反応過敏になってしまう
var state = &"Terminated"


# ーーーーーーーー
# 動作
# ーーーーーーーー

# キー・コンフィグ画面に入る
func entry():
	# これで、入力受付と時計が働きだす
	self.state = &"IntervalUntilPrompt"
	self.is_enabled = true


# キー・コンフィグ画面を終了
func exit():
	self.state = &"Terminated"
	self.is_enabled = false
