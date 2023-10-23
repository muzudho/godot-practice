#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		ビジュアルノベル部門
extends Node


func get_director():
	return $"../../../Director"


func get_assistant_director():
	return $"../../../Director/AssistantDirector"


#	選択肢と移動先
var choices_mappings = {
	#	このキーは［セクション名］と呼ぶことにする。頭に「§」を付けているのは見やすさのためで、付けなくても構わない
	"§タイトル画面" : {
		# 選択肢の行番号と、移動先の［セクション名］
		1 : "§はじまり",
		2 : "§終了",
	},
	"§崎川市最強振興会館" : {
		1 : "§６筋の７段目の駒を６段目に突く",
		2 : "§角道を止める",
	},
}


#	この書き方だと、実はインデントのタブが台詞データとして入っている。
#	インデントのタブは、プログラム側で省く処理を入れておくとする
var document = {
	"§タイトル画面":[
		"""\
		!
		bgm:		🎵タイトル
		telop:		Ｔタイトル
		bg:			🗻崎川駅前
		choice:		1,2
		m_wnd:		■下
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
	# TODO 消す 動作テスト中
	"§はじまり":[
		# 関数を要素にするとどうなるか？
		func() :
			print("匿名関数の使い方テスト")
			
			# 変数を設定するテスト。あとで `{{arg_title}}` で使える
			self.get_director().stage_directions_variables["arg_title"] = "Ｔタイトル"
			
			# セクションの名前を指定して飛ぶ
			self.get_assistant_director().get_node("Goto").goto("§はじまり２")
			
			# 匿名関数の最後にカンマを書く
			,
	],
	"§ここには来ない":[
		"""\
		ここは飛ばされるぜ
		""",
	],
	"§はじまり２":[
		"""\
		!
		#telop:	Ｔタイトル, hide
		telop:	{{arg_title}}, hide
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
		bg:		🗻崎川駅前, hide
		bg:		🗻崎川駅周辺地図
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
		bg:			🗻崎川駅周辺地図,hide
		bg:			🗻ツツジロード
		monster:	🐕ヘム将棋
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
		# 戦闘突入準備
		"""\
		!
		m_wnd:		■下, hide
		department:	📗バトル部門
		goto:		§戦闘デパートメント開始
		var:		%clear%
		var:		arg_bg_out				,🗻ツツジロード
		var:		arg_bg_in				,🗻ツツジロード
		var:		arg_sente_monster_name	,きふわらべ 
		var:		arg_gote_monster_name	,ヘム将棋
		var:		arg_monster				,🐕ヘム将棋
		var:		arg_monster_face		,😁ヘム将棋
		var:		arg_return				,§２回目戦闘シーン
		""",
	],
	"§２回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		m_wnd:		■下, hide
		department:	📗バトル部門
		goto:		§２回目戦闘シーン
		var:		%clear%
		var:		arg_bg				,🗻ツツジロード
		var:		arg_monster, 🐕ケダック
		var:		arg_monster_face, 😁ケダック
		var:		arg_return, §３回目戦闘シーン
		m_wnd:		■下
		""",
	],
	"§３回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		m_wnd:		■下, hide
		department:	📗バトル部門
		goto:		§３回目戦闘シーン
		var:		%clear%
		var:		arg_bg				,🗻川堀町線ロード
		var:		arg_monster			,🐕レサぽん改
		var:		arg_monster_face	,😁レサぽん改
		var:		arg_return			,§ＶＳ昼ビール
		m_wnd:		■下
		""",
	],
	"§ＶＳ昼ビール":[
		# 戦闘突入準備
		"""\
		!
		m_wnd:		■下, hide
		department:	📗バトル部門
		goto:		§ＶＳ昼ビール
		var:		%clear%
		var:		arg_bg				,🗻川堀町線ロード
		var:		arg_monster			,🐕昼ビール
		var:		arg_monster_face	,😁昼ビール
		var:		arg_return			,§崎川市最強振興会館
		m_wnd:		■下
		""",
	],
	#	崎川市最強振興会館
	"§崎川市最強振興会館":[
		"""\
		!
		bgm:
		bg:		🗻川堀町線ロード, hide
		bg:		🗻戦闘シーン, hide
		bg:		🗻４Ｆイベントルーム
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
		v_wnd:	■中央, 将棋盤
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「横着しないで　ちゃんと　将棋盤を使って
		　説明しなさい
		""",
		"""\
		!
		v_wnd: ■中央, ファイルとランク
		""",
		"""\
		お父ん
		「右上が始まりで、左へ１筋、２筋・・・
		　下へａ段、ｂ段・・・　だぜ
		""",
		"""\
		!
		v_wnd: ■中央, 将棋盤
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
		bgm: 🎵きふわらべファイター２
		""",
		"""\
		きふわらべ
		「お父ん、なんで唐揚げを食べてるんだぜ？
		　ダイエットはどうした？野菜食べろだぜ！
		""",
		# 中央ビューイング・ウィンドウを非表示
		"""\
		!
		v_wnd:	■中央
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
		bgm:	🎵エンディング
		bg:		🗻エンディング
		telop:	Ｔエンディング
		"""
	],
}
