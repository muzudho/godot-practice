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

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そのステートマシーンを　シナリオプレイヤーに実装しろだぜ」  

.