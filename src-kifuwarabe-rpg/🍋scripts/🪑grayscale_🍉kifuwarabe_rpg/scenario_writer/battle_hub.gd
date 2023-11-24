# バトル・ハブ（Battle Hub；戦闘の中心地）
#	📗バトル部門　が使うユーティリティー
extends Node


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


func get_director():
	return MonkeyHelper.find_ancestor(
			self,
			&"🌏Director",
			self.ancestors)


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func get_programs_hub():
	return self.get_director().get_node("🌏Programmer/🛩️ProgramsHub")


func get_telop_coordinator():
	return self.get_director().get_node("🌏TelopCoordinator")


func get_scorer():
	return self.get_director().get_node("Scorer")


func get_game_sheet_for_battle():
	return self.get_director().get_node("Scorer/GameSheetForBattle")


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# その他
# ーーーーーーーー


# 先手の［城の堅さ］表示更新
func refresh_sente_solidity_of_castle():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/城の堅さ_下").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().solidity_of_castle[0], 4)


# 先手の［逃げ道の広さ］表示更新
func refresh_sente_breadth_of_escape_route():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/逃げ道の広さ_下").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[0], 4)


# 先手の［駒の働き］表示更新
func refresh_sente_work_of_pieces():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/駒の働き_下").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[0], 4)


# 先手の［攻めの速度］表示更新
func refresh_sente_offensive_speed():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/攻めの速度_下").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[0], 4)


# 先手の［玉の遠さ］表示更新
func refresh_sente_distance_of_king():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/玉の遠さ_下").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[0], 17)


# 後手の［城の堅さ］表示更新
func refresh_gote_solidity_of_castle():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/城の堅さ_上").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().solidity_of_castle[1], 4)


# 後手の［逃げ道の広さ］表示更新
func refresh_gote_breadth_of_escape_route():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/逃げ道の広さ_上").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().breadth_of_escape_route[1], 4)


# 後手の［駒の働き］表示更新
func refresh_gote_work_of_pieces():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/駒の働き_上").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().work_of_pieces[1], 4)


# 後手の［攻めの速度］表示更新
func refresh_gote_offensive_speed():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/攻めの速度_上").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().offensive_speed[1], 4)


# 後手の［玉の遠さ］表示更新
func refresh_gote_distance_of_king():
	self.get_programs_hub().telops.find_node("Ｔ戦闘シーン/玉の遠さ_上").text = self.get_programs_hub().number_to_zenkaku_text(self.get_game_sheet_for_battle().distance_of_king[1], 17)
