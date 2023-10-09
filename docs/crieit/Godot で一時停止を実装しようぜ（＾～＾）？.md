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

.