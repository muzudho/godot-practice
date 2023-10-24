# スイッチ・デパートメント（Switch Department；部門切替え）
#	このノード名の `SwitchDepartment` は変更不可
#	部門の切替えを司る
extends Node


# 最初に実行する部門をここに書く。頭に「📗」を付けているのは見やすさのためで、付けなくても構わない
var start_department_name = &"📗ビジュアルノベル部門"


# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
var key_pressed_stage_directions = {
	"📗ビジュアルノベル部門" : {
		KEY_ESCAPE :
			"""\
			!
			department:		📗システムメニュー部門
			goto:			§システムメニュー画面
			""",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE :
			"""\
			!
			department:		📗ビジュアルノベル部門
			""",
	},
}
