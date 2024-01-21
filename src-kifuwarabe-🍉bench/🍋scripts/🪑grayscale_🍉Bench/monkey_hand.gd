# モンキー・ハンド（Monkey hand；猿の手）
#
# ノードをつかみに行く
extends Node


class_name MonkeyHand


# ーーーーーーーー
# 生成
# ーーーーーーーー


# 生成
static func create(
		node_to_find_1):	# Node
	var monkey_hand = MonkeyHand.new()
	monkey_hand.node_to_find = node_to_find_1	
	return monkey_hand


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 探す場所
var node_to_find = null

# キャッシュ辞書
var cache_dictionary = {}


# ーーーーーーーー
# メソッド
# ーーーーーーーー


# 指定フォルダーの中の指定ノード取得
func find_node(
		target_name):			# StringName. `🗻` で始まる名前を想定
	return MonkeyHelper.find_node(
			target_name,
			self.node_to_find,		# 探す場所
			func():
				return self.cache_dictionary)	# 結果を格納する変数
