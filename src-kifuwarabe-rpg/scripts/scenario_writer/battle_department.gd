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
		bg:				🗻川掘町線ロード
		bg:				🗻戦闘シーン
		telop:			戦闘シーン
		bgm:			🎵バトル１, 8.6
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		""",
		# 戦闘開始
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おっと　戦闘シーンはまだ
		　できてないらしいぜ
		""",
		# 戦闘終了
		"""\
		!
		monster_face:	😁きふわらべ, hide
		monster:		%arg_monster%, hide
		monster_face:	%arg_monster_face%, hide
		telop:			戦闘シーン, hide
		m_wnd:			■下, hide
		department:		📗ビジュアルノベル部門
		goto:			%arg_return%
		m_wnd:			■下
		""",
	],
	"§２回目戦闘シーン":[
		"""\
		!
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル２
		""",
		# 戦闘開始
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		ひよ子
		「物騒ねぇ
		""",
		# 戦闘終了
		"""\
		!
		monster_face:	😁きふわらべ, hide
		monster:		%arg_monster%, hide
		monster_face:	%arg_monster_face%, hide
		telop:			戦闘シーン, hide
		m_wnd:			■下, hide
		department:		📗ビジュアルノベル部門
		goto:			%arg_return%
		m_wnd:			■下
		""",
	],
	"§３回目戦闘シーン":[
		"""\
		!
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル３
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ
		「戦闘なんか　これから
		　いっぱい　するのに……
		""",
		# 戦闘終了
		"""\
		!
		monster_face:	😁きふわらべ, hide
		monster:		%arg_monster%, hide
		monster_face:	%arg_monster_face%, hide
		telop:			戦闘シーン, hide
		m_wnd:			■下, hide
		department:		📗ビジュアルノベル部門
		goto:			%arg_return%
		m_wnd:			■下
		""",
	],
	# 昼ビール
	"§ＶＳ昼ビール":[
		# 戦闘開始
		"""\
		!
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル３
		""",
		# 画面設定
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上, "４３００"
		label:		Director/TelopCoordinator/戦闘シーン/逃げ道の広さ_上, "４１００"
		label:		Director/TelopCoordinator/戦闘シーン/駒の働き_上, "４２００"
		label:		Director/TelopCoordinator/戦闘シーン/攻めの速度_上, "４１００"
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　　　　　　　　　　　１９"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　１２３０００００００００"
		label:		Director/TelopCoordinator/戦闘シーン/主な瑕_上, "定跡無し"
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		審判
		「ログインしてくださーい！
		""",
		"""\
		昼ビールが現れた！
		「よろしくお願いします
		""",
		"""\
		きふわらべ
		「よろしくお願いします
		""",
		"""\
		きふわらべは飛び掛かった
		""",
		"""\
		きふわらべ届かない
		昼ビールに　０　のダメージを与えた
		""",
		"""\
		昼ビールは何もしなかった
		""",
		"""\
		きふわらべは歩を突いた
		昼ビールも歩を突いた
		きふわらべは　ひるんでいる
		""",
		"""\
		出た、きふわらべの　角キック！
		""",
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　１２２９９９９９９９９９"
		""",
		"""\
		昼ビールに　１　のダメージを与えた
		昼ビールは手待ちをしている
		""",
		"""\
		きふわらべは　桂馬を飛ぼうとしている
		合法手チェックで　未然に防いだ
		しかたなく　歩を突く
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		仕方なく歩を突き返した
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ　角を打ったあと成るパターンが
		多すぎて　読む量が減った！
		しかたなく　歩を突く
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		仕方なく駒組に手を付ける
		""",
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上, "４４００"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　１２３０００００００９９"
		""",
		"""\
		城の堅さが　１００　上がった
		玉の遠さが　１００　遠ざかった
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		きふわらべ　諦めない
		左上隅から右へ、左端から１段下の右端へ
		眺めながら最初に見つけた　歩を突く
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		"""\
		昼ビールのマルチポンダーは全て外れた
		""",
		"""\
		きふわらべ　諦めない
		""",
		# 戦闘終了
		"""\
		!
		monster_face:	😁きふわらべ, hide
		monster:		%arg_monster%, hide
		monster_face:	%arg_monster_face%, hide
		telop:			戦闘シーン, hide
		m_wnd:			■下, hide
		department:		📗ビジュアルノベル部門
		goto:			%arg_return%
		m_wnd:			■下
		""",
	],
}
