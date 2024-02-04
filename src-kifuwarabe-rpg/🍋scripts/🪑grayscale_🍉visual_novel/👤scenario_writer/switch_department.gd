# スイッチ・デパートメント（Switch Department；部門切替え）
#	このノード名の `📘DepartmentControl` は変更不可
#	部門の切替えを司る
extends Node


# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
#
# 	「〇〇部門」で、「〇〇キー」（このゲーム独自の仮想キー名）を押したときに実行されるト書き
var key_pressed_stage_directions = {
	# 部門名
	&"📗会話部門_🍉VisualNovel" : {
		# このゲーム独自の仮想キー名を使う
		# キャンセルボタンでシステムメニューを開く
		&"VK_Cancel" :
			# ト書き。段落は１つまで
			"""\
			!
			department:		📗会話システムメニュー部門_🍉VisualNovel
			goto:			¶システムメニュー画面
			""",
	},
	&"📗会話システムメニュー部門_🍉VisualNovel" : {
		# キャンセルボタンでノベルに戻る
		&"VK_Cancel" :
			"""\
			!
			department:		📗会話部門_🍉VisualNovel
			""",
	},
}
