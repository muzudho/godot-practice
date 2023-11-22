# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# シナリオライターズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ScenarioWritersHub_🍉VisualNovel")


# 戦闘ハブ取得
func battle_hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️BattleHub")


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

	# ーーーーーーーーーー
	# データ部
	# ーーーーーーーーーー

	"§１回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		bg:			🗻ツツジロード
		var:		%clear%
		var:		arg_bg_out				,🗻ツツジロード
		var:		arg_bg_in				,🗻ツツジロード
		var:		arg_battle_bgm			,🎵バトル１
		var:		arg_battle_bgm_from		,8.6
		var:		arg_sente_monster_name	,きふわらべ
		var:		arg_gote_monster_name	,ヘム将棋
		var:		arg_monster_body		,🐕ヘム将棋
		var:		arg_monster_face		,😁ヘム将棋
		var:		arg_battle_section		,§ＶＳヘム将棋
		var:		arg_exit_department		,📗バトル部門
		var:		arg_exit_section		,§２回目戦闘シーン
		goto:		§戦闘の始めに
		""",
	],
	"§２回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		bg:			🗻ツツジロード
		var:		%clear%
		var:		arg_bg_out				,🗻ツツジロード
		var:		arg_bg_in				,🗻ツツジロード
		var:		arg_battle_bgm			,🎵バトル２
		var:		arg_battle_bgm_from		,0.0
		var:		arg_sente_monster_name	,きふわらべ
		var:		arg_gote_monster_name	,ケダック
		var:		arg_monster_body		,🐕ケダック
		var:		arg_monster_face		,😁ケダック
		var:		arg_battle_section		,§ＶＳケダック
		var:		arg_exit_department		,📗バトル部門
		var:		arg_exit_section		,§３回目戦闘シーン
		goto:		§戦闘の始めに
		""",
	],
	"§３回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		bg:			🗻ツツジロード
		var:		%clear%
		var:		arg_bg_out				,🗻ツツジロード
		var:		arg_bg_in				,🗻川堀町線ロード
		var:		arg_battle_bgm			,🎵バトル３
		var:		arg_battle_bgm_from		,0.0
		var:		arg_sente_monster_name	,きふわらべ
		var:		arg_gote_monster_name	,レサぽん改
		var:		arg_monster_body		,🐕レサぽん改
		var:		arg_monster_face		,😁レサぽん改
		var:		arg_battle_section		,§ＶＳレサぽん改
		var:		arg_exit_department		,📗バトル部門
		var:		arg_exit_section		,§４回目戦闘シーン
		department:	📗バトル部門
		goto:		§戦闘の始めに
		""",
	],
	"§４回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		bg:			🗻川堀町線ロード
		var:		%clear%
		var:		arg_bg_out				,🗻川堀町線ロード
		var:		arg_bg_in				,🗻川堀町線ロード
		var:		arg_battle_bgm			,🎵バトル４
		var:		arg_battle_bgm_from		,0.0
		var:		arg_sente_monster_name	,きふわらべ
		var:		arg_gote_monster_name	,昼ビール
		var:		arg_monster_body		,🐕昼ビール
		var:		arg_monster_face		,😁昼ビール
		var:		arg_battle_section		,§ＶＳ昼ビール
		var:		arg_exit_department		,📗会話部門_🍉VisualNovel
		var:		arg_exit_section		,§崎川市最強振興会館
		department:	📗バトル部門
		goto:		§戦闘の始めに
		""",
	],

	# ーーーーーーーーーー
	# 共通処理
	# ーーーーーーーーーー

	# とりあえず、他の画面からこのセクションへ飛んでくる
	"§戦闘の始めに":[
		"""\
		!
		goto:		§ロード・データ
		""",
	],
	# トランジションとデータのロードは並行処理できたらよさそうだが、できてない
	"§ロード・データ":[
		#
		# Arguments
		# =========
		# {{arg_sente_monster_name}}
		#	先手対局者名
		# {{arg_gote_monster_name}}
		#	後手対局者名
		#
		func():
			# 変数取得
			var sente_monster_name = self.hub().get_director().stage_directions_variables["arg_sente_monster_name"]
			var gote_monster_name = self.hub().get_director().stage_directions_variables["arg_gote_monster_name"]
			
			# モンスターＩｄ取得
			var sente_monster_id = self.battle_hub().get_scorer().lookup_monster_id_by_name(sente_monster_name)
			var gote_monster_id = self.battle_hub().get_scorer().lookup_monster_id_by_name(gote_monster_name)
			
			# ロード
			self.battle_hub().get_scorer().load_game_data_for_battle(sente_monster_id, gote_monster_id)
			
			# 匿名関数の終わりのコンマ
			,
		"""\
		!
		goto:		§エンカウント・トランジション
		""",
	],
	"§エンカウント・トランジション":[
		#
		# Arguments
		# =========
		# {{arg_bg_out}}
		#	元背景
		# {{arg_bg_in}}
		#	先背景
		# {{arg_monster_body}}
		#	怪物の体
		# {{arg_battle_section}}
		#	次のセクション
		#
		"""\
		!
		bgm:
		se:				🔔エンカウント音
		sleep:			0.15
		""",
		"""\
		!
		bg:				🗻トランジション１コマ１
		sleep:			0.15
		""",
		"""\
		!
		bg:				🗻トランジション１コマ２
		bg:				🗻トランジション１コマ１, hide
		sleep:			0.15
		""",
		"""\
		!
		bg:				🗻トランジション１コマ３
		bg:				🗻トランジション１コマ２, hide
		sleep:			0.15
		""",
		"""\
		!
		bg:				🗻トランジション１コマ４
		bg:				🗻トランジション１コマ３, hide
		bg:				{{arg_bg_out}}, hide
		bg:				{{arg_bg_in}}
		sleep:			0.15
		""",
		# ここで画面全体が真っ黒になっている
		# モンスターの全身像もここで表示する
		"""\
		!
		img:			{{arg_monster_body}}
		bg:				🗻トランジション１コマ８
		bg:				🗻トランジション１コマ４, hide
		sleep:			0.10
		""",
		"""\
		!
		bg:				🗻トランジション１コマ９
		bg:				🗻トランジション１コマ８, hide
		sleep:			0.10
		""",
		"""\
		!
		bg:				🗻トランジション１コマ１０
		bg:				🗻トランジション１コマ９, hide
		sleep:			0.10
		""",
		# 少し長めのフレーム
		"""\
		!
		bg:				🗻トランジション１コマ１１
		bg:				🗻トランジション１コマ１０, hide
		sleep:			0.20
		""",
		"""\
		!
		bg:				🗻戦闘シーン
		bg:				🗻トランジション１コマ１１, hide
		sleep:			0.10
		""",
		"""\
		!
		goto:			§データの最新表示
		""",
	],
	"§データの最新表示":[
		func():
			# 先手
			# 先手の［城の堅さ］表示更新
			self.battle_hub().refresh_sente_solidity_of_castle()
			# 先手の［逃げ道の広さ］表示更新
			self.battle_hub().refresh_sente_breadth_of_escape_route()
			# 先手の［駒の働き］表示更新
			self.battle_hub().refresh_sente_work_of_pieces()
			# 先手の［攻めの速度］表示更新
			self.battle_hub().refresh_sente_offensive_speed()
			# 先手の［玉の遠さ］表示更新
			self.battle_hub().refresh_sente_distance_of_king()
			
			# 後手
			# 後手の［城の堅さ］表示更新
			self.battle_hub().refresh_gote_solidity_of_castle()
			# 後手の［逃げ道の広さ］表示更新
			self.battle_hub().refresh_gote_breadth_of_escape_route()
			# 後手の［駒の働き］表示更新
			self.battle_hub().refresh_gote_work_of_pieces()
			# 後手の［攻めの速度］表示更新
			self.battle_hub().refresh_gote_offensive_speed()
			# 後手の［玉の遠さ］表示更新
			self.battle_hub().refresh_gote_distance_of_king()
			
			# 匿名関数の終わりのコンマ
			,
		# 戦闘開始
		"""\
		!
		se:
		telop:			Ｔ戦闘シーン
		img:			😁きふわらべ
		img:			{{arg_monster_face}}
		goto:			§定刻
		""",
	],
	"§定刻": [
		"""\
		!
		bgm:			{{arg_battle_bgm}}	,{{arg_battle_bgm_from}}
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		審判
		「ログインしてくださーい！
		""",
		"""\
		両対局者
		「「よろしくお願いします
		""",
		"""\
		!
		goto:			§バトルメニュー
		""",
	],
	"§バトルメニュー":[
		"""\
		!
		# 最後に表示したウィンドウが、メッセージ出力対象になるので並べる順に注意
		m_wnd:			■左下
		msg_speed:		1000
		choice:			1,2,3,4
		""",
		"""\
		　攻める
		　守る
		　投了
		　勝ち宣言
		""",
	],
	"§先手の攻め":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		"""\
		!
		goto:			{{arg_battle_section}}
		""",
	],
	# (2023-11-07 tue) 今のところ、常にきふわらべが先手
	"§先手の守り":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		choice:			1,2,3
		""",
		"""\
		　新無敵囲い
		　奇跡の角生還
		　ボンザナ囲い
		""",
		# エモル囲い
	],
	"§先手の新無敵囲い":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{arg_sente_monster_name}} は
		犯人コラブの囲いを　真似した！
		""",
		"""\
		{{arg_sente_monster_name}}
		「金、銀を足したろ
		""",
		"""\
		!
		goto:			{{arg_battle_section}}
		""",
	],
	"§先手の奇跡の角生還":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{arg_sente_monster_name}} は
		角を動かした！
		""",
		"""\
		{{arg_sente_monster_name}}
		「ここらへんで　いいだろ
		""",
		"""\
		!
		goto:			{{arg_battle_section}}
		""",
	],
	"§先手のボンザナ囲い":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{arg_sente_monster_name}} は
		１路ずらして銀冠を作った
		""",
		"""\
		{{arg_sente_monster_name}}
		「飛車先も、角道も、避けてるしな
		""",
		"""\
		!
		goto:			{{arg_battle_section}}
		""",
	],
	#"§先手のエモル囲い":[
	#	"""\
	#	!
	#	m_wnd:			■下on戦
	#	msg_speed:		20
	#	""",
	#	# ２３４５６７８９０１２３４５６７８９０
	#	"""\
	#	{{arg_sente_monster_name}} の玉は
	#	金の上に乗った
	#	""",
	#	"""\
	#	{{arg_sente_monster_name}}
	#	「よっこらせっと
	#	""",
	#	"""\
	#	!
	#	goto:			{{arg_battle_section}}
	#	""",
	#],
	# (2023-10-16 thu) 今のところ、常にきふわらべが先手
	"§先手の投了":[
		"""\
		!
		bgm:			🎵負け
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		"""\
		{{arg_sente_monster_name}}
		「参りました
		""",
		"""\
		両者
		「「ありがとうございました
		""",
		"""\
		!
		goto:		§撤収
		""",
	],
	# (2023-11-07 tue) 今のところ、常にきふわらべが先手
	"§先手の勝ち宣言":[
		"""\
		!
		m_wnd:			■下on戦
		msg_speed:		20
		""",
		"""\
		{{arg_sente_monster_name}}
		「勝ち宣言をします
		""",
		"""\
		審判
		「駒の枚数が足りません。
		{{arg_sente_monster_name}} の反則負けです
		""",
		"""\
		!
		bgm:			🎵負け
		""",
		"""\
		{{arg_sente_monster_name}}
		「参りました
		""",
		"""\
		両者
		「「ありがとうございました
		""",
		"""\
		!
		goto:		§撤収
		""",
	],
	"§撤収":[
		"""\
		!
		bg:				{{arg_bg_in}}			,hide
		bg:				🗻戦闘シーン			,hide
		img:			😁きふわらべ			,hide
		img:			{{arg_monster_body}}	,hide
		img:			{{arg_monster_face}}	,hide
		telop:			Ｔ戦闘シーン				,hide
		#bg:				{{arg_bg_out}}

		department:		{{arg_exit_department}}
		goto:			{{arg_exit_section}}
		""",
	],

	# ーーーーーーーーーー
	# 以下、固有処理
	# ーーーーーーーーーー
	"§ＶＳヘム将棋":[
		"""\
		{{arg_sente_monster_name}}の先手だ！
		""",
		func():
			# ダメージ計算
			var damage = 1
			self.hub().get_programs_hub().get_instruction("📗Var").set_var("arg_damage", str(damage))

			# 後手の［玉の遠さ］を減らす
			self.battle_hub().get_game_sheet_for_battle().distance_of_king[1] -= damage
			,
		"""\
		{{arg_sente_monster_name}}
		「歩を突く
		　{{arg_gote_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			# 後手の［玉の遠さ］表示更新
			self.battle_hub().refresh_gote_distance_of_king()
			,
		func():
			# ダメージ計算
			var damage = 1
			self.hub().get_programs_hub().get_instruction("📗Var").set_var("arg_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.battle_hub().get_game_sheet_for_battle().distance_of_king[0] -= 1
			,
		"""\
		{{arg_gote_monster_name}}
		「合わせて歩を突く
		　{{arg_sente_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			# 先手の［玉の遠さ］表示更新
			self.battle_hub().refresh_sente_distance_of_king()

			,
		"""\
		!
		goto:	§先手番１
		""",
	],
	"§先手番１": [
		func():
			# ダメージ計算
			var damage = 5
			self.hub().get_programs_hub().get_instruction("📗Var").set_var("arg_damage", str(damage))
			
			# 後手の［玉の遠さ］を５減らす
			self.battle_hub().get_game_sheet_for_battle().distance_of_king[1] -= damage

			# 後手の［玉の遠さ］表示更新
			self.battle_hub().refresh_gote_distance_of_king()
			,
		"""\
		{{arg_sente_monster_name}}
		「銀が上がる
		　{{arg_gote_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.battle_hub().get_game_sheet_for_battle().distance_of_king[1] < 5:
				self.hub().get_programs_hub().get_instruction("📗Goto").goto("§後手番投了", "")
			else:
				self.hub().get_programs_hub().get_instruction("📗Goto").goto("§後手番１", "")
			,
	],
	"§後手番１": [
		func():
			# ダメージ計算
			var damage = 5
			self.hub().get_programs_hub().get_instruction("📗Var").set_var("arg_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.battle_hub().get_game_sheet_for_battle().distance_of_king[0] -= damage
			
			# 先手の［玉の遠さ］表示更新
			self.battle_hub().refresh_sente_distance_of_king()
			,
		"""\
		{{arg_gote_monster_name}}
		「銀が上がる
		　{{arg_sente_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.battle_hub().get_game_sheet_for_battle().distance_of_king[0] < 5:
				self.hub().get_programs_hub().get_instruction("📗Goto").goto("§先手番投了", "")
			else:
				self.hub().get_programs_hub().get_instruction("📗Goto").goto("§先手番１", "")
			,
	],
	"§先手番投了": [
		"""\
		{{arg_gote_monster_name}}
		「参りました
		""",
		# 戦闘終了
		"""\
		!
		goto:	§撤収
		""",
	],
	"§後手番投了": [
		"""\
		{{arg_gote_monster_name}}
		「参りました
		""",
		# 戦闘終了
		"""\
		!
		goto:	§撤収
		""",
	],
	#
	#
	#
	"§ＶＳケダック":[
		# 画面設定
		"""\
		!
		bgm:			{{arg_battle_bgm}}	,{{arg_battle_bgm_from}}
		m_wnd:			■下on戦
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
		goto:			§撤収
		""",
	],
	#
	#
	#
	"§ＶＳレサぽん改":[
		# 画面設定
		"""\
		!
		bgm:			{{arg_battle_bgm}}	,{{arg_battle_bgm_from}}
		m_wnd:			■下on戦
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
		goto:			§撤収
		""",
	],
	#
	# 昼ビール
	#
	"§ＶＳ昼ビール":[
		# 画面設定
		"""\
		!
		bgm:			{{arg_battle_bgm}}	,{{arg_battle_bgm_from}}
		m_wnd:			■下on戦
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
		#label:		Ｔ戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Ｔ戦闘シーン/玉の遠さ_上		,"　　　　　１２２９９９９９９９９９"
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
		label:		Ｔ戦闘シーン/城の堅さ_上		,"４４００"
		#label:		Ｔ戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Ｔ戦闘シーン/玉の遠さ_上		,"　　　　　１２３０００００００９９"
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
		# 戦闘終了
		"""\
		!
		goto:			§撤収
		""",
	],
}
