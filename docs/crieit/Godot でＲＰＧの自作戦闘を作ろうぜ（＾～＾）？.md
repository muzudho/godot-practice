# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__16-0007--戦闘シーン.png](https://crieit.now.sh/upload_images/df469dd17508e41db113151cb6cb95f9652d088e59449.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　何もできてないが」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　とりあえず　会話シーンと　戦闘シーンのスクリプトを分けるところから始めたらいいんじゃない？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　自作ＲＰＧの戦闘を作る教科書か何かは無いのかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　まあ　だらだら　始めて　困ってから考えようぜ？」  

![202310__godot__16-1901--戦闘スクリプト-o2o0.png](https://crieit.now.sh/upload_images/b38042c51be510f660e9ee8f22704077652d0a30e3464.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　画面下のメッセージ・ウィンドウの制御をやっと　できたというところで  
戦闘シーン作るのは　ハードルが高いな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　その　`ビジュアルノベル部門`　と書いてある本のところに  
`バトル部門`　という本が増えたらいいんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　まあ　今のままでは何も進まんし  
ソースコードの掃除ぐらいするか」  

## どこからでも飛ぶ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ランダム・エンカウントの戦闘シーンって　いつでも　突然　戦闘シーンへ飛ぶよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　同義反復よね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　現在の状態を知っていて、それをオフにしたり、  
オフにしたときの状態を覚えていて　あとでその状態に戻りたいこととかあるよな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　スタックを使えだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　現在の状態が　プログラムを書いた時点では　分からないこともある」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　専用のコマンドを用意したらいいんじゃない？」  

.