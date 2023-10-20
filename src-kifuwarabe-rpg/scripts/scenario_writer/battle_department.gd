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
	"§戦闘デパートメント開始":[
		# トランジションとデータのロードは並行処理できたらよさそうだが、できてない
		func():
			var sente_monster_name = self.get_director().stage_directions_arguments["sente_monster_name"]
			var gote_monster_name = self.get_director().stage_directions_arguments["gote_monster_name"]
			
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
		bg:				%arg_bg_out%, hide
		bg:				%arg_bg_in%
		sleep:			0.15
		""",
		# ここで画面全体が真っ黒になっている
		"""\
		!
		monster:		%arg_monster%
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
		goto:			§ステータス初期セット
		""",		
	],
	"§ステータス初期セット":[
		# 戦闘開始
		"""\
		!
		se:
		telop:			戦闘シーン
		bgm:			🎵バトル１, 8.6
		monster_face:	😁きふわらべ
		monster_face:	%arg_monster_face%
		""",
		# 画面設定
		func():
			# 先手
			self.get_system_of_battle().refresh_sente_solidity_of_castle()
			self.get_telop_coordinator().get_node("戦闘シーン/逃げ道の広さ_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[0], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/駒の働き_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[0], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/攻めの速度_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[0], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/玉の遠さ_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[0], 17)
			
			# 後手
			self.get_telop_coordinator().get_node("戦闘シーン/城の堅さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().solidity_of_castle[1], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/逃げ道の広さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[1], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/駒の働き_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[1], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/攻めの速度_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[1], 4)
			self.get_telop_coordinator().get_node("戦闘シーン/玉の遠さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[1], 17)
			
			# 匿名関数の終わりのコンマ
			,
		"""\
		!
		goto:	§対局開始ルーチン
		""",
	],
	"§対局開始ルーチン": [
		# 戦闘開始
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おっと　戦闘シーンはまだ
		　できてないらしいぜ
		""",
		"""\
		審判
		「ログインしてくださーい！
		""",
		"""\
		両対局者
		「「よろしくお願いします
		""",
		"""\
		〇〇の先手だ！
		〇〇
		「歩を突く
		""",
		func():
			# 後手の［玉の遠さ］を５減らす
			self.get_game_sheet_for_battle().distance_of_king[1] -= 5
			
			self.get_telop_coordinator().get_node("戦闘シーン/玉の遠さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[1], 17)
			pass
			,
		"""\
		☆☆
		「合わせて歩を突く
		""",
		func():
			pass
			,
		"""\
		〇〇
		「香を１マス突く
		""",
		func():
			pass
			,
		"""\
		☆☆
		「駒組に手を付ける
		""",
		func():
			pass
			,
		"""\
		!
		goto:	§先手番１
		""",
	],
	"§先手番１": [
		"""\
		〇〇
		「銀が上がる
		""",
		"""\
		!
		goto:	§後手番１
		""",
	],
	"§後手番１": [
		"""\
		☆☆
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
		bg:				%arg_bg_in%			,hide
		bg:				%arg_bg_out%
		bg:				🗻戦闘シーン		,hide
		monster_face:	😁きふわらべ		,hide
		monster:		%arg_monster%		,hide
		monster_face:	%arg_monster_face%	,hide
		telop:			戦闘シーン			,hide
		m_wnd:			■下					,hide
		department:		📗ビジュアルノベル部門
		goto:			%arg_return%
		m_wnd:			■下
		""",
	],
	"§２回目戦闘シーン":[
		# 戦闘開始
		"""\
		!
		bg:				%arg_bg%
		bg:				🗻戦闘シーン
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル２
		""",
		# 画面設定
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上		,"　　２０"
		label:		Director/TelopCoordinator/戦闘シーン/逃げ道の広さ_上	,"　　１０"
		label:		Director/TelopCoordinator/戦闘シーン/駒の働き_上		,"　　３０"
		label:		Director/TelopCoordinator/戦闘シーン/攻めの速度_上		,"　　１０"
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"　　　　　　　　　　　　　　　４０"
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
		bg:				%arg_bg%			,hide
		bg:				🗻戦闘シーン		,hide
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
		# 戦闘開始
		"""\
		!
		bg:				%arg_bg%
		bg:				🗻戦闘シーン
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル３
		""",
		# 画面設定
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上		,"　１００"
		label:		Director/TelopCoordinator/戦闘シーン/逃げ道の広さ_上	,"　１２０"
		label:		Director/TelopCoordinator/戦闘シーン/駒の働き_上		,"　１００"
		label:		Director/TelopCoordinator/戦闘シーン/攻めの速度_上		,"　１１０"
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"　　　　　　　　　　　　　　１３０"
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
		bg:				%arg_bg%			,hide
		bg:				🗻戦闘シーン		,hide
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
		bg:				%arg_bg%
		bg:				🗻戦闘シーン
		telop:			戦闘シーン
		monster_face:	😁きふわらべ
		monster:		%arg_monster%
		monster_face:	%arg_monster_face%
		bgm:			🎵バトル３
		""",
		# 画面設定
		"""\
		!
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上		,"４３００"
		label:		Director/TelopCoordinator/戦闘シーン/逃げ道の広さ_上	,"４１００"
		label:		Director/TelopCoordinator/戦闘シーン/駒の働き_上		,"４２００"
		label:		Director/TelopCoordinator/戦闘シーン/攻めの速度_上		,"４１００"
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"　　　　　１２３０００００００００"
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
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"　　　　　１２２９９９９９９９９９"
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
		label:		Director/TelopCoordinator/戦闘シーン/城の堅さ_上		,"４４００"
		#label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"７６５４３２１０９８７６５４３２１"
		label:		Director/TelopCoordinator/戦闘シーン/玉の遠さ_上		,"　　　　　１２３０００００００９９"
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
		bg:				%arg_bg%			,hide
		bg:				🗻戦闘シーン		,hide
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
