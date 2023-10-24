#	シナリオ・ブック（Scenario Book；台本の本）
#			シナリオ・ブックという名前が付いているが、大した機能はない
#		バトル部門
extends Node


func get_director():
	return $"../../../Director"


func get_assistant_director():
	return $"../../../Director/AssistantDirector"


func get_telop_coordinator():
	return $"../../../Director/TelopCoordinator"


func get_scorer():
	return $"../../../Director/Scorer"


func get_game_sheet_for_battle():
	return $"../../../Director/Scorer/GameSheetForBattle"


func get_system_of_battle():
	return $"../System/Battle"


#	選択肢と移動先
var choices_mappings = {
}

# この書き方だと、実はインデントのタブが台詞データとして入っている。
# インデントのタブは、プログラム側で省く処理を入れておくとする
var document = {
	#
	# 最初に、共通処理を並べる
	#
	"§ロード・データ":[
		# トランジションとデータのロードは並行処理できたらよさそうだが、できてない
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
			var sente_monster_name = self.get_director().stage_directions_variables["arg_sente_monster_name"]
			var gote_monster_name = self.get_director().stage_directions_variables["arg_gote_monster_name"]
			
			# モンスターＩｄ取得
			var sente_monster_id = self.get_scorer().lookup_monster_id_by_name(sente_monster_name)
			var gote_monster_id = self.get_scorer().lookup_monster_id_by_name(gote_monster_name)
			
			# ロード
			self.get_scorer().load_game_data_for_battle(sente_monster_id, gote_monster_id)
			
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
		# {{goto_next_section_from_encount_transition}}
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
		"""\
		!
		monster:		{{arg_monster_body}}
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
			self.get_system_of_battle().refresh_sente_solidity_of_castle()
			# 先手の［逃げ道の広さ］表示更新
			self.get_system_of_battle().refresh_sente_breadth_of_escape_route()
			# 先手の［駒の働き］表示更新
			self.get_system_of_battle().refresh_sente_work_of_pieces()
			# 先手の［攻めの速度］表示更新
			self.get_system_of_battle().refresh_sente_offensive_speed()
			# 先手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_sente_distance_of_king()
			
			# 後手
			# 後手の［城の堅さ］表示更新
			self.get_system_of_battle().refresh_gote_solidity_of_castle()
			# 後手の［逃げ道の広さ］表示更新
			self.get_system_of_battle().refresh_gote_breadth_of_escape_route()
			# 後手の［駒の働き］表示更新
			self.get_system_of_battle().refresh_gote_work_of_pieces()
			# 後手の［攻めの速度］表示更新
			self.get_system_of_battle().refresh_gote_offensive_speed()
			# 後手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_gote_distance_of_king()
			
			# 匿名関数の終わりのコンマ
			,
		"""\
		!
		goto:			{{goto_next_section_from_encount_transition}}
		""",		
	],

	#
	# 以下、固有処理
	#
	"§戦闘デパートメント開始":[
		"""\
		!
		var:		goto_next_section_from_encount_transition	,§ステータス初期セット
		goto:		§ロード・データ
		""",
	],
	"§ステータス初期セット":[
		# 戦闘開始
		"""\
		!
		se:
		telop:			Ｔ戦闘シーン
		bgm:			🎵バトル１, 8.6
		monster_face:	😁きふわらべ
		monster_face:	{{arg_monster_face}}
		m_wnd:			■下
		m_wnd:			■左下
		""",
		"""\
		!
		goto:	§対局開始ルーチン
		""",
	],
	"§対局開始ルーチン": [
		# 戦闘開始
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
		{{arg_sente_monster_name}}の先手だ！
		""",
		func():
			# ダメージ計算
			var damage = 1
			self.get_assistant_director().get_node("Var").set_var("arg_damage", str(damage))
			
			# 後手の［玉の遠さ］を減らす
			self.get_game_sheet_for_battle().distance_of_king[1] -= damage
			,
		"""\
		{{arg_sente_monster_name}}
		「歩を突く
		　{{arg_gote_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			# 後手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_gote_distance_of_king()
			,
		func():
			# ダメージ計算
			var damage = 1
			self.get_assistant_director().get_node("Var").set_var("arg_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.get_game_sheet_for_battle().distance_of_king[0] -= 1
			,
		"""\
		{{arg_gote_monster_name}}
		「合わせて歩を突く
		　{{arg_sente_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			# 先手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_sente_distance_of_king()

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
			self.get_assistant_director().get_node("Var").set_var("arg_damage", str(damage))
			
			# 後手の［玉の遠さ］を５減らす
			self.get_game_sheet_for_battle().distance_of_king[1] -= damage

			# 後手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_gote_distance_of_king()
			,
		"""\
		{{arg_sente_monster_name}}
		「銀が上がる
		　{{arg_gote_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():
			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.get_game_sheet_for_battle().distance_of_king[1] < 5:
				self.get_assistant_director().get_node("Goto").goto("§後手番投了")
			else:
				self.get_assistant_director().get_node("Goto").goto("§後手番１")	
			,
	],
	"§後手番１": [
		func():
			# ダメージ計算
			var damage = 5
			self.get_assistant_director().get_node("Var").set_var("arg_damage", str(damage))
			
			# 先手の［玉の遠さ］を５減らす
			self.get_game_sheet_for_battle().distance_of_king[0] -= damage
			
			# 先手の［玉の遠さ］表示更新
			self.get_system_of_battle().refresh_sente_distance_of_king()
			,
		"""\
		{{arg_gote_monster_name}}
		「銀が上がる
		　{{arg_sente_monster_name}}の玉に{{arg_damage}}歩近づく
		""",
		func():			
			# 玉の遠さは、 0 になる前に投了することがある
			if self.get_game_sheet_for_battle().distance_of_king[0] < 5:
				self.get_assistant_director().get_node("Goto").goto("§先手番投了")
			else:
				self.get_assistant_director().get_node("Goto").goto("§先手番１")	
			,
	],
	"§先手番投了": [
		"""\
		{{arg_gote_monster_name}}
		「参りました
		""",
		"""\
		!
		goto:	§戦闘終了１
		""",
	],
	"§後手番投了": [
		"""\
		{{arg_gote_monster_name}}
		「参りました
		""",
		"""\
		!
		goto:	§戦闘終了１
		""",
	],
	"§戦闘終了１": [
		# 戦闘終了
		"""\
		!
		bg:				{{arg_bg_in}}			,hide
		bg:				{{arg_bg_out}}
		bg:				🗻戦闘シーン			,hide
		monster_face:	😁きふわらべ			,hide
		monster:		{{arg_monster_body}}	,hide
		monster_face:	{{arg_monster_face}}	,hide
		telop:			Ｔ戦闘シーン			,hide
		department:		📗ビジュアルノベル部門
		goto:			{{arg_return}}
		""",
	],
	#
	#
	#
	"§２回目戦闘シーン":[
		# 戦闘開始
		"""\
		!
		bg:				🗻戦闘シーン
		telop:			Ｔ戦闘シーン
		monster_face:	😁きふわらべ
		monster:		{{arg_monster_body}}
		monster_face:	{{arg_monster_face}}
		""",
		"""\
		!
		var:		goto_next_section_from_encount_transition	,§２回目戦闘シーン＜開始＞
		goto:		§ロード・データ
		""",
	],
	"§２回目戦闘シーン＜開始＞":[
		# 画面設定
		"""\
		!
		bgm:			🎵バトル２
		m_wnd:			■下
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
		bg:				🗻戦闘シーン		,hide
		monster_face:	😁きふわらべ, hide
		monster:		{{arg_monster_body}}	,hide
		monster_face:	{{arg_monster_face}}	,hide
		telop:			Ｔ戦闘シーン, hide
		department:		📗ビジュアルノベル部門
		goto:			{{arg_return}}
		""",
	],
	#
	#
	#
	"§３回目戦闘シーン":[
		# 戦闘開始
		"""\
		!
		bg:				🗻戦闘シーン
		telop:			Ｔ戦闘シーン
		monster_face:	😁きふわらべ
		monster:		{{arg_monster_body}}
		monster_face:	{{arg_monster_face}}
		""",
		"""\
		!
		var:		goto_next_section_from_encount_transition	,§３回目戦闘シーン＜開始＞
		goto:		§ロード・データ
		""",
	],
	"§３回目戦闘シーン＜開始＞":[
		# 画面設定
		"""\
		!
		bgm:			🎵バトル３
		m_wnd:			■下
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
		bg:				🗻戦闘シーン			,hide
		monster_face:	😁きふわらべ			,hide
		monster:		{{arg_monster_body}}	,hide
		monster_face:	{{arg_monster_face}}	,hide
		telop:			Ｔ戦闘シーン, hide
		department:		📗ビジュアルノベル部門
		goto:			{{arg_return}}
		""",
	],
	#
	# 昼ビール
	#
	"§ＶＳ昼ビール":[
		# 戦闘開始
		"""\
		!
		bg:				🗻戦闘シーン
		telop:			Ｔ戦闘シーン
		monster_face:	😁きふわらべ
		monster:		{{arg_monster_body}}
		monster_face:	{{arg_monster_face}}
		""",
		"""\
		!
		var:		goto_next_section_from_encount_transition	,§ＶＳ昼ビール＜開始＞
		goto:		§ロード・データ
		""",
	],
	"§ＶＳ昼ビール＜開始＞":[
		# 画面設定
		"""\
		!
		bgm:			🎵バトル３
		m_wnd:			■下
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
		#label:		Director/TelopCoordinator/Ｔ戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/Ｔ戦闘シーン/玉の遠さ_上		,"　　　　　１２２９９９９９９９９９"
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
		label:		Director/TelopCoordinator/Ｔ戦闘シーン/城の堅さ_上		,"４４００"
		#label:		Director/TelopCoordinator/Ｔ戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/Ｔ戦闘シーン/玉の遠さ_上		,"　　　　　１２３０００００００９９"
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
		bg:				🗻戦闘シーン			,hide
		monster_face:	😁きふわらべ			,hide
		monster:		{{arg_monster_body}}	,hide
		monster_face:	{{arg_monster_face}}	,hide
		telop:			Ｔ戦闘シーン				,hide
		m_wnd:			■下						,hide
		department:		📗ビジュアルノベル部門
		goto:			{{arg_return}}
		m_wnd:			■下
		""",
	],
}
