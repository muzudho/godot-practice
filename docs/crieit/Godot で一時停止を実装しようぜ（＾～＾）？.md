# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　例えば　エスケープ・キーを押したら　ゲームがピタッと　一時停止するような、制御を練習しようぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ポーズ機能ぐらい　標準で実装されてないのか？　先に調べてみろだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　調べていて　でてきたんだが　**BGM**　って和製英語で　海外人に通じないみたいだな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　和製英語で検索するのは　止めなさい」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そんなん言ったって　和製英語を通じて　世の中を見てるし　できあがった土台を疑うのは大変だぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　ポーズ機能は　フレームワークで用意されているようだぜ」  

📖　[GODOT DOCS / Pausing games and process mode](https://docs.godotengine.org/en/stable/tutorials/scripting/pausing_games.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　説明読んでも分からんし、使って覚えるかあ」  

# ルートを停止すると、ルートも止まる

```gd
func _unhandled_key_input(event):

	#	何かキーを押したとき
	if event.is_pressed():
		
		#	エスケープ・キー
		if event.keycode == KEY_ESCAPE:
			
			if not get_tree().paused:
				# 全体を止める
				get_tree().paused = true
			else:
				# 全体を止めているのを解除
				get_tree().paused = false
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ルートで　木を停止すると、ルートも止まるので　上記のコードでは　一時停止を解除できない」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　矛盾が無いぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　素直な挙動だから、これで　狙って指定したノードだけ　一時停止できそうね」  

# どのノードを止めたらゲームが止まるの？

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　どのノードを止めたらゲームが止まるの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アミバみたいだな」  

![202310__godot__09-1437--Tree.png](https://crieit.now.sh/upload_images/f69d80dd4338d8bcd3aa2b45f6f28ed5652391b469b49.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　どのノードを止めるといった　分け方をしてないしな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　なんか　よく分からんなあ。　お父ん、いったん　思うように　再構成してみてくれだぜ」  

# ツリーを再構成しようぜ？

![202310__godot__09-1445--ScenarioWritere-o2o0.png](https://crieit.now.sh/upload_images/d75cd1af5624d7b6865ec8a79013b25d652393a824217.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ゲーム制作の　チーム作業を　模擬して、  
第２階層のフォルダーには　誰がそのフォルダーを開ければいいのかが分かるように  
役職名を書いていこう」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ある種の　ダイナミック・プログラミング（Dynamic Programming；動的計画法）を行うのね」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　手の付けやすいところを先に固めていけば　難しい所が最後に残るわけか」  

![202310__godot__09-1457--BackgroundArtist-o2o0.png](https://crieit.now.sh/upload_images/7930379f270d18905002c4d4027199396523969ccf35f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Background` も、 `BackgroundArtist` にリネームしよう」  

![202310__godot__09-1510--LocationCoordinator-o2o0.png](https://crieit.now.sh/upload_images/aa5c6b48ab44a197ec691249dc2bf2fa652399a4520b1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Scenes` も、 `LocationCoordinator` にリネームしよう」  

![202310__godot__09-1517--Windows-o2o0.png](https://crieit.now.sh/upload_images/7eb4b8b43579cc744e9e348b2947b76065239b4790e41.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ウィンドウって　誰の仕事なんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　誰なんだろな？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　マシ―ナリー（machinery；機械装置）なんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ウィンドウは、わたしの思っている機械と違う」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　`スクウェアエニックス　中途採用　ゲーム開発` で検索。  
どんな職種があるか　調べたろ」  

📖　[募集中の職種](https://www.jp.square-enix.com/recruit/career/career/de/game/index.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`UI デザイナー` と、 `UI アーティスト` は何が違うんだぜ？　表記ゆれ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　デザイナーと　アーティストの違いが　さっぱり分からん。  
実態は　どう違うんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アーティストは　自分勝手なやつで、  
デザイナーは　顧客が思っていた本当に欲しかったものとは違うものを作ってくる勝手なやつじゃないのか？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　だから　違いが分からん」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　調べましょう」  

📖　[デザイナーとアーティストの違いって？ 実は存在目的が明確に違うんです！](https://niigatainsatsu.co.jp/topics/20221109/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アーティストは　その人本人に価値があって　それを会社側が　ゲヘヘ　と下心をこめて利用するもので、  
デザイナーは　下請けか」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父んの頭では　それぐらいの理解が　精一杯だな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　あんたは　どの役職なら入れそうなの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ゲーム制作は専門技術なんで、それ用の技術を持ってないので　どこも無理だぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　なんで　そんなやつが　きふわらべＲＰＧ　作ろうとするんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`Designer` と `Artist` だと、 `Artist` の方が　つづりが短いから　こっちを採用しよう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あと `UI` は意味が広すぎる。 `GUI` にしよう」  

![202310__godot__09-1551--GuiArtist-o2o0.png](https://crieit.now.sh/upload_images/5365e464f713af4c6da23311c76ccd956523a33435d19.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　他の職業は　制作の裏方さんという感じなのに、  
`GuiArtist` は　本番中に　めっちゃ　働くんだけど」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　実態は　ウィンドウだからな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　裏方と　オン・エアで　大分類を切った方がベターなのかしらねえ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そこは　あとで考えよう」  

![202310__godot__09-1556--SecondFolders.png](https://crieit.now.sh/upload_images/f4a1bde6ddef7a8f930c28d4701d2a6c6523a44b90b06.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　第２階層は　こんな感じでどうだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　オンエアが始まる前に仕事が終わってる人たちと、  
オンエアに仕事をしてる人たちで　別れるんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　上演中にシナリオを書き換えるシェークスピアみたいなやつとか　分類できないだろ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ツリー構造には向いてないなあ」  

# 自律するかどうか

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　現状の実装では　ユーザーがキー入力すると  
メッセージ・ウィンドウへ送られ、  
台本の次の行が読み込まれ、それに従って　さらに動く、  
オートマタが　完成しているのが、　一時停止を都合悪くする原因だろう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　**自律** するかどうかより　**連続** かどうかが問題だぜ。  
連続に　切れ目なんか無いぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　停止した瞬間は　どんな状態にあるの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　数学的には　無限の狭間を永遠に彷徨っていて定まらないと思うが、  
情報処理的には　プログラム・カウンターが止まっているところだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　都合のわるい所、変なところであったとしても、  
止まっているノードに対して　編集を行わず、かつ、行う処理が　再開　だけなのであれば  
問題は起こらないと思うぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それを保証する仕組みが　あるかどうか分からん」  

.