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
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　　　　　　　　　　　１９"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上, "　　１２３０００００００００"
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
