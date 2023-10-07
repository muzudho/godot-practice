# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__07-2150-CursorNotYetBlink.png](https://crieit.now.sh/upload_images/b9f80e851902c0552f00a7d5a769c672652154316bfd1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　カーソルが　ブリンク（Blink；点滅）してないのは　気になるぜ。  
ブリンクさせよう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　スプライトを使えば　アニメーションで簡単に点滅できるんじゃないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　こいつ、スプライトじゃなくて　`Label`　なんで。  
**機種依存文字**　なんで」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　似非コンソールなんか　作ってるから　苦労すんのよ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`func _process(delta)`　メソッドを使って　`self.visible = not self.visible`　で点滅するんじゃないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`self.visible = false`　したのだったら　ずっと消えててほしいし、  
`self.visible = true`　したのだったら　ずっと表示されていてほしいんだぜ。  
勝手に　visible　をひっくり返さないでほしいんだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　透明度を変えたらいいんじゃないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　だから　こいつは　画像じゃなくて　`Label`　なんだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　`Label` も、 `.modulate.a`　プロパティがアルファ値だそうよ？」  

📖　[Is it possible to change the transparency of label?](https://ask.godotengine.org/45694/is-it-possible-to-change-the-transparency-of-label)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　試してみるか……」  

.