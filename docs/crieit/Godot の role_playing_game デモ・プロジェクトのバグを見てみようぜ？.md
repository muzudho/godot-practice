# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__02-2130--RPGBug.png](https://crieit.now.sh/upload_images/112419e9ad371a7f9ba1649ffe77c96f651ab7f517761.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Godot のデモ・プロジェクトに入っている `role_playing_game` というソースコードには  
コンパイルエラーがあって動かない」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Unity が健在なときは ２番手以下という感じの　選ばれないゲーム・エンジンだからな。  
手入れが行き届いていないのだろう」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ちゃちゃっと　直せないの？」  

## 📄 Game.gd

📄 Game.gd:  

```gd
func _ready():
	exploration_screen = get_node(exploration_screen)
```

![202310__godot__02-2136--ErrorMessage.png](https://crieit.now.sh/upload_images/6cc2afbaea4e8223763eec18b0757512651ab94417379.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　エラーメッセージが出ているが、コピー貼り付けできない。  
とにかく　いろいろなことが　わたしには合わない嫌なエディターだぜ」  

📄 Game.gd:  

```
@export var exploration_screen: NodePath
```

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　ファイルの冒頭のこの行で `exploration_screen` 型は `NodePath` 型だと宣言しているから、  
`exploration_screen = get_node(exploration_screen)` と書いたら `Node` を代入しようとしているから、  
型が合って無いんじゃないの？」  

```gd
a = get_node(a)
```

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　そのそも　形がおかしい」  

📄 Game.gd:  

```gd
extends Node

# @export var combat_screen: NodePath
@export var combat_screen: Node
# @export var exploration_screen: NodePath
@export var exploration_screen: Node

const PLAYER_WIN = "res://dialogue/dialogue_data/player_won.json"
const PLAYER_LOSE = "res://dialogue/dialogue_data/player_lose.json"

func _ready():
	# exploration_screen = get_node(exploration_screen)
	exploration_screen = $"Exploration"
	
	# combat_screen = get_node(combat_screen)
	combat_screen = $"Combat"

# ...
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　上記のように修正するぜ」  

## 📄 TurnQueue.gd

![202310__godot__02-2144--ErrorMessage2.png](https://crieit.now.sh/upload_images/ca3b3df2ecfd1a220ea9c2011092147b651abb6a36d94.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　バグは　まだまだ　あるわよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`combatants_list` が何なのか　コメントも何もない　クソだな」  

📄 TurnQueue.gd:  

```gd
# @export var combatants_list: NodePath
@export var combatants_list: Node

# ...

func _ready():
	# combatants_list = get_node(combatants_list)
	combatants_list = $"Combat"
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　当てずっぽうで　上記のように変更」  

## 📄 UI.gd

![202310__godot__02-2152--ErrorMessage3.png](https://crieit.now.sh/upload_images/0b146565c0f7422a028d2161f2c90cc9651abd47da111.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　バグは　まだまだ　あるわよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　デモ・プロジェクトに　ゴミ・ファイルでも　入れていたのだろうか？」  

📄 UI.gd:  

```gd
#@export var combatants_node: NodePath
@export var combatants_node: Node



func _ready():
	# combatants_node = get_node(combatants_node)
	combatants_node = $"Combat"
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　当てずっぽうで　上記のように変更」  

## 📄 Grid.gd

![202310__godot__02-2156--ErrorMessage4.png](https://crieit.now.sh/upload_images/a6c8b2c063c7de62430529f149d699f4651abdf9ecf68.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　バグは　まだまだ　あるわよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ひどいな……」  

📄 Grid.gd:  

```gd
# @export var dialogue_ui: NodePath
@export var dialogue_ui: Node
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`world_to_map` という関数は無い。修正不能」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  
