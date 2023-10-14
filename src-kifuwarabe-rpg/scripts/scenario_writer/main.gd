# シナリオ・ライター・メイン（Scenario Writer Main）
#	この `Main.gd` の名前は変更不可
#	ここから始まる最初のファイル
extends Node


# 最初に実行する部門をここに書く
var start_department = "ビジュアルノベル部門"


# 各部門の初期プロパティ
var department_initial_properties = {
	"ビジュアルノベル部門" : {
		# メッセージを出力する対象となるウィンドウの名前（文字列）。ヌルにせず、必ず何か入れておいた方がデバッグしやすい
		"message_window_name_obj" : &"下",		# StringName 型 シンタックス・シュガー
		# 最初に実行される段落名
		"paragraph_name" : "タイトル画面",
	},
	"システムメニュー部門" : {
		"message_window_name_obj" : &"中央",
		"paragraph_name" : "システムメニュー画面",
	},	
}


# どの部門で、そのキーを押されたら、どの部門へ移動するか？
var key_pressed_mappings = {
	"ビジュアルノベル部門" : {
		KEY_ESCAPE : "システムメニュー部門",
	},
	"システムメニュー部門" : {
		KEY_ESCAPE : "ビジュアルノベル部門",
	},
}
