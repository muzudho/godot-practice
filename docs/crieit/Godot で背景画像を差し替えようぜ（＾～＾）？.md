# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__07-1551--FileAndRank.png](https://crieit.now.sh/upload_images/794d2d0ee1e932e14887d6f963ff9dd66521061c63915.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　次は　背景画像を差し替えるか」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このゲームのタイトルも決まってないよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　タイトル画面　要るから　先に作ってしまえばどう？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　絵を描くのに　２、３時間かかるが　仕方ないな……」  

![202310__godot__07-1627-Title-o2o8o0.png](https://crieit.now.sh/upload_images/5954d96df30d660e39fdc2b88942e44f65211cacaaa2d.png)  

📖　[元ネタ](https://twitter.com/muzudho1/status/1654309777986711552)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　川崎駅前だぜ」  

# スタート・メニュー

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　せっかく　選択肢があるし、　ゲーム・スタートを選べるようにしたら？」  

![202310__godot__07-1804-StartMenu.png](https://crieit.now.sh/upload_images/63b90267ed0e48c936af1198768f542265211f36c923b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　スタート・メニュー便利だな。  
しかし　ゲームを終了する機能なんか　作ってないぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　作れだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　なんか説明が　もやっとしてるな」  

📖　[終了リクエストの処理](https://docs.godotengine.org/ja/4.x/tutorials/inputs/handling_quit_requests.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　Node クラスなら、 `self.get_tree().quit()` で充分なんじゃないか？」  

📖　[How do I make hitting the ESC key exit the game? (GDScript Godot 3.1)](https://www.reddit.com/r/godot/comments/cjigi4/how_do_i_make_hitting_the_esc_key_exit_the_game/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　終了機能は　付けた」  

# タイトルを画面に表示しろだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　タイトルを画面に表示しろだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　タイトルロゴとか　作ったら　キマりがいいと思うんだが  
とりあえず　文字でも置いとけばいいか」  

![202310__godot__07-1919-TitleScene.png](https://crieit.now.sh/upload_images/7a2f745e64031bb1e88a0c352c00f1a4652130c887a7a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　文字を置いたぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　中身は　RPGじゃないんだけどな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　この文字表示を　命令１つで　表示したり、消したりしたいのよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　まだ　やることが　いっぱいあるな」  

.