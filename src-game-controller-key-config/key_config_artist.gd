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


func on_process(_delta):
	pass
