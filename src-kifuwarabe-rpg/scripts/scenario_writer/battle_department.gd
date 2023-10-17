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
		bg:			🗻川掘町線ロード
		bg:			🗻戦闘シーン
		telop:		戦闘シーン
		bgm:		🎵バトル１, 8.6
		#monster:	きふわらべ
		monster:	%arg_monster%
		""",
		# 戦闘開始
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
		# 戦闘終了
		"""\
		!
		telop:		戦闘シーン, hide
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
	"§２回目戦闘シーン":[
		"""\
		!
		telop:		戦闘シーン
		monster:	%arg_monster%
		bgm:		🎵バトル２
		""",
		# 戦闘開始
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「物騒ねぇ
		""",
		"""\
		!
		monster:	%arg_monster%, hide
		""",
		# 戦闘終了
		"""\
		!
		telop:		戦闘シーン, hide
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
	"§３回目戦闘シーン":[
		"""\
		!
		telop:		戦闘シーン
		monster:	%arg_monster%
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
		#monster:	きふわらべ, hide
		monster:	%arg_monster%, hide
		""",
		# 戦闘終了
		"""\
		!
		telop:		戦闘シーン, hide
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
}
