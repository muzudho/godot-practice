# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# シナリオライターズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏ScenarioWriter/🛩️Hub_🍉VisualNovel",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# 台本
#
# 	- この scenario_document` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#	- この書き方だと、実はインデントのタブが台詞データとして入っていますが、プログラム側で省きます
#
var scenario_document = {

	# このキーは［セクション名］と呼ぶことにします
	#
	#	- 頭に「§」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの scenario_document` のセクション名と被らないように運用してください
	#
	"§タイトル画面":[
		"""\
		!
		bg_music:	🎵タイトル
		telop:		Ｔタイトル
		img:		🗻崎川駅前
		# 先にメッセージ・ウィンドウを指定してから、選択肢を設定してください
		msg_wnd:	■下
		choice:		1,2
		""",
		"""\
		　・スタート
		　・終了
		""",
	],
	# 終わるなら
	"§終了" : [
		"""\
		!
		quit:
		"""
	],
	# ゲーム開始
	"§はじまり":[
		"""\
		!
		telop:	Ｔタイトル, hide
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		２０２３年５月２日（火）　朝１０：００
		ＮＲ崎川駅
		""",
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
		img:	🗻崎川駅前, hide
		img:	🗻崎川駅周辺地図
		telop:	Ｔ崎川駅周辺地図
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「駅からまっすぐ行った先の細長～い建物が
		　崎川市最強振興会館だぜ」
		""",
		"""\
		お父ん
		「最振（さいしん）会館に来るのも
		　今年で何回目だろうな？」
		""",
		"""\
		ひよ子
		「第２６回の選手権からだから
		　８回目ね
		""",
		# ツツジロード
		"""\
		!
		telop:		Ｔ崎川駅周辺地図, hide
		img:		🗻崎川駅周辺地図,hide
		img:		🗻ツツジロード
		img:		🐕ヘム将棋
		""",
		"""\
		きふわらべ
		「選手権に９回参加して
		　そのうち８回が最振会館だぜ
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「えっ　そんなに？
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「あの変な生き物も　崎川市が気合を入れて
		　育ててんのかだぜ？
		""",
		"""\
		ひよ子
		「あんな　ちんちくりんな生き物は
		　知らないわねえ
		""",
		# バトル部門へ飛ばします
		"""\
		!
		var:			battle_exit_department		,📗会話部門_🍉VisualNovel
		var:			battle_exit_section		,§崎川市最強振興会館
		department:		📗バトル部門_🍉Battle		,%ignorable%
		goto:			§１回目戦闘シーン
		""",
		# バトル部門がなければ、直後の goto 文は１回無視され、以下へフォールスルー
		"""\
		＊
		「戦闘シーンは省略しまーす
		""",
		"""\
		!
		img:		🐕ヘム将棋, hide
		img:		🗻ツツジロード, hide
		goto:		§崎川市最強振興会館
		"""
	],
	"§崎川市最強振興会館":[
		"""\
		!
		bg_music:
		img:		🗻４Ｆイベントルーム
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
		img:	🎴中央ウィンドウ
		img:	🎴将棋盤
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「横着しないで　ちゃんと　将棋盤を使って
		　説明しなさい
		""",
		"""\
		!
		img:	🎴将棋盤	, hide
		img:	🎴ファイルとランク
		""",
		"""\
		お父ん
		「右上が始まりで、左へ１筋、２筋・・・
		　下へａ段、ｂ段・・・　だぜ
		""",
		"""\
		!
		img:	🎴ファイルとランク, hide
		img:	🎴将棋盤
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
		bg_music: 🎵きふわらべファイター２
		""",
		"""\
		きふわらべ
		「お父ん、なんで唐揚げを食べてるんだぜ？
		　ダイエットはどうした？野菜食べろだぜ！
		""",
		# 中央ビューイング・ウィンドウを非表示
		"""\
		!
		img:	🎴中央ウィンドウ, hide
		img:	🎴将棋盤, hide
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
		bg_music:
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
	"§６筋の７段目の駒を６段目に突く":[
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
		goto: §エンディング
		"""
	],
	"§角道を止める":[
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
		goto: §エンディング
		"""
	],
	"§エンディング":[
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
		bg_music:	🎵エンディング
		img:	🗻エンディング
		telop:	Ｔエンディング
		"""
	],
}
