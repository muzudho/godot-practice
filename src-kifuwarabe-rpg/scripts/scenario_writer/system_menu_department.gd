#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		システム・メニュー部編
extends Node

# インデックス（Index；索引）
var index = {
	# 索引
	"§システムメニュー画面" : {
		# 選択肢の行番号と、移動先索引
		1 : "§再開",
		2 : "§終了",
	},
}

# この書き方だと、実はインデントのタブが台詞データとして入っている。
# インデントのタブは、プログラム側で省く処理を入れておくとする
var document = {
	"§システムメニュー画面":[
		"""\
		!
		choice:	1,2
		m-wnd:	中央
		""",
		"""\
		　・再開
		　・終了
		""",
	],
	# 再開するなら
	"§再開" : [
		# 部門変更
		"""\
		!
		goto:		§システムメニュー画面
		department:	📗ビジュアルノベル部門
		""",
		# FIXME このままだと、終わってしまって次に表示されない
	],
	# 終わるなら
	"§終了" : [
		"""\
		!
		quit:
		"""
	],
}
