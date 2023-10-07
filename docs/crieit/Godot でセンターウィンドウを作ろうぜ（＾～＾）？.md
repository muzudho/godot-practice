# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__godot__05-2140--Today3.png](https://crieit.now.sh/upload_images/8f0912299dc3c87e073aeec356dd71ad651eb0c2030dd.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　中央辺りに　ウィンドウを置けばいいのかだぜ？  
窓枠も付けるなら　少し上に　ずらすか……」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　下のメッセージ・ウィンドウと同じ見た目で充分だぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　角丸の　内側のカーブは　直角にするの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あんまり　凝らずに　使い回そうかな……」  

![202310__godot__05-2145--CenterWindow-o2o0.png](https://crieit.now.sh/upload_images/afb154aee6d27febd26d2fcc9d8028b6651eb309ea084.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これで充分だろ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Godot に載せてみようぜ？」  

![202310__godot__05-2211--CenterWindow-o2o0.png](https://crieit.now.sh/upload_images/a7d12e3f4ed13de151ccc2835dcd11d2651eb6559bfa3.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じに置いて……、これでは空枠だが……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　サラダの国のトマト姫感あるわねえ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　あの傑作の」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　なんか画像を　当てはめてくれだぜ」  

![202310__godot__05-2217--CenterWindowImage-o2o1o0.png](https://crieit.now.sh/upload_images/8ef5828388698dec4c8e8132f45b12da651ebee07da6b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　即席で　将棋盤だけ描いて……」  

![202310__godot__05-2248--CenterWindow.png](https://crieit.now.sh/upload_images/0ca7caffe6dafec4696490865a61caa1651ebefe91833.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　枠の後ろに置くだけ……、  
うわっ、　センター・ウィンドウを非表示にするとか、  
画像を差し替えるとか　要望が　いっぱい来そう」  

![202310__godot__05-2252--Run.png](https://crieit.now.sh/upload_images/e6eecc82da7aa564ed136ae1e914acb0651ebfba5feeb.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　`!center_window 将棋盤` 的なゲームスクリプトで  
制御できるようにしたら　どうなの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　やらなければならないことが　大量にある　萎えた」  

## 表示、非表示を切り替えられるようにしようぜ？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　他の記事で　他のことが　だいぶ進んだ。　センター・ウィンドウの命令の構文考えるか」  

![202310__godot__07-1355--Cwnd-o2o0.png](https://crieit.now.sh/upload_images/a7572368691d986569285f93746ff6276520e52fb5ef9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで　ファイル名を指定するようにしたら　どうだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ノード名を指定した方がよくない？」  

```gd
		"""\
		!
		cwnd: 将棋盤
		""",
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　こうか」  

## デフォルトのフォントは簡体字

![202310__godot__07-1402--ChinaFont-o2o0.png](https://crieit.now.sh/upload_images/1a552e4709b02804462eb2f90eda8cb66520e6966c410.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ああっ　簡体字だ！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　アジア人は　ほとんどが中国人だからな。中国語に合わせておけば　大多数の人が幸せになるだろう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　却下。　日本語に矯正する」  

![202310__godot__07-1415--Fonts-o2o0.png](https://crieit.now.sh/upload_images/8503ff571ee6d9b916b70654a7baf57d6520e9c919bd1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォントは　ちゃんと設定する必要が　あったか～」  

![202310__godot__07-1418--JapaneseFont-o2o0.png](https://crieit.now.sh/upload_images/3becadc8a25d1aa0791bd3de6142e3cb6520ea6c0d9b1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　けっこう　雰囲気が変わってしまったな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　慣れてくるでしょう」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

.