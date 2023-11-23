# モンキー・ヘルパー（Monkey helper；猿の助け）
#
# 木登りの方法を伝授
extends Object


class_name MonkeyHelper


# ノード検索
static func find_node_in_folder(
		target_name,			# StringName. `🗻` や `📗` などで始まる名前を想定
		get_target_folder,		# 探すフォルダー
		get_cache_dictionary):	# 結果を格納する辞書
	
	# キャッシュに無ければ探索
	if not(target_name in get_cache_dictionary.call()):
		# 探索ルーチン
		MonkeyHelper.search_node_in_folder(
				target_name,
				get_target_folder.call(),	# 探す場所
				func(child_node):
					get_cache_dictionary.call()[target_name] = child_node)
	
	# キャッシュから取得
	return get_cache_dictionary.call()[target_name]


# 結果は変数に格納される
static func search_node_in_folder(
		target_name,			# StringName. `🗻` や `📗` などで始まる名前を想定
		current_node,
		set_found_node):
	
	if current_node.has_node(str(target_name)):
		print("［検索］　現ノード名：❝" + current_node.name + "❞　ヒット：❝" + target_name + "❞")
		# キャッシュに追加
		set_found_node.call(
				current_node.get_node(str(target_name)))
		return
	
	# `📂` で始まる子ノード名は、さらにその中も再帰的に探索されるものとする
	for child_node in current_node.get_children():
		if child_node.name.begins_with("📂"):
			print("［検索］　子ノード名：❝" + child_node.name + "❞")
			MonkeyHelper.search_node_in_folder(
					target_name,
					child_node,
					set_found_node)
