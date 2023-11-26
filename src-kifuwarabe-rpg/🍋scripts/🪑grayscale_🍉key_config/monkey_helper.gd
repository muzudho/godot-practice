# モンキー・ヘルパー（Monkey helper；猿の助け）
#
# 木登りの方法を伝授
extends Object


class_name MonkeyHelper


# ノード検索
static func find_node(
		target_name,			# StringName. `🗻` や `📗` などで始まる名前を想定
		target_folder_node,		# 探す場所
		get_cache_dictionary):	# 結果を格納する辞書
	
	# キャッシュに無ければ探索
	if not(target_name in get_cache_dictionary.call()):
		# 探索ルーチン
		MonkeyHelper.search_node_in_folder(
				target_name,
				target_folder_node,		# 探す場所
				func(child_node):
					get_cache_dictionary.call()[target_name] = child_node)
	
	# キャッシュから取得
	return get_cache_dictionary.call()[target_name]


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


# 親の直下の子を調べる。なければ、祖先の直下の子を調べる
static func find_ancestor_child(
		current_node,		# Node
		target_node_name,	# StringName
		ancestor_children_dictionary):
	
	var cur = current_node
	var target = str(target_node_name)
	
	if target in ancestor_children_dictionary:
		return ancestor_children_dictionary[target]
		
	while cur != null:
		if cur.has_node(target):
			var hub = cur.get_node(target)
			ancestor_children_dictionary[target] = hub
			return hub
		
		cur = cur.get_parent()
	
	return null


# 祖先を調べる
static func find_ancestor(
		current_node,		# Node
		target_node_name,	# StringName
		cache_dictionary):
	
	var cur = current_node
	var target = str(target_node_name)
	
	if target in cache_dictionary:
		return cache_dictionary[target]
		
	while cur != null:
		if cur.name == target:
			cache_dictionary[target] = cur
			return cur
		
		cur = cur.get_parent()
	
	return null


# 頭文字が initials のノードを取得。 頭文字が '📂' のノードの下は再帰的に検索
static func search_node_name_begins_with(
		initials,		# StringName 頭文字
		current_node,
		on_node_found):
	for child_node in current_node.get_children():

		# `■` で始まる名前のノードを、メッセージ・ウィンドウの名前とします
		if child_node.name.begins_with(initials):
			on_node_found.call(child_node)

		elif child_node.name.begins_with("📂"):
			MonkeyHelper.search_node_name_begins_with(
					initials,
					child_node,
					on_node_found)
