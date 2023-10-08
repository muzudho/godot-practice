# シナリオ・ブック（Scenario Book；台本の本）
# 　シナリオ・ブックという名前が付いているが、大した機能はない
extends Node

# インデックス（Index；索引）
var index = {
	# 索引
	"タイトル画面" : {
		# 選択肢の行番号と、移動先索引
		1 : "はじまり",
		2 : "終了",
	},
	"はじまり" : {
		# 選択肢の行番号と、移動先索引
		1 : "６筋の７段目の駒を６段目に突く",
		2 : "角道を止める",
	},
}

# この書き方だと、実はインデントのタブが台詞データとして入っている。
# インデントのタブは、プログラム側で省く処理を入れておくとする
var document = {
	"タイトル画面":[
		"""\
		!
		bgm:	タイトル
		scene:	タイトル
		bg:		崎川駅前
		choice:	1,2
		msg:	下
		""",		
		"""\
		　・スタート
		　・終了
		""",		
	],
	# 終わるなら
	"終了" : [
		"""\
		!
		quit:
		"""
	],
	# ゲーム開始
	"はじまり":[
		"""\
		!
		scene:
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		２０２３年５月２日（火）
		ＮＲ崎川駅
		""",
		
# TODO 練習消す
#		"""\
#		!
#		msg:	中央
#		""",
#		"""\
#		!
#		msg:	下
#		""",
		
		"""\
		ひよ子
		「ゴールデンウィークに崎川駅で降りると
		　コンピュータ将棋の季節を感じるわね～
		""",
		"""\
		お父ん
		「いつも晴れてんな。
		　１年の中で　５月が一番　過ごしやすい
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「お父ん、さっきから
		　くるくる回ってないか？まっすぐ歩けだぜ
		""",
		"""\
		お父ん
		「とぅげったーに写真が乗ってないと雰囲気
		　出ないだろ。スマホで景色撮るんだぜ
		""",
		"""\
		ひよ子
		「この道には　いつもツツジが咲いてんのよ
		　崎川市が　気合を入れて　咲かせてんのよ
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		!
		bg:		崎川駅周辺地図
		scene:	崎川駅周辺地図
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「崎川市最強振興会館に来るのも
		　今年で何回目だろうな？」
		""",
		"""\
		ひよ子
		「第２６回の選手権からだから
		　８回目ね
		""",
		"""\
		きふわらべ
		「選手権に９回参加して
		　そのうち８回が最振（さいしん）会館だぜ
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「えっ　そんなに？
		""",
		#	崎川市最強振興会館
		"""\
		!
		scene:
		bgm:
		bg:		イベントルーム
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おはようございまーす
		""",
		"""\
		ひよ子
		「席はまだ決まってないから
		　好きなところに座りましょう
		""",
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
		# 将棋盤を表示
		"""\
		!
		cwnd:	将棋盤
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「横着しないで　ちゃんと　将棋盤を使って
		　説明しなさい
		""",
		"""\
		!
		cwnd: ファイルとランク
		""",
		"""\
		お父ん
		「右上が始まりで、左へ１筋、２筋・・・
		　下へａ段、ｂ段・・・　だぜ
		""",
		"""\
		!
		cwnd: 将棋盤
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
		# 音楽鳴らす
		"""\
		!
		bgm: きふわらべファイター２
		""",
		"""\
		きふわらべ
		「お父ん、なんで唐揚げを食べてるんだぜ？
		　ダイエットはどうした？野菜食べろだぜ！
		""",
		# 中央ビューイング・ウィンドウを非表示
		"""\
		!
		cwnd:
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
		# 無音にする
		"""\
		!
		bgm:
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
		!
		choice: 1,2
		""",
		"""\
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
		""",
		"""\
		!
		goto: エンディング
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
		""",
		"""\
		!
		goto: エンディング
		"""
	],
	"エンディング":[
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「は～　腹が減ったなあ
		　昼は何を食べようかなあ
		""",
		"""\
		きふわらべ
		「コンビニのグリルチキンを食べろだぜ
		""",
		"""\
		!
		bgm:	エンディング
		bg:		エンディング
		scene:	エンディング
		"""
	],
}
