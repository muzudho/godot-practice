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

.