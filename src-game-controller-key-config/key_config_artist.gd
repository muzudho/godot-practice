# キー・コンフィグ・アーティスト（Key Config Artist）
extends Node


# 値はボタン番号。レバーは +1000
var key_config = {
	# 仮想キー（１）決定ボタン、メッセージ送りボタン
	&"VK_Ok" : -1,
	# 仮想キー（２）キャンセルボタン、メニューボタン
	&"VK_Cancel" : -1,
	# 仮想キー（３）メッセージ早送りボタン
	&"VK_FastForward" : -1,
}

var re_button = RegEx.new()
var re_lever = RegEx.new()

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0
var current_step = 0
# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var turn_state = &"WaitForPrompt"


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return $"../TelopCoordinator"


# 音楽家取得
func get_musician():
	return $"../Musician"


# ボタンが重複するか？
func is_key_duplicated(button_number):
	return button_number in self.key_config.values()


# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# キーコンフィグ画面に入る
func entry():
	self.get_telop_coordinator().get_node("TextBlock").text = """\
	＊　＊　＊
	"""


func set_key_ok():
	self.get_telop_coordinator().get_node("TextBlock").text = "＊　＊　＊"


# キーコンフィグ　ボタン設定が拒否
func set_key_denied():
	self.get_musician().get_node("SE/🔔キーコンフィグ不可音").play()
	self.get_telop_coordinator().get_node("TextBlock").text = "他のキーを選んでください"


func on_process(_delta):
	pass
