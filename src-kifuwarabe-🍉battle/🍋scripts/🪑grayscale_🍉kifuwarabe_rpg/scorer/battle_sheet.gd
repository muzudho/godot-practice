# ゲーム・シート・フォー・バトル（Game Sheet For Battle；戦闘のための対局用紙）
#	戦闘の計算に関する記録をする
extends Node


# キャラクターＩｄ［0, 0］
var id_of_characters = [0, 0]

# 城の堅さ［先、後］
var solidity_of_castle = [0, 0]

# 逃げ道の広さ［先、後］
var breadth_of_escape_route = [0, 0]

# 駒の働き［先、後］
var work_of_pieces = [0, 0]

# 攻めの速度［先、後］
var offensive_speed = [0, 0]

# 玉の遠さ［先、後］
var distance_of_king = [0, 0]
