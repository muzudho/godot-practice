#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		システムメニュー部門
extends Node


#	選択肢と移動先
var choices_mappings = {
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
		m_wnd:		■中央
		choice:		1,2
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
		#m_wnd:		■中央, hide
		#goto:		§システムメニュー画面
		#m_wnd:		■下
		department:	📗ビジュアルノベル部門
		""",
	],
	# 終わるなら
	"§終了" : [
		"""\
		!
		m_wnd:		■中央, hide
		quit:
		"""
	],
}
