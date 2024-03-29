# スイッチ・デパートメント（Switch Department；部門切替え）
#	このノード名の `📘DepartmentControl` は変更不可
#	部門の切替えを司る
extends Node


# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
#
# 	キーボード、ゲーム・コントローラーのいずれでも対応できるように、バーチャル・キー（Vertual Key, VK；仮想鍵）にしたい
var key_pressed_stage_directions = {
	# 部門名
	&"📗会話部門_🍉Battle" : {
		# このゲーム独自の仮想キー名を使う
		# キャンセルボタンでシステムメニューを開く
		&"VK_Cancel" :
			# 段落は１つまで
			"""\
			!
			department:		📗会話システムメニュー部門_🍉Battle
			goto:			¶システムメニュー画面
			""",
	},
	&"📗会話システムメニュー部門_🍉Battle" : {
		# キャンセルボタンでノベルに戻る
		&"VK_Cancel" :
			"""\
			!
			department:		📗会話部門_🍉Battle
			""",
	},
}
