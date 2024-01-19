# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# Git Hub

📖　[src-game-controller-key-config](https://github.com/muzudho/godot-practice/tree/main/src-game-controller-key-config)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　キー・コンフィグを作るか、アイデア無いけど」  

![202310__godot__30-2237--KeyConfig.png](https://crieit.now.sh/upload_images/d517593dcee2b1f68e893d8a65af0b6b653fb1d72260e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　まず画面の雰囲気を　仮置きしようぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだぜ」  

📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　ソースは一部抜粋すると　こんな感じ」  

```gd
# ディレクター（Staff）
extends Node2D


var re_button = RegEx.new()
var re_lever = RegEx.new()

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0
# WaitForPrompt, Prompt, WaitForInput, Input, InputOk の５つ。 Wait を入れないと反応過敏になってしまう
var turn_state = &"WaitForPrompt"
var current_step = 1
# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1
var button_presentation_name = &""


# Called when the node enters the scene tree for the first time.
func _ready():

	# この文字列がどう変化するのか、さっぱり分からん
	re_button.compile("Joypad Button (\\d)")
	re_lever.compile("Joypad Motion on Axis (\\d)")


	$"TelopCoordinator/TextBlock".text = """\
	＊　＊　＊
	"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if not (turn_state in [&"WaitForPrompt", &"Prompt", &"WaitForInput", &"InputOk"]):
		return
	
	var is_ok = false
	
	if self.current_step == 1:
		if turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
		
	elif self.current_step == 2:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/決定ボタン".text = "（１）決定ボタン、メッセージ送りボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
		
	elif self.current_step == 3:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/キャンセルボタン".text = "（２）キャンセルボタン、メニューボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン　を押してください"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true

	elif self.current_step == 4:
		if turn_state == &"InputOk":
			$"GuiArtist/KeyConfig_CanvasLayer/メッセージ早送りボタン".text = "（３）メッセージ早送りボタン：　" + self.button_presentation_name
			turn_state = &"WaitForPrompt"
		
		elif turn_state == &"WaitForPrompt":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Prompt"
		
		elif turn_state == &"Prompt":
			$"TelopCoordinator/TextBlock".text = "完了"
			turn_state = &"WaitForInput"

		elif turn_state == &"WaitForInput":
			if self.counter_of_wait < 1.0:
				self.counter_of_wait += delta
				return
			turn_state = &"Input"
			is_ok = true
	
	else:
		pass
	
	if is_ok:
		self.counter_of_wait = 0.0
		self.button_number = -1
		self.button_presentation_name = &""


func _unhandled_input(event):

	# 起動直後に、押してもないレバーが　押したことになっていることがある
	var event_as_text = event.as_text()
	print("入力：　" + event_as_text)
	
	if turn_state != &"Input":
		return

	var is_ok = false
	var acception = "受付：　"

	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	if not is_ok:
		var matched = re_button.search(event_as_text)
		if matched:
			self.button_number = int(matched.get_string(1))
			button_presentation_name = "ボタン" + str(self.button_number)
			is_ok = true

	if not is_ok:
		var matched = re_lever.search(event_as_text)
		if matched:
			var number = int(matched.get_string(1))
			button_presentation_name = "レバー" + str(number)
			self.button_number = number + 1000
			is_ok = true

	if is_ok:
		print(acception)
		self.current_step += 1
		turn_state = &"InputOk"
		print("入力完了")
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　仮組は　こんなもん」  

📺　[動画](https://x.com/muzudho1/status/1719008935167017345?s=20)  

# 📅 2023-11-01 tue ⏰ 25:46

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　仮組は　こんなもん」  

📺　[動画](https://x.com/muzudho1/status/1719394092797579309?s=20)  

# 📅 2023-11-03 fri ⏰ 09:57

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ちょっとでも　パソコンの前に座るか……」  

![202311__godot__03-1452--2Projects.png](https://crieit.now.sh/upload_images/91f8b476ddbd82d67b6491f27beb986c65448adee2dc3.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あっ！　キーコンフィグの内容を　きふわらべＲＰＧへ　コピーできね！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Godot のツリーは　仮想的なもので、実体は無いしな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　わたしたちは　Godot の **Scene** の仕組みを　もっと勉強した方がいいんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　Godot 独自の機能を勉強したって　何になるか知らんけど……」  

📖　[Scenes and Nodes](https://docs.godotengine.org/en/3.1/getting_started/step_by_step/scenes_and_nodes.html)  

## .tscn は、つまりサブツリーか？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ツリーは `*.tscn` ファイル１つに保存できるんじゃないか？  
それで憶測だが `*.tscn` は　サブ・ツリーとしてインポートできるんじゃないか？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　サブツリーとして　インポートするってのは　ディレクトリーのマウントかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`key_config.tscn` が既に　サブツリー　のファイルになってんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ　`key_config.tscn` は　きふわらべＲＰＧから　インポートできるのかだぜ？  
やってみるか……」  

```
  Cannot open file 'res://main_font.tres'.
  Failed loading resource: res://main_font.tres. Make sure resources have been imported by opening the project in the editor at least once.
  Attempt to open script 'res://scripts/key_config_artist.gd' resulted in error 'File not found'.
  Failed loading resource: res://scripts/key_config_artist.gd. Make sure resources have been imported by opening the project in the editor at least once.
  scene/resources/resource_format_text.cpp:283 - res://sub_trees/key_config.tscn:86 - Parse Error: 
  Failed loading resource: res://sub_trees/key_config.tscn. Make sure resources have been imported by opening the project in the editor at least once.
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　エラーが出た」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　リソース・ファイルのインポートも全部やってくれるのかと思ったら、  
ファイルが足らんとエラーだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`*.tscn` ファイルは　インデックスの機能しかないのでは？  
これがドキュメントの言う、　素材と　レシピに分かれていて、　レシピ　しかないという意味では？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そんなもん　全部丸ごと　やってほしいのに……、  
フォルダーを整理するか……」  

## スタジオというメタファーで分けた

![202311__godot__03-1633--StudioFolder-o2o0.png](https://crieit.now.sh/upload_images/59a9c7104b23996d6dc3fc17f2aa58f56544a2b7b4b6f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　スタジオというメタファーで分けたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　団体と、製品名で分けた方がよくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ `studio_grayscale_keyconfig.tscn` とか、 `studio_grayscale_kifuwaraberpg` とかかな。  
そこまで　厳密にやるべきかどうか、少し考えてみるか……」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アンダースコア２つを区切りに利用して  
`studio__grayscale__key_config.tscn` と、 `studio__grayscale__kifuwarabe_rpg.tscn` とか　どうだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　見にくさは改善しないんじゃないの？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`studio_grayscale_presents_key_config.tscn` と、 `studio_grayscale_presents_kifuwarabe_rpg.tscn`  
にしたら　どうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ファイルパスが長くなるの　ゴミ箱に入らなかったりして　データが破損するんだよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`🐔grayscale_🐤key_config.tscn` と、 `🐔grayscale_🐤kifuwarabe_rpg.tscn` でどう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　サークルと作品の関係性は、　にわとりとひよこの関係性とは　異なると思うぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`🏠grayscale_🎬key_config.tscn` と、 `🏠grayscale_🎬kifuwarabe_rpg.tscn` でどう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　サークルと作品の関係性は、ハウスとカチンコの関係性とは　異なると思うぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　シーンの意味はあってるのに。じゃあ　ディレクター・チェアの絵文字は無いのかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　絵文字の品揃えが偏ってて　あんまりないのよ。  
`🪑grayscale_🎬key_config.tscn` と、 `🪑grayscale_🎬kifuwarabe_rpg.tscn` でどう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ひとまず　それで試してみるかだぜ」  

![202311__godot__03-1720--RenameLikeKids.png](https://crieit.now.sh/upload_images/e2407d5261d319769482d2d58599d2216544ad6aa7d0d.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　キッズ感出てくるが　椅子がポリティカル・コネクトネスに引っかかるとは思えないし、  
これで進めよう」  

## 鎖みたいなボタンでインポート

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　インポートでは無くて　リンクという概念らしいが」  

![202311__godot__03-1737--Linked-o2o0.png](https://crieit.now.sh/upload_images/4725ad512e93f150d04bf7465bdbdf536544b1ed5db52.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ルート・ノードだけ　見えるのかな？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そういう趣旨だろ。  
サブツリーが見えると　散らばって　管理できなくなるしな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ　もっとよく考えて　ルート・ノード　作り直そ」  

## パスが合わなくなる

```gd
# ディレクター取得
func get_director():
	return $"../../Staff"
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　リンクしたシーンのパス、合わなくなるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父ん、リネームもするしな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ぶら下げたサブツリーから、外側のサブツリーへパスを合わせる方法も分からん」  

![202311__godot__03-2230--Subtree-o2o0.png](https://crieit.now.sh/upload_images/92e8da4acfac9ac3aba19d479851f5866544f63097b9d.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Staff` が名前被りするんで、嫌なんで `DirectorForKeyConfig` にリネームしたら……」  

![202311__godot__03-2233--ChangePath-o2o0.png](https://crieit.now.sh/upload_images/7c0f018880a8118949f1b21e4f8d86236544f6cc9d051.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ハードコーディングしてるパスも　書き直せよ、ということらしい」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　つら」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　情報技術を扱う　わたしたちが　なんでそんな手間　受け入れなくちゃいけないのかしらね？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　フレームワークを使うからだぜ」  

## とりあえず　シーンをぶらさげる（リンクする）ことができた

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　とりあえず　最低限のキーコンフィグを付けたぜ」  

📺　[動画](https://x.com/muzudho1/status/1720432581928505410?s=20)  

# 📅 2023-11-07 tue レバー対応

![202311__godot__07-0415--Lever.png](https://crieit.now.sh/upload_images/f78170be16e3fa43d1f0c2f4ea32f64665493b7bd77d0.png)

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　↑　レバー対応もした」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

.