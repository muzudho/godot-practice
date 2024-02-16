# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var ancestor_children_dictionary = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# シナリオライターズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤ScenarioWriter/🐵Monkey_🍉VisualNovel",
			self.ancestor_children_dictionary)


# 戦闘ハブ取得
func monkey_of_battle():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🐵BattleMonkey",
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

	# ーーーーーーーーーー
	# データ部
	# ーーーーーーーーーー

	"¶１回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		img:		🗻ツツジロード
		#var:		%clear%
		var:		battle_bg_out				,🗻ツツジロード
		var:		battle_bg_in				,🗻ツツジロード
		var:		battle_battle_bg_music			,🎵バトル１
		var:		battle_battle_bg_music_from		,8.6
		var:		battle_sente_monster_name	,きふわらべ
		var:		battle_gote_monster_name	,ヘム将棋
		var:		battle_monster_body		,🐕ヘム将棋
		var:		battle_monster_face		,😁ヘム将棋
		var:		battle_paragraph		,¶ＶＳヘム将棋
		var:		battle_exit_department_local		,📗バトル部門_🍉Battle
		var:		battle_exit_section_local		,¶２回目戦闘シーン
		goto:		¶戦闘の始めに
		""",
	],
	"¶２回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		img:		🗻ツツジロード
		#var:		%clear%
		var:		battle_bg_out				,🗻ツツジロード
		var:		battle_bg_in				,🗻ツツジロード
		var:		battle_battle_bg_music			,🎵バトル２
		var:		battle_battle_bg_music_from		,0.0
		var:		battle_sente_monster_name	,きふわらべ
		var:		battle_gote_monster_name	,ケダック
		var:		battle_monster_body		,🐕ケダック
		var:		battle_monster_face		,😁ケダック
		var:		battle_paragraph		,¶ＶＳケダック
		var:		battle_exit_department_local		,📗バトル部門_🍉Battle
		var:		battle_exit_section_local		,¶３回目戦闘シーン
		goto:		¶戦闘の始めに
		""",
	],
	"¶３回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		img:		🗻ツツジロード
		#var:		%clear%
		var:		battle_bg_out				,🗻ツツジロード
		var:		battle_bg_in				,🗻川堀町線ロード
		var:		battle_battle_bg_music			,🎵バトル３
		var:		battle_battle_bg_music_from		,0.0
		var:		battle_sente_monster_name	,きふわらべ
		var:		battle_gote_monster_name	,レサぽん改
		var:		battle_monster_body		,🐕レサぽん改
		var:		battle_monster_face		,😁レサぽん改
		var:		battle_paragraph		,¶ＶＳレサぽん改
		var:		battle_exit_department_local		,📗バトル部門_🍉Battle
		var:		battle_exit_section_local		,¶４回目戦闘シーン
		department:	📗バトル部門_🍉Battle
		goto:		¶戦闘の始めに
		""",
	],
	"¶４回目戦闘シーン":[
		# 戦闘突入準備
		"""\
		!
		img:		🗻川堀町線ロード
		#var:		%clear%
		var:		battle_bg_out				,🗻川堀町線ロード
		var:		battle_bg_in				,🗻川堀町線ロード
		var:		battle_battle_bg_music			,🎵バトル４
		var:		battle_battle_bg_music_from		,0.0
		var:		battle_sente_monster_name	,きふわらべ
		var:		battle_gote_monster_name	,昼ビール
		var:		battle_monster_body		,🐕昼ビール
		var:		battle_monster_face		,😁昼ビール
		var:		battle_paragraph		,¶ＶＳ昼ビール
		var:		battle_exit_department_local		,{{battle_exit_department}}
		var:		battle_exit_section_local		,{{battle_exit_section}}
		department:	📗バトル部門_🍉Battle
		goto:		¶戦闘の始めに
		""",
	],

	# ーーーーーーーーーー
	# 共通処理
	# ーーーーーーーーーー

	# とりあえず、他の画面からこの段落へ飛んでくる
	"¶戦闘の始めに":[
		"""\
		!
		goto:		¶ロード・データ
		""",
	],
	# トランジションとデータのロードは並行処理できたらよさそうだが、できてない
	"¶ロード・データ":[
		#
		# Arguments
		# =========
		# {{battle_sente_monster_name}}
		#	先手対局者名
		# {{battle_gote_monster_name}}
		#	後手対局者名
		#
		func():
			# 変数取得
			var sente_monster_name = self.monkey().of_staff().programmer().owner_node().stage_directions_variables["battle_sente_monster_name"]
			var gote_monster_name = self.monkey().of_staff().programmer().owner_node().stage_directions_variables["battle_gote_monster_name"]
			
			# モンスターＩｄ取得
			var sente_monster_id = self.monkey_of_battle().get_scorer().lookup_monster_id_by_name(sente_monster_name)
			var gote_monster_id = self.monkey_of_battle().get_scorer().lookup_monster_id_by_name(gote_monster_name)
			
			# ロード
			self.monkey_of_battle().get_scorer().load_game_data_for_battle(sente_monster_id, gote_monster_id)
			
			# 匿名関数の終わりのコンマ
			,
		"""\
		!
		goto:		¶エンカウント・トランジション
		""",
	],
	"¶エンカウント・トランジション":[
		#
		# Arguments
		# =========
		# {{battle_bg_out}}
		#	元背景
		# {{battle_bg_in}}
		#	先背景
		# {{battle_monster_body}}
		#	怪物の体
		# {{battle_paragraph}}
		#	次の段落
		#
		"""\
		!
		bg_music:
		sound_fx:				🔔エンカウント音
		sleep:			0.15
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻１コマ
		sleep:			0.15
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻２コマ
		img:			📂🗻戦闘開始トランジション/🗻１コマ, hide
		sleep:			0.15
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻３コマ
		img:			📂🗻戦闘開始トランジション/🗻２コマ, hide
		sleep:			0.15
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻４コマ
		img:			📂🗻戦闘開始トランジション/🗻３コマ, hide
		img:			{{battle_bg_out}}, hide
		img:			{{battle_bg_in}}
		sleep:			0.15
		""",
		# ここで画面全体が真っ黒になっている
		# モンスターの全身像もここで表示する
		"""\
		!
		img:			{{battle_monster_body}}
		img:			📂🗻戦闘開始トランジション/🗻８コマ
		img:			📂🗻戦闘開始トランジション/🗻４コマ, hide
		sleep:			0.10
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻９コマ
		img:			📂🗻戦闘開始トランジション/🗻８コマ, hide
		sleep:			0.10
		""",
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻１０コマ
		img:			📂🗻戦闘開始トランジション/🗻９コマ, hide
		sleep:			0.10
		""",
		# 少し長めのフレーム
		"""\
		!
		img:			📂🗻戦闘開始トランジション/🗻１１コマ
		img:			📂🗻戦闘開始トランジション/🗻１０コマ, hide
		sleep:			0.20
		""",
		"""\
		!
		img:			🗻戦闘シーン
		img:			📂🗻戦闘開始トランジション/🗻１１コマ, hide
		sleep:			0.10
		""",
		"""\
		!
		goto:			¶データの最新表示
		""",
	],
	"¶データの最新表示":[
		func():
			# 先手
			# 先手の［城の堅さ］表示更新
			self.monkey_of_battle().refresh_sente_solidity_of_castle()
			# 先手の［逃げ道の広さ］表示更新
			self.monkey_of_battle().refresh_sente_breadth_of_escape_route()
			# 先手の［駒の働き］表示更新
			self.monkey_of_battle().refresh_sente_work_of_pieces()
			# 先手の［攻めの速度］表示更新
			self.monkey_of_battle().refresh_sente_offensive_speed()
			# 先手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_sente_distance_of_king()
			
			# 後手
			# 後手の［城の堅さ］表示更新
			self.monkey_of_battle().refresh_gote_solidity_of_castle()
			# 後手の［逃げ道の広さ］表示更新
			self.monkey_of_battle().refresh_gote_breadth_of_escape_route()
			# 後手の［駒の働き］表示更新
			self.monkey_of_battle().refresh_gote_work_of_pieces()
			# 後手の［攻めの速度］表示更新
			self.monkey_of_battle().refresh_gote_offensive_speed()
			# 後手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_gote_distance_of_king()
			
			# 匿名関数の終わりのコンマ
			,
		# 戦闘開始
		"""\
		!
		sound_fx:
		telop:			Ｔ戦闘シーン
		img:			😁きふわらべ
		img:			{{battle_monster_face}}
		goto:			¶定刻
		""",
	],
	"¶定刻": [
		"""\
		!
		bg_music:			{{battle_battle_bg_music}}	,{{battle_battle_bg_music_from}}
		msg_wnd:		■下on戦
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
		goto:			¶バトルメニュー
		""",
	],
	"¶バトルメニュー":[
		"""\
		!
		# 最後に表示したウィンドウが、メッセージ出力対象になるので並べる順に注意
		msg_wnd:			■左下
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
	"¶先手の攻め":[
		"""\
		!
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		"""\
		!
		goto:			{{battle_paragraph}}
		""",
	],
	# (2023-11-07 tue) 今のところ、常にきふわらべが先手
	"¶先手の守り":[
		"""\
		!
		msg_wnd:		■下on戦
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
	"¶先手の新無敵囲い":[
		"""\
		!
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{battle_sente_monster_name}} は
		犯人コラブの囲いを　真似した！
		""",
		"""\
		{{battle_sente_monster_name}}
		「金、銀を足したろ
		""",
		"""\
		!
		goto:			{{battle_paragraph}}
		""",
	],
	"¶先手の奇跡の角生還":[
		"""\
		!
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{battle_sente_monster_name}} は
		角を動かした！
		""",
		"""\
		{{battle_sente_monster_name}}
		「ここらへんで　いいだろ
		""",
		"""\
		!
		goto:			{{battle_paragraph}}
		""",
	],
	"¶先手のボンザナ囲い":[
		"""\
		!
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		{{battle_sente_monster_name}} は
		１路ずらして銀冠を作った
		""",
		"""\
		{{battle_sente_monster_name}}
		「飛車先も、角道も、避けてるしな
		""",
		"""\
		!
		goto:			{{battle_paragraph}}
		""",
	],
	#"¶先手のエモル囲い":[
	#	"""\
	#	!
	#	msg_wnd:		■下on戦
	#	msg_speed:		20
	#	""",
	#	# ２３４５６７８９０１２３４５６７８９０
	#	"""\
	#	{{battle_sente_monster_name}} の玉は
	#	金の上に乗った
	#	""",
	#	"""\
	#	{{battle_sente_monster_name}}
	#	「よっこらせっと
	#	""",
	#	"""\
	#	!
	#	goto:			{{battle_paragraph}}
	#	""",
	#],
	# (2023-10-16 thu) 今のところ、常にきふわらべが先手
	"¶先手の投了":[
		"""\
		!
		bg_music:			🎵負け
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		"""\
		{{battle_sente_monster_name}}
		「参りました
		""",
		"""\
		両者
		「「ありがとうございました
		""",
		"""\
		!
		goto:		¶撤収
		""",
	],
	# (2023-11-07 tue) 今のところ、常にきふわらべが先手
	"¶先手の勝ち宣言":[
		"""\
		!
		msg_wnd:		■下on戦
		msg_speed:		20
		""",
		"""\
		{{battle_sente_monster_name}}
		「勝ち宣言をします
		""",
		"""\
		審判
		「駒の枚数が足りません。
		{{battle_sente_monster_name}} の反則負けです
		""",
		"""\
		!
		bg_music:			🎵負け
		""",
		"""\
		{{battle_sente_monster_name}}
		「参りました
		""",
		"""\
		両者
		「「ありがとうございました
		""",
		"""\
		!
		goto:		¶撤収
		""",
	],
	"¶撤収":[
		"""\
		!
		img:			{{battle_bg_in}}			,hide
		img:			🗻戦闘シーン			,hide
		img:			😁きふわらべ			,hide
		img:			{{battle_monster_body}}	,hide
		img:			{{battle_monster_face}}	,hide
		telop:			Ｔ戦闘シーン				,hide

		department:		{{battle_exit_department_local}}
		goto:			{{battle_exit_section_local}}
		""",
	],

	# ーーーーーーーーーー
	# 以下、固有処理
	# ーーーーーーーーーー
	"¶ＶＳヘム将棋":[
		"""\
		{{battle_sente_monster_name}}の先手だ！
		""",
		func():
			# ダメージ計算
			var damage = 1
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Var").set_var("battle_damage", str(damage))

			# 後手の［玉の遠さ］を減らす
			self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[1] -= damage
			,
		"""\
		{{battle_sente_monster_name}}
		「歩を突く
		　{{battle_gote_monster_name}}の玉に{{battle_damage}}歩近づく
		""",
		func():
			# 後手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_gote_distance_of_king()
			,
		func():
			# ダメージ計算
			var damage = 1
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Var").set_var("battle_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[0] -= 1
			,
		"""\
		{{battle_gote_monster_name}}
		「合わせて歩を突く
		　{{battle_sente_monster_name}}の玉に{{battle_damage}}歩近づく
		""",
		func():
			# 先手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_sente_distance_of_king()

			,
		"""\
		!
		goto:	¶先手番１
		""",
	],
	"¶先手番１": [
		func():
			# ダメージ計算
			var damage = 5
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Var").set_var("battle_damage", str(damage))
			
			# 後手の［玉の遠さ］を５減らす
			self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[1] -= damage

			# 後手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_gote_distance_of_king()
			,
		"""\
		{{battle_sente_monster_name}}
		「銀が上がる
		　{{battle_gote_monster_name}}の玉に{{battle_damage}}歩近づく
		""",
		func():
			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[1] < 5:
				self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto("¶後手番投了", "")
			else:
				self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto("¶後手番１", "")
			,
	],
	"¶後手番１": [
		func():
			# ダメージ計算
			var damage = 5
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Var").set_var("battle_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[0] -= damage
			
			# 先手の［玉の遠さ］表示更新
			self.monkey_of_battle().refresh_sente_distance_of_king()
			,
		"""\
		{{battle_gote_monster_name}}
		「銀が上がる
		　{{battle_sente_monster_name}}の玉に{{battle_damage}}歩近づく
		""",
		func():			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.monkey_of_battle().get_game_sheet_for_battle().distance_of_king[0] < 5:
				self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto("¶先手番投了", "")
			else:
				self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto("¶先手番１", "")
			,
	],
	"¶先手番投了": [
		"""\
		{{battle_gote_monster_name}}
		「参りました
		""",
		# 戦闘終了
		"""\
		!
		goto:	¶撤収
		""",
	],
	"¶後手番投了": [
		"""\
		{{battle_gote_monster_name}}
		「参りました
		""",
		# 戦闘終了
		"""\
		!
		goto:	¶撤収
		""",
	],
	#
	#
	#
	"¶ＶＳケダック":[
		# 画面設定
		"""\
		!
		bg_music:			{{battle_battle_bg_music}}	,{{battle_battle_bg_music_from}}
		msg_wnd:		■下on戦
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
		goto:			¶撤収
		""",
	],
	#
	#
	#
	"¶ＶＳレサぽん改":[
		# 画面設定
		"""\
		!
		bg_music:			{{battle_battle_bg_music}}	,{{battle_battle_bg_music_from}}
		msg_wnd:		■下on戦
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
		goto:			¶撤収
		""",
	],
	#
	# 昼ビール
	#
	"¶ＶＳ昼ビール":[
		# 画面設定
		"""\
		!
		bg_music:			{{battle_battle_bg_music}}	,{{battle_battle_bg_music_from}}
		msg_wnd:		■下on戦
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
		goto:			¶撤収
		""",
	],
}
