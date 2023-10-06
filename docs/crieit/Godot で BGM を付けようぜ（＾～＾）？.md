# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父ん、ＢＧＭを付けてくれだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`きふわらべファイター２.wav` ファイルだけ　持ってるけど」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`.wav` は　ファイル・サイズがでかいから、 `.ogg` にしましょう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　無料の変換ツール　落ちてるかな？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ネットで探すと　山ほどあるが」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　どれも　胡散臭いな……　窓の杜で探してくれだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　読み方は分からないが　これなんかどうだぜ？」  

📖 [fre:ac](https://forest.watch.impress.co.jp/library/software/bonkenc/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　説明読んでも分からん　使ってみれば　分かるか……」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`Microsoft Apps` を開いても　灰色のウィンドウが出てきただけだった。  
インストールできない　終わり」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　直せよ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　じゃあ　これは　どうだぜ？」  

📖　[FlicFlac Audio Converter](https://forest.watch.impress.co.jp/library/software/flicaudiocon/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　めっちゃ　分かりやすく　使いやすく　`.wav` ファイルを `.ogg` ファイルに変換でけた」  

# Godot で、どうやって .ogg ファイルを鳴らすの？

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot で、どうやって .ogg ファイルを鳴らすの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　さっぱり分からん」  

![202310__godot__06-2250--Musician.png](https://crieit.now.sh/upload_images/0e19d3cd505912c2e9bf46df20fff71c652010b268a94.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　とりあえず　`Director`　の下に　`Musician`　を置こうぜ？  
音楽のことは　全部　こいつに丸投げしよう！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　音楽ファイルは　どこに置いてあるんだぜ？」  

![202310__godot__06-2254--Audio.png](https://crieit.now.sh/upload_images/f3996f9a4849812eaf9fb40dba8a3872652011bc3e65e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`res://audio/bgm` の下に置いておいたぜ。後は任せたぜミュージシャン」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　いつ鳴らすの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シナリオ・ファイルで　指定したらいいんだろうけど……」  

![202310__godot__06-2258--Scenario.png](https://crieit.now.sh/upload_images/13c8db1716d8a958b900245ff9688cb3652012c4e79c1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　例えば　`!bgm きふわらべファイター２.ogg` と書いておけば  
BGM が鳴ることにしたらどうだぜ？」  

.
