# シナリオ・ライター・メイン（Scenario Writer Main）
#	この `Main.gd` の名前は変更不可
#	ここから始まる最初のファイル
extends Node


# 最初に実行する部門をここに書く
var start_department = "VisualNovelDepartment"


# どの部門で、そのキーを押されたら、どの部門へ移動するか？
var key_pressed_mappings = {
	"VisualNovelDepartment" : {
		KEY_ESCAPE : "SystemMenuDepartment",
	},
	"SystemMenuDepartment" : {
		KEY_ESCAPE : "VisualNovelDepartment",
	},
}
