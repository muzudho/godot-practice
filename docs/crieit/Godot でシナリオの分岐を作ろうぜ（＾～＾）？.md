# 前の記事

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__04-1944--Choices.png](https://crieit.now.sh/upload_images/14d2a4d10dbad954dfebbf2f16e26631651d42ea735ca.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　選択肢までは　出るのだった」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　その選択肢を選んだあと　次の会話に　つながってほしいのよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　多分、それは　メッセージ・ウィンドウの仕事ではなくて、  
メッセージ・ウィンドウへ　メッセージを手配してくる　交換手か何かの仕事だな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ストーリーテラー（storyteller；語り部）のようなクラスでも　作るかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シナリオプレイヤー（Scenario Player；シナリオ再生機）ぐらいの造語でいいかな」  

# シナリオプレイヤーを作ろう

![202310__godot__04-2028--ScenarioPlayer.png](https://crieit.now.sh/upload_images/468f81a7def2c17846502c25846f0569651d4c784c529.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　空っぽの `Node` をベースに　シナリオプレイヤーを作ってしまおう。  
細かいことは　これから詰めていこう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　なんでもかんでも　オートマトン（Automaton；自動人形）と同じように作ればいいんだろ。  
ステートマシーンを持たせろだぜ」  

📄 `ScenarioPlayerStatemachine.gd`:  

```gd
# シナリオ・プレイヤー・ステートマシーン（Scenario Player Statemachine；台本再生機状態遷移図）
extends Node

class_name ScenarioPlayerStatemachine

# 　状態遷移図
# 　ーーーーー
#
# 　　　　　　　　　＋ーーーーー＋
# 　　　　　　　　　｜　はじめ　｜
# 　　　　　　　　　＋ーー＋ーー＋
# 　　　　　　　　　　　　｜
# 　　　　　　　　　　　　｜
# ＋ーーーーーーーーーー＞＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　Ｖ
# ｜　　　　　　　＋ーーーーーーー＋
# ｜　　　　　　　｜　０．停止中　｜
# ｜　　　　　　　＋ーーー＋ーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　再生　＃ステートマシーン外部からの開始の合図。段落番号を渡される
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーー＋
# ｜　　　｜　　　｜　１．再生中　｜
# ｜　　　｜　　　＋ーーー＋ーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　再生　＃別の段落番号が書かれていた
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　停止　＃段落が終わった
#
enum States {None, Playing}

# 状態
var state = States.None

# 停止中か？
func is_none():	
	return self.state == States.None

# 再生中か？
func is_playing():
	return self.state == States.Playing

# 再生
func play(paragraph_no):
	print("［ステートマシーン］　パラグラフの再生")
	self.state = States.Playing

# 停止
func stop(paragraph_no):
	print("［ステートマシーン］　停止")
	self.state = States.None
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんなもんかだぜ？」  

# シナリオプレイヤーにステートマシーンを実装しろだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そのステートマシーンを　シナリオプレイヤーに実装しろだぜ」  

📄 `ScenarioPlayer.gd`:  

```gd
# シナリオプレイヤー（Scenario Player；台本再生機）
extends Node

# 状態遷移機械
var statemachine = load("scripts/ScenarioPlayerStatemachine.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.statemachine.is_none():
		# 停止中
		# 	何もしない
		pass
		
	elif self.statemachine.is_playing():
		# 再生中
		#	何もしない
		pass
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ひとまず　こんなもんかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シナリオプレイヤーは　自律的に動くといっても、  
起動の合図は　外部から与えるのよね？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そうだぜ。 **監督** が指示してなければ　まだ動くなだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　本当に自律的に動く　監督　が必要なんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　監督も作るか～」  

![202310__godot__04-2232--DirectorNode.png](https://crieit.now.sh/upload_images/d4b4b27152485f228316425dfd6597e4651d6c20b2aad.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ルート・ノードの名前を `Director` にしたった」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　合理的ねえ」  

📄 `Director.gd`:  

```gd
# ディレクター（Director；監督）
#	とりあえず、ゲーム全体をコントロールする
extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# シナリオ・ブックから、内容を取出す
	print("［２Ｄプロジェクト］　シナリオ・ブックから、内容を取出す")
	var scenario_array = $"./ScenarioBook".scenario_array
	
	# シナリオプレイヤーへ、内容を渡す
	print("［２Ｄプロジェクト］　シナリオプレイヤーへ、内容を渡す")
	$"./ScenarioPlayer".set_scenario_array(scenario_array)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　監督のスクリプトの雰囲気は　こんな感じになるはずだぜ」  

# シナリオに段落番号を振りましょう！

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シナリオブックの　各部分に　パラグラフ（Paragraph；段落）番号を振れない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　リストではなく　マップが必要だな。 Godot にマップはあるのかだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　`Dictionary` という名前で有るぜ」  

📖　[Godot Engine / Dictionary](https://docs.godotengine.org/en/stable/classes/class_dictionary.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　調べてみるか……」  

📄 `ScenarioBook.gd`:  

```gd
# 段落番号を指定して、段落を取得
func get_paragraph(paragraph_code):
	return self.document[paragraph_code]
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　段落番号を指定して、段落を取得できるメソッドを作っておくぜ。  
あとで `1.2.3` みたいな段落番号を使いたいので、番号は文字列にしておくぜ」  

![202310__godot__04-2304--ScenarioDocument.png](https://crieit.now.sh/upload_images/2a308112fd8adf71a8749aabd2c03883651d70ed15a63.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　インデント２つが　もったいない気がするが、  
普通の書き方を優先し、上図のように　セリフを並べることにするぜ」  

![202310__godot__04-2316--Paragraph_1.png](https://crieit.now.sh/upload_images/184a8c239d1134b1edee9fdc0ed0301e651d73f0d8a1b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな風に　パラグラフを追加していくものとしようぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　選択肢の１番目が　段落の `1.1` に飛ぶのを　どうコントロールすんの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そのコントロールをするのが　`ScenarioPlayer`　だぜ」  

![202310__godot__05-0011--Mappings.png](https://crieit.now.sh/upload_images/f767fb7a696b1953eb51d1d50cc9c1b5651d809e34946.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じでマッピングするんだが、なんかよく分からないな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　どうやっても　分かんないんだから　２重の `Dictionary` にしたらどうなの？」  

![202310__godot__05-0017--MappingsDocument.png](https://crieit.now.sh/upload_images/397b9a130b3079110195889a25ac6895651d822450b52.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これで分岐の最低要件は満たせるが、確かに　見ても　よく分からんよな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　この設定ファイルを編集する外部エディターぐらい　お父ん　作れるだろ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それもそうだぜ」  

.