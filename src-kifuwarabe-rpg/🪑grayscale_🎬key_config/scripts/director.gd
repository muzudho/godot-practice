# 🪑grayscale_🎬key_config
#	ディレクター（Director）
#
#	細かな設定は何もできないので、ソースを直接カスタマイズすること
extends Node2D


# 値はボタン番号。レバーは +1000
var key_config = {
	# 仮想キー（１）決定ボタン、メッセージ送りボタン
	&"VK_Ok" : -1,
	# 仮想キー（２）キャンセルボタン、メニューボタン
	&"VK_Cancel" : -1,
	# 仮想キー（３）メッセージ早送りボタン
	&"VK_FastForward" : -1,
}


# キー・コンフィグ画面を始めるタイミングで以下を呼出す
func entry():
	$"KeyConfigArtist".entry()


func on_exit():
	print("［キーコンフィグ］　完了")
	# 例えば、シーンの外側の１階層上の `Director` ノードへアクセスする方法
	$"../../Director".on_key_config_exited()


# キー・コンフィグで必要
func on_process(delta):
	$"KeyConfigArtist".on_process(delta)


func on_unhandled_input(event):
	# キー・コンフィグで必要
	$"KeyConfigArtist".on_unhandled_input(event)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	# このシーンを呼出して利用するなら、以下をコメントアウトすること
	#self.entry()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# このシーンを呼出して利用するなら、以下をコメントアウトすること
	#self.on_process(delta)


func _unhandled_input(event):
	pass
	# このシーンを呼出して利用するなら、以下をコメントアウトすること
	#self.on_unhandled_input(event)
