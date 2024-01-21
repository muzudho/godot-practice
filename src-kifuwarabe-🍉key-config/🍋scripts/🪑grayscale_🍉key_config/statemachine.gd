# ステートマシン（Statemachine；状態遷移機械）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var state = &"WaitForPrompt"
