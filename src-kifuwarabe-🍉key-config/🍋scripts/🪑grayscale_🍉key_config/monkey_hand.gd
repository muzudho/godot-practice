# モンキー・ハンド（Monkey hand；猿の手）
#
# ノードをつかみに行く
extends Node


class_name MonkeyHand


# ーーーーーーーー
# 生成
# ーーーーーーーー


# 生成
static func create(target_folder_node):
	var monkey_hand = MonkeyHand.new()
	monkey_hand.target_folder = target_folder_node	
	return monkey_hand


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 探す場所
var target_folder = null

# キャッシュ辞書
var cache_dictionary = {}


# ーーーーーーーー
# メソッド
# ーーーーーーーー


# 指定フォルダーの中の指定ノード取得
func get_node_in_folder(
		target_name):			# StringName. `🗻` で始まる名前を想定
	return MonkeyHelper.find_node_in_folder(
			target_name,
			self.target_folder,		# 探す場所
			func():
				return self.cache_dictionary)	# 結果を格納する変数
