# 親記事から来た

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

# Godot の言うシグナル：　イベントハンドラーみたいなもん

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　次の課題は　シグナル（Signal；信号）よ」  

📖　[シグナルの使用](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/signals.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　イベントハンドラーじゃないのかだぜ？　Linux　みたいだな」  

![202309__godot__30-1331--NewScene-o2o0.png](https://crieit.now.sh/upload_images/99baf2fc25b81d2b4454f7d6714e42546517a4ae6c418.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　新しいシーンを作れとのことだぜ。　シーンって何なんだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　サブツリーのルートノード（Root Node；根）なんじゃないか？

![202309__godot__30-1333--RootNode-o2o0.png](https://crieit.now.sh/upload_images/4f13481d8de1a65c0cac3a780c634a436517a5507a118.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　シーンは　サブツリーなのよ。　サブツリーのルートをさらに選ぶのよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シーンなんて用語　造語されたら　ぐちゃぐちゃだぜ」  

![202309__godot__30-1336--2DScene-o2o0.png](https://crieit.now.sh/upload_images/a22c3b41e3c53784f790b75fec6b4f0c6517a5ff240a4.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`2D シーン` を選べとのことだぜ」  

![202309__godot__30-1338--Node2DRoot-o2o0.png](https://crieit.now.sh/upload_images/f6006ebcdbdaea3a731e81340cdd49196517a668cf652.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　なんで　`2D シーン`　を選んで、出てくるのが　`Node2D`　なんだぜ？　技術的に　ぐちゃぐちゃだな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　べつに　技術をウリにしてないんだろ」  

![202309__godot__30-1342--AddChildNode-o2o0.png](https://crieit.now.sh/upload_images/0bf11477147a15aebd932108aa9843a46517a74fb3b22.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　子ノードとして　`Button`　を追加しろとのことだぜ」  

`Node/CanvasItem/Control/BaseButton/Button`  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　なんか　クラス階層図みたいなツリー構造だな。 `BaseButton` の下に `Button` が出てくるの　カッコ悪いよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　みたい、じゃなくて、クラス階層図なんじゃない？」  

![202309__godot__30-1347--ButtonSubTree.png](https://crieit.now.sh/upload_images/4ca275d7f406ce30952797a9881296166517a86d669a7.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あれっ？　きふわらべ　どこに行ったんだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父んの方が　別のサブツリーに行ったんだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　だいたい　わかった」  

![202309__godot__30-1351--ButtonLabel-o2o0.png](https://crieit.now.sh/upload_images/e58955b63e12b4eeed2b796d5867e0976517a9bfc0a76.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォント・サイズはどこで変えれるんだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot は ノードを主張してるくせに　`Button`　のサブ・ノードが見えないじゃない」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　べつに　技術をウリにしてないんだろ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　もう　先々　苦労しそうだな」  

![202309__godot__30-1357--F6Key.png](https://crieit.now.sh/upload_images/b859aa8fe93be25c91b7fd1aa0349a746517aacdc271b.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　`F6` キーを打鍵すると　サブツリーを　動作テストできるそうだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　そんな裏技仕込むの　止めてほしいわね」  

![202309__godot__30-1401--NodeSignal-o2o0.png](https://crieit.now.sh/upload_images/a26a07191c5b071b3095a61455d0c8516517abf3bffd6.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　`ノード` タブをクリックすると　シグナルの一覧が出てくるぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　お前は　**インスペクター**　なんじゃないの？  
なんで　インスペクターの隣の　**ノード**　タブをクリックしたんだぜ？  
ノード　タブは、インスペクターじゃないってのかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ノード　タブは　インスペクター　じゃないのよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot の国語は　ぐちゃぐちゃ　だな。技術的にクソだ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　べつに　国語も　技術も　ウリにしてないんだろ」  

![202309__godot__30-1406--pressed-o2o0.png](https://crieit.now.sh/upload_images/1a87f1b891e9098385263a910011c31b6517ad1f459da.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　`BaseButton` の下に `pressed()` メソッドがあるから　ダブル・クリックしろだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`pressed()` は メソッドなの？　シグナルなの？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`pressed()` メソッドは　`pressed` メッセージが送られてきたときに実行されるイベントハンドラーなんじゃないか？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　本当にそうだろうか？」  

![202309__godot__30-1413--cutAndPaste-o2o0.png](https://crieit.now.sh/upload_images/d0842a41d7e9ab37b679a9c8bdd5b7126517aeaa021fe.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　きふわらべが　別のサブツリーに居て　アクセスできなかったので、  
カット＆ペーストで　連れてきたぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　元　居たツリーは　今　どうなってんだぜ？」  

![202309__godot__30-1415--emptyTree.png](https://crieit.now.sh/upload_images/6a399bc7533aade13f12f764ec4068fe6517af1e7eaf0.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　エンプティセット（Empty Set；空集合，くうしゅうごう）だぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　保存はできるのか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　不思議な話だが、エンプティセットは　保存できないぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ウィンドウを閉じれば　同値よ」  

![202309__godot__30-1429--signal-o2o0.png](https://crieit.now.sh/upload_images/27ed21a44294aba69a62282080a3e4226517b28e975af.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　センダー（Sender；送信者）である BaseButton の `pressed()` メソッドが呼び出されたとき、  
さらに　レシーバー（Receiver；受信者）である Sprite2D の `_on_button_pressed` メソッドが呼び出される」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　と考えたらいいんじゃないかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シグナルは　どこにあんのよ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot の開発者たちは　国語のセンスがないことが分かった。わたしが　言い換えてやるぜ」  

![202309__godot__30-1436--eventHandler-o2o0.png](https://crieit.now.sh/upload_images/bdf08988dc220681738ec431998dedeb6517b43438745.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　わたしのコードに　イベントハンドラーが　勝手に追加されたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　そこに　ボタンが押されたときに　やりたい処理を書けばいいのよ」  

![202309__godot__30-1436--eventHandler-o3o0.png](https://crieit.now.sh/upload_images/1b59db21bf318cbc6210dba1942042116517b4da4112d.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　イベントハンドラーのシグネチャーの左横に　緑色の矢印が表示されていて、クリックできるそうだぜ」  

![202309__godot__30-1441--connection.png](https://crieit.now.sh/upload_images/475243ba585fc69677ea7b372cce6f066517b53a0dc81.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　説明が出てきた。まあ　そうなんだろうな」  

```gd
func _on_button_pressed():
	# 働いてたら休む。
	# 休んでたら働く。
	set_process(not is_processing())
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ボタンを押下したときのコードを　サンプルに従って書いたぜ。  
メソッド名が悪いよな。意味が分からん。まあ　Godot は、国語がウリではないから　仕方ない」  

![202309__godot__30-1448--run.png](https://crieit.now.sh/upload_images/2ee823104a0e92408e6e199ef46551826517b6cd8c024.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あれっ？　ボタンが無いぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　エンプティセットを保存してないから、古いサブツリーを実行しているのでは？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　実行ボタンをクリックしたときに実行される　サブツリー　は、どこで変更できる？」  

![202309__godot__30-1453--applicationRun.png](https://crieit.now.sh/upload_images/04be6e51c0bb8bdaf1852ebfec8b9f126517b80f7cc83.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　プロジェクト設定の中を探していけば　あるぜ」  

![202309__godot__30-1455--run.png](https://crieit.now.sh/upload_images/c17285e0414e680f05bac7104e07b5546517b856121d7.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　よしでけた」  

# Ctrl + F1

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　エディターに戻って　`Ctrl + F1` キーを押してみろだぜ」  

![202309__godot__30-1517--CtrlF7.png](https://crieit.now.sh/upload_images/c69d8e288cdddacee1e04b1d561688d06517bd9322f97.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　お前が出てきたけど……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ルートに戻ったんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　メイン・シーンの方に戻ってほしいぜ」  

# Timer

![202309__godot__30-1522--Timer-o2o0.png](https://crieit.now.sh/upload_images/e43a695421dbe4546c001fc1af7372796517bee511c38.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　サンプルに従って　タイマーを追加するぜ」  

![202309__godot__30-1524--AutoStart-o2o0.png](https://crieit.now.sh/upload_images/79f0e556a695b23730a04ea3079a7d636517bf3fe9c6e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Autostart をオンに設定」  

![202309__godot__30-1530--ScriptButton.png](https://crieit.now.sh/upload_images/380aefc0bfd1d42c51a0c6b20163b6ef6517c0752e112.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　上図のボタンをクリックすると　スクリプトのページが開くそうだぜ」  

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


func _on_button_pressed():
	# 働いてたら休む。
	# 休んでたら働く。
	set_process(not is_processing())

# サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# タイマーノード取得
	var timer = get_node("Timer")
	# timer ソースの timeout シグナルに _on_timer_timerout メソッドを接続
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	# 可視性を反転
	visible = not visible
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　全部のコード載せたろ」  

📺　[動画](https://x.com/muzudho1/status/1708008555952132115?s=20)  

# カスタムシグナル

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　シグナルを自作する方法の解説も載ってるわよ」  

📖　[カスタムシグナル](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/signals.html#custom-signals)  


.