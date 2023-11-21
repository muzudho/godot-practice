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

.