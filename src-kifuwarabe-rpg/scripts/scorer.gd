# スコアラー（Scorer；記録する人）
extends Node


func get_game_sheet_for_battle():
	return $"GameSheetForBattle"


func get_monster_data():
	return $"MonsterData"


# モンスター名を指定すると、モンスターＩｄを返す。該当がなければ 0 を返す
func lookup_monster_id_by_name(monster_name):
	for record in self.get_monster_data().table:
		if record["name"] == monster_name:
			return record["id"]
	
	# 該当なし
	return 0


# 先手と後手のモンスターＩｄを指定すると、
# マスターデータから　ゲームデータへ内容をコピーする
func load_game_data_for_battle(sente_id, gote_id):
	
	var records = []

	# 先手のレコード
	records[0] = self.get_monster_data().table[sente_id]
	
	# 後手のレコード
	records[1] = self.get_monster_data().table[gote_id]

	# 先手のゲームデータ
	var game_sheet = self.get_game_sheet_for_battle()

	game_sheet.id_of_characters[0] = sente_id
	game_sheet.id_of_characters[1] = gote_id

	for i in range(2):

		game_sheet.solidity_of_castle[i] = records[i].solidity_of_castle
		game_sheet.breadth_of_escape_route[i] = records[i].breadth_of_escape_route
		game_sheet.work_of_pieces[i] = records[i].work_of_pieces
		game_sheet.offensive_speed[i] = records[i].offensive_speed
		game_sheet.distance_of_king[i] = records[i].distance_of_king
