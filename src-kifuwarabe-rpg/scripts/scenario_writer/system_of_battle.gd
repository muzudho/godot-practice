# システム・オブ・バトル（System Of Battle；戦闘システム）
#	バトル部門が使うユーティリティー
extends Node


func get_director():
	return $"../../../../Director"


func get_assistant_director():
	return $"../../../../Director/AssistantDirector"


func get_telop_coordinator():
	return $"../../../../Director/TelopCoordinator"


func get_scorer():
	return $"../../../../Director/Scorer"


func get_game_sheet_for_battle():
	return $"../../../../Director/Scorer/GameSheetForBattle"


# 先手の［城の堅さ］表示更新
func refresh_sente_solidity_of_castle():
	self.get_telop_coordinator().get_node("戦闘シーン/城の堅さ_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().solidity_of_castle[0], 4)


# 先手の［逃げ道の広さ］表示更新
func refresh_sente_breadth_of_escape_route():
	self.get_telop_coordinator().get_node("戦闘シーン/逃げ道の広さ_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[0], 4)


# 先手の［駒の働き］表示更新
func refresh_sente_work_of_pieces():
	self.get_telop_coordinator().get_node("戦闘シーン/駒の働き_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[0], 4)


# 先手の［攻めの速度］表示更新
func refresh_sente_offensive_speed():
	self.get_telop_coordinator().get_node("戦闘シーン/攻めの速度_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[0], 4)


# 先手の［玉の遠さ］表示更新
func refresh_sente_distance_of_king():
	self.get_telop_coordinator().get_node("戦闘シーン/玉の遠さ_下").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[0], 17)


# 後手の［城の堅さ］表示更新
func refresh_gote_solidity_of_castle():
	self.get_telop_coordinator().get_node("戦闘シーン/城の堅さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().solidity_of_castle[1], 4)


# 後手の［逃げ道の広さ］表示更新
func refresh_gote_breadth_of_escape_route():
	self.get_telop_coordinator().get_node("戦闘シーン/逃げ道の広さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[1], 4)


# 後手の［駒の働き］表示更新
func refresh_gote_work_of_pieces():
	self.get_telop_coordinator().get_node("戦闘シーン/駒の働き_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[1], 4)


# 後手の［攻めの速度］表示更新
func refresh_gote_offensive_speed():
	self.get_telop_coordinator().get_node("戦闘シーン/攻めの速度_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[1], 4)


# 後手の［玉の遠さ］表示更新
func refresh_gote_distance_of_king():
	self.get_telop_coordinator().get_node("戦闘シーン/玉の遠さ_上").text = self.get_assistant_director().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[1], 17)
