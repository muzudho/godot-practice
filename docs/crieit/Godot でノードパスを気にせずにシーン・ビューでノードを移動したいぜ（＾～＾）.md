# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# 情報

📖　[Git Hub / きふわらべRPG、他](https://github.com/muzudho/godot-practice)  
📺　[Discord サーバー 招待 / きふわらべRPG](https://t.co/ZvT1ICT9x8)  

# はじめに

![202311__shogi__21-1906--folder-o2o0.png](https://crieit.now.sh/upload_images/a9d8e33df75340cb3aae1214ee2b6af4655c82453f6c7.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォルダーを自由に作って　そこにノードを移動できるようにしたいぜ。  
そのとき　パスも　リンク切れしないようにしたいぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot エディター上で　移動すれば　リンクは切れないんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ノードパスの仕様が難しい。もっと適当に　ノードを移動したい」  

![202311__shogi__21-1919--node-path-o2o0.png](https://crieit.now.sh/upload_images/105ecd83f2c980c07567a437ac60f97e655c845cc5d17.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　このような　ハードコーティングしたノードパスを　自動で修正してくれる仕掛けが  
Godot には　あるらしいぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　やってみろだぜ」  

![202311__shogi__21-1925--node-moved.png](https://crieit.now.sh/upload_images/9667e2c6013a78af394fb214949ae487655c85bba0d19.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな風に　ノードを移動しても、さっきのノードパスは　自動で変更されるといったことはないぜ」  

## 変更案

```gd
#func hub():
#	return $"../../🛩️ScenarioWritersHub"


# シナリオライターズ・ハブ取得
func hub():
	var cur_node = $".."
	
	while cur_node != null:
		if cur_node.has_node("🛩️ScenarioWritersHub"):
			return cur_node.get_node("🛩️ScenarioWritersHub")
		
		cur_node = cur_node.get_parent()
	
	return null
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　例えば　上記のように書きかえれば　親をさかのぼって探してくれるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　キャッシュした方が　よくないか？」  

```gd
var cached_hubs = {}

# シナリオライターズ・ハブ取得
func hub():
	var target = "🛩️ScenarioWritersHub"
	
	if target in self.cached_hubs:
		return self.cached_hubs[target]
	
	var cur = $".."
	
	while cur != null:
		if cur.has_node(target):
			var hub = cur.get_node(target)
			self.cached_hubs[target] = hub
			return hub
		
		cur = cur.get_parent()
	
	return null
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　こうだぜ」  

# モジュール化

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　そのコードを使い回せるようにしたら　いいんじゃない？」  

📄 `monkey.gd`:  

```gd
extends Object


class_name Monkey


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var cached_ancestor_children = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# 親の直下の子を調べる。なければ、祖先の直下の子を調べる
func find_ancestor_child(
		current_node,		# Node
		target_node_name):	# StringName
	
	var cur = current_node
	var target = str(target_node_name)
	
	if target in self.cached_ancestor_children:
		return self.cached_ancestor_children[target]
		
	while cur != null:
		if cur.has_node(target):
			var hub = cur.get_node(target)
			self.cached_ancestor_children[target] = hub
			return hub
		
		cur = cur.get_parent()
	
	return null
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　`monkey.gd`　を作るぜ」  

```gd
# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# シナリオライターズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ScenarioWritersHub")
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あとは　それを使うだけだぜ」  

## トレードオフ

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ノードの置き場所が自由になった分、  
ノードパスによるノードの識別が　できなくなるわね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　運用でカバーしろだぜ」  

## フォルダーの深い所に置いたから、探索しろだぜ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しまった！」  

📄 `scenario_writers_hub.gd` :  

```gd
# 指定の部門下の scenario_document 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_scenario_document(department_name):
	if not (department_name in self.cached_scenario_document):
		var book_node = self.get_scenario_writer().get_node(str(department_name))
		self.cached_scenario_document[department_name] = {}

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, book_node)

	return self.cached_scenario_document[department_name]


func search_merged_scenario_document(department_name, current_node):
	for child_node in current_node.get_children():
		if "scenario_document" in child_node:
			self.cached_scenario_document[department_name].merge(child_node.scenario_document)

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, child_node)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォルダーの下まで　再帰的に探索するコードを書いてないぜ」  

📄 `programs_hub.gd` :  

```gd
# 全ての部門名一覧
func get_all_department_names():
	if self.cached_all_department_names == null:
		self.cached_all_department_names = []	# StringName の配列

		# 結果は変数に格納される
		self.search_all_department_names(
				self.get_scenario_writer())
			
	return self.cached_all_department_names


# 結果は変数に格納される
func search_all_department_names(current_node):
	for child_node in current_node.get_children():
		# 部門のノード名は `📗` で始まるものとする
		if child_node.name.begins_with("📗"):
			self.cached_all_department_names.append(child_node.name)
		
		# `📂` で始まるノード名は、さらにその中も再帰的に探索されるものとする
		elif child_node.name.begins_with("📂"):
			self.search_all_department_names(child_node)
```

📄 `scenario_writers_hub` :  

```gd
# 指定の部門下の scenario_document 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_scenario_document(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_scenario_document):
		
		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = self.search_scenario_book_node(
				self.get_scenario_writer(),
				str(department_name))
		self.cached_scenario_document[department_name] = {}

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, book_node)

	return self.cached_scenario_document[department_name]


# ［📗～］ノードを探索
func search_scenario_book_node(
		current_node,
		department_name_str):
	if current_node.has_node(department_name_str):
		return current_node.get_node(department_name_str)

	for child_node in current_node.get_children():
		var book_node = self.search_scenario_book_node(
				child_node,
				department_name_str)
		
		if book_node != null:
			return book_node


func search_merged_scenario_document(department_name, current_node):
	for child_node in current_node.get_children():
		if "scenario_document" in child_node:
			self.cached_scenario_document[department_name].merge(child_node.scenario_document)

		# 再帰。結果は外部変数に格納
		self.search_merged_scenario_document(department_name, child_node)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　まず　部門名を再帰的に探すことにするぜ。  
`📗` で始まるノード名なら　部門名、  
`📂` で始まる名前のノードなら、その中を探索されるぜ」  

![202311__shogi__21-2146--folder-2o0.png](https://crieit.now.sh/upload_images/2fbd3bae185f7f365aa2c7aa99dbb5be655ca6da8efff.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これで　フォルダーの中に　台本を置いて　任意に整理できるようになったぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　任意に置くことができるフォルダーと、  
置く場所が決まってるフォルダーのアイコンを　変えた方がよくない？」  

.