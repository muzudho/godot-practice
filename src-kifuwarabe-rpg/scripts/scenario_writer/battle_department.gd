#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		バトル部門
extends Node


#	選択肢と移動先
var choices_mappings = {
}

# この書き方だと、実はインデントのタブが台詞データとして入っている。
# インデントのタブは、プログラム側で省く処理を入れておくとする
var document = {
	#	初戦闘シーン
	"§初戦闘シーン":[
		# コダック
		"""\
		!
		telop:		崎川駅周辺地図, hide
		bg:			崎川駅周辺地図, hide
		bg:			戦闘シーン
		bg:			川掘町線ロード
		bgm:		🎵バトル１, 8.6
		monster:	きふわらべ
		monster:	%arg_monster%
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おっと　戦闘シーンはまだ
		　できてないらしいぜ
		""",
		"""\
		!
		monster:	%arg_monster%, hide
		""",
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
	"§２回目戦闘シーン":[
		"""\
		!
		monster:	%arg_monster%
		bgm:		🎵バトル２
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「物騒ねぇ
		""",
		"""\
		!
		monster:	%arg_monster%, hide
		""",
		"""\
		!
		monster:	れさ改
		bgm:		🎵バトル３
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「戦闘なんか　これから
		　いっぱい　するのに……
		""",
		"""\
		!
		monster:	きふわらべ, hide
		monster:	れさ改, hide
		""",
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
}
