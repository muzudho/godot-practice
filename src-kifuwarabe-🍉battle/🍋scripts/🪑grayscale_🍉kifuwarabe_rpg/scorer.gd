# スコアラー（Scorer；記録する人）
extends Node


# ーーーーーーーー
# パス関連
# ーーーーーーーー


func get_game_sheet_for_battle():
	return $"GameSheetForBattle"


func get_monster_data():
	return $"MonsterData"


# ーーーーーーーー
# その他
# ーーーーーーーー


# モンスター名を指定すると、モンスターＩｄを返す。該当がなければ 0 を返す
func lookup_monster_id_by_name(monster_name):
	var table = self.get_monster_data().table
	
	for key in table:
		var record = table[key]
		
		if record["name"] == monster_name:
			print("［スコアラー］　モンスター名：［" + monster_name + "］　Ｉｄ：［" + str(key) + "］")
			return key	# key is monster id
	
	# 該当なし
	print("［スコアラー］　モンスター名：［" + monster_name + "］　該当なし")
	return 0


# 先手と後手のモンスターＩｄを指定すると、
# マスターデータから　ゲームデータへ内容をコピーする
func load_game_data_for_battle(sente_id, gote_id):
	print("［スコアラー］　ロード　先手Ｉｄ：［" + str(sente_id) + "］　後手Ｉｄ：［" + str(gote_id) + "］")

	# 戦闘用紙
	var game_sheet = self.get_game_sheet_for_battle()

	game_sheet.id_of_characters[0] = sente_id
	game_sheet.id_of_characters[1] = gote_id

	var id_array = [sente_id, gote_id]	

	for i in range(2):
		var monster_id = id_array[i]
		var record = self.get_monster_data().table[monster_id]

		game_sheet.solidity_of_castle[i] = record.solidity_of_castle
		game_sheet.breadth_of_escape_route[i] = record.breadth_of_escape_route
		game_sheet.work_of_pieces[i] = record.work_of_pieces
		game_sheet.offensive_speed[i] = record.offensive_speed
		game_sheet.distance_of_king[i] = record.distance_of_king
