# 親の記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　**GDScript** の説明は　下のリンク先にあるぜ」  

📖　[Godot Engine 4.2の日本語のドキュメント / スクリプト言語](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/scripting_languages.html#doc-scripting)  

# ノード

![202309__godot__30-0005--Node-o2o0.png](https://crieit.now.sh/upload_images/fdd39aeaa2d5c671f89ffed9d658be156516e889b7f77.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　**Godot** にあるものは全て　ノード（Node）で、  
**GDScript** というのは　そのノードを操作するものみたいだな」  

# Python に似ているが全然別物

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　GDScript は Python に似ているが　全然別物ということだぜ。  
新しく覚え直せだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　また、GDScript の実行速度は遅いらしいぜ。  
GDScript は C++ 言語で書かれたプログラムを呼び出すから、内部的な処理は速いらしいぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Python と同じ生き方してんな」  

# Godot の独特な用語：　シーン

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　Godot には　ノードと　シーンという用語が出てくるんだけど、  
計算機科学の　わたしたちから見ると　造語のクセがあるわよ」  

📖　[ノードとシーン](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/nodes_and_scenes.html)

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　えーと、つまり」  

![202309__godot__30-0031--GraphTheory.png](https://crieit.now.sh/upload_images/3f070cde77a220f4642ea4987d8605926516ee88a3639.png)  

.![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　グラフセオリー（Graph Theory；グラフ理論）の一題材の　ツリー・ストラクチャー（Tree Structure；木構造）を  
わたしたちは　知っているが」  

![202309__godot__30-0035--GodotScene.png](https://crieit.now.sh/upload_images/0c720d2ecfdc095edc3554898aae1be36516ef2d9a4a9.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　Godot は　ツリーのことを　シーン（Scene）と言い換えているのかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　多分そう」  

![202309__godot__30-0039--SubTree.png](https://crieit.now.sh/upload_images/c723716349b74fe153556ddc74bae6306516f01b5fe5a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　さらに　計算機科学の　わたしたちは　木の中に含まれるサブツリー（Subtree；部分木）を知っているぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　部分木もまた　木よね」  

![202309__godot__30-0043--GodotSceneNest.png](https://crieit.now.sh/upload_images/5e451eea55c0b09804de8b311bfb3e1c6516f0ee9926c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Godot では、 シーンもまた　ノードになる、という　**言い方**　をしている」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　シーンは　ツリーなんだ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シーン、つまり　サブツリーのファイルの拡張子は 　`.tscn`　のようね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　なんて発音するか分からん嫌な拡張子だ……　ティーシーン？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot は、 `.tscn` を再生するプレイヤーなのよ」  

# GDScript Reference

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　GDScript のリファレンスがあるそうだぜ。リンクをメモしておこう」  

📖　[GDScript reference](https://docs.godotengine.org/ja/4.x/tutorials/scripting/gdscript/gdscript_basics.html#doc-gdscript)  

# なんか　画像素材を１つ用意しろだぜ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　プログラムのレッスンを進めていくんで、なにか　小さな画像素材を　１つ用意してくれだぜ」  

![2016_8_6_0_20_30_88_c1.png](https://crieit.now.sh/upload_images/81b266d4e53136836776cee61a431baf6516f3666e8a1.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　わたしで　いいかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しかたないな……　じゃあ　それで」  

# 新規プロジェクト作成

![202309__godot__30-0059--NewProject.png](https://crieit.now.sh/upload_images/ea6276feae259d433b92b132db97782f6516f47a9b839.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Godot で新規プロジェクトを作成するぜ」  

![202309__godot__30-0059--o2o0.png](https://crieit.now.sh/upload_images/43d0406d967c661b9a56c44ee32f73736516f6f639a5a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　最初に選ぶのが　**その他のノード**　って　どうかしてるよな？」  

![202309__godot__30-0111--Sprite2D-o2o0.png](https://crieit.now.sh/upload_images/ebbf6b76ee6b2b6cb31f73d22a9c18456516f770eb735.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　その中から　**Sprite2D**　を選ぶなんて、直観的に無理だぜ」  

![202309__godot__30-0113--Editor-Sprite2DNode-o2o0.png](https://crieit.now.sh/upload_images/cde187520b2984c5e82ab352c09a72336516f7d29430c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これが　Sprite2D　をルート（Root；根）に持つ　シーン（※つまりサブツリー）を作成したところだぜ」  

![202309__godot__30-0120--Texture-o2o0.png](https://crieit.now.sh/upload_images/0173158b360e46e8e9d15af9ad0e82c66516f9b5b2965.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　テクスチャー欄へ　さっきの画像を読み込めだぜ」  

# 新規 GDScript 作成：　ハローワールド

![202309__godot__30-0125--NewScript-o2o0.png](https://crieit.now.sh/upload_images/745d4a4ff407d1709f9bd69da1ef33316516fa965af4c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　次に　**新規スクリプト**　を作ったらいいのかな？」  

![202309__godot__30-0127--TemplateEmpty-o2o0.png](https://crieit.now.sh/upload_images/0272a6f6df3677df1bea5cc0205b74396516fb13d82ab.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　テンプレートを **Object:Empty** にしとけだそうだぜ」  

![202309__godot__30-0129--CodeEditor.png](https://crieit.now.sh/upload_images/72a1822b4b069e6a7830155b071d2a1a6516fb775159f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　なんか　コード・エディターが出てくるな。ここに GDScript を書けばいいのだろう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　かっこいいコードを書いてくれよ」  

```gd
extends Sprite2D

func _init():
	print("Hello, world!")
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　サンプル通り書いてみよう」  

![202309__godot__30-0133--Run-o2o0.png](https://crieit.now.sh/upload_images/e2052a5a11d13176660d735f7b4f60916516fc9c87956.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　なんか　分からんな……　**現在のものを選択** で」  

![202309__godot__30-0135--HelloWorld-o2o0.png](https://crieit.now.sh/upload_images/a8b6e722733ba947f41399dfc81efc226516fd219827a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　**Hello, world!**　と出力ビューに表示されたな」  

## コンストラクター：　_init()

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`func _init():` メソッドは　コンストラクタなんだ」  

# くるくる回す

![202309__godot__30-0145--Rotation.png](https://crieit.now.sh/upload_images/b489de93c54dc490ea700d674f50189d6516ff5b4b686.png)  

```gd
extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):
	rotation += angular_speed * delta
```


![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　サンプル通り書いてみよう。　くるくる回ってるぜ」  

## 時間軸の１つ分の処理：　_process(delta)

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`func _process(delta):` メソッドは　時間 delta 分の処理なんだ」  

## Tips: Ctrl + Click

![202309__godot__30-0149--CtrlClick-o2o0.png](https://crieit.now.sh/upload_images/aa78c037ac0389d5c9bc1824581f2b4465170065e891a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Ctrl` キーを押しながら　コードをクリックすると　説明が出てきたり、定義に飛んだりするようだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　そんな裏技仕込むの　止めてほしいわね」  

## 洗濯機の中の衣類のように周る

```gd
extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):
	# その場で　ねずみ花火のように　くるくる回る
	rotation += angular_speed * delta

	# 洗濯機の中の衣類のように　周る
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta	
```

📺　[動画](https://x.com/muzudho1/status/1707801968616550478?s=20)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　分かったぜ」  

# 入力

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　次の課題は　入力よ」  

📖　[プレイヤーの入力を聞く](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/scripting_player_input.html)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　入力のインプットを受け取る方法は　２種類あって、  
`Input` シングルトンを使う方法と、 `_unhandled_input()` コールバック関数を使う方法があるようだぜ」  

```gd
extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):
	# その場で　ねずみ花火のように　くるくる回る
	rotation += angular_speed * delta

	# 洗濯機の中の衣類のように　周る
	var velocity = Vector2.UP.rotated(rotation) * speed
	var movement = velocity * delta

	# 何も押さなければその場で回転
	var direction = 0
	# 左キー押下で頭上の方へ進む
	if Input.is_action_pressed("ui_left"):
		direction = -1
	# 右キー押下で足下の方へ進む
	if Input.is_action_pressed("ui_right"):
		direction = 1
	movement *= direction

	# 移動ベクトルを足す
	position += movement
```

📺　[動画](https://x.com/muzudho1/status/1707956784898646248?s=20)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　分かったぜ」  

![202309__godot__30-1304--inputMap-o2o0.png](https://crieit.now.sh/upload_images/29befd42d7210ed69b9a1b70f6752dc465179e8c10f1f.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　**プロジェクト設定** の **インプットマップ** タブを見れば　`Input.is_action_pressed()` メソッドの引数に何書いたらいいか  
自分で調べられるそうだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　助かるぜ」  

```gd
extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):

	var velocity = Vector2.ZERO
	
	# 上キーを押していなければ進まない仕組み
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	# その場で　ねずみ花火のように　くるくる回る
	rotation += angular_speed * delta

	# 洗濯機の中の衣類のように　周る
	var movement = velocity * delta

	# 何も押さなければその場で回転
	var direction = 0
	# 左キー押下で頭上の方へ進む
	if Input.is_action_pressed("ui_left"):
		direction = -1
	# 右キー押下で足下の方へ進む
	if Input.is_action_pressed("ui_right"):
		direction = 1
	movement *= direction
	
	# 移動ベクトルを足す
	position += movement
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　上キーを押していなければ　進まないという仕組みも追加したぜ」  

.