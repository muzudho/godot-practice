# シナリオ・ブック（Scenario Book；台本の本）
# 　シナリオ・ブックという名前が付いているが、大した機能はない
extends Node

# インデックス（Index；索引）
var index = {
	# 索引
	"はじまり" : {
		# 選択肢の行番号と、移動先索引
		1 : "６筋の７段目の駒を６段目に突く",
		2 : "角道を止める",
	},
}

# この書き方だと、実はインデントのタブが台詞データとして入っている。
# インデントのタブは省く処理を入れておくとする
var document = {
	"はじまり":[
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「お父ん、知ってたら教えてくれだぜ。
		　エスフェン(SFEN)の 7g7f って何だぜ？
		""",
		"""\
		お父ん
		「あー。７筋の７段目の駒を６段目に
		　突くことだぜ。分かったら　もう寝ろ
		""",
		"""\
		きふわらべ
		「3c3d　って何だぜ？
		""",
		"""\
		お父ん
		「角換わりだろ。
		　もう寝ろ
		""",
		"""\
		きふわらべ
		「お父ん、なんで唐揚げを食べてるんだぜ？
		　ダイエットはどうした？野菜食べろだぜ！
		""",
		"""\
		お父ん
		「元気になりたくて唐揚げを食べるんだぜ
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		　カロリー計算しようと思ったときもあった
		　上限いっぱいまで食べてしまうので止めた
		""",
		"""\
		ひよ子
		「カロリーを　炭水化物、糖質、脂質で
		　補うのを止めなさい
		""",
		"""\
		ひよ子
		「ワラちゃん。 6g6f よ
		""",
		"""\
		きふわらべ
		「ろく　じー　ろく　えふ？
		　それは……
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		!choice 1,2
		　・６筋の７段目の駒を６段目に突く
		　・角道を止める
		""",
	],
	"６筋の７段目の駒を６段目に突く":[
		"""\
		お父ん
		「覚えたか
		""",
		"""\
		きふわらべ
		「お父んも覚えろだぜ
		"""
	],
	"角道を止める":[
		"""\
		お父ん
		「難しいこと知ってんな
		""",
		"""\
		きふわらべ
		「矢倉も作れるしな
		"""
	],
}
