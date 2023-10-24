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
			# `%hide_current_it_then_push_it_to_stack%` - 現在のウィンドウを隠し、そして、それをスタックへプッシュする
			"""\
			!
			m_wnd:			%hide_current_it_then_push_it_to_stack%
			department:		📗システムメニュー部門
			goto:			§システムメニュー画面
			""",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE :
			# `%pop_it_from_stack_then_show_current_it%` - スタックからウィンドウをポップし、そして、それを見せる
			# TODO システムメニュー部門に切り替わってから、新しく表示したウィンドウを全て閉じ、新しく閉じたウィンドウを全て表示したい（原状復帰）
			"""\
			!
			
			# ■中央 ウィンドウとは限らないのでは？
			m_wnd:			■中央, hide
			
			department:		📗ビジュアルノベル部門
			m_wnd:			%pop_it_from_stack_then_show_current_it%
			""",
	},
}
