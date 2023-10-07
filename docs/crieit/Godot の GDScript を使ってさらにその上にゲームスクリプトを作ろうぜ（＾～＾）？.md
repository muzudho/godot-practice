# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　言葉で説明するのが難しいが……、  
**GDScript** はゲームスクリプトだが、それを使って　さらにゲームスクリプトを作ろうぜ？」  

![202310__godot__08-0050-KifuwarabeRPG.png](https://crieit.now.sh/upload_images/30951114a93a13007191c31ea5cf09bf65217e3dcc9c7.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こういうゲームを作っていて……」  

![202310__godot__08-0051-GDScript.png](https://crieit.now.sh/upload_images/d86efea6b0b12049d2ba42bda504eb5865217e9c67e8c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　GDScript は使ってるわけだが、  
**Godot** というゲームエンジン１号の上で動く **GDScript** というスクリプト１号を使って、  
ビジュアルノベル的なゲームエンジン２号を作って、 シナリオのようなスクリプト２号を作ろうという話しだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　誰も聞いてないんで　好きなようにしたらどうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　もとより　そのつもりだぜ。  
１から１００まで　全て自分で作るつもりだぜ」  

# 複数行命令を作ろうぜ？

```gd
var document = {
	"タイトル画面":[
		"""\
		!
		bgm: タイトル
		""",
		"""\
		!
		scene: タイトル
		""",
		"""\
		!
		bg: 崎川駅前
		""",
		"""\
		!
		choice: 1,2
		　・スタート
		　・終了
		""",		
	],
```

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　あんたの作った　２階のゲームスクリプト　手際が悪いんだけど」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　１行の命令と　複数行の命令を書き分ける　いい方法が思いつかないんだぜ」  

```gd
		"""\
		!
		choice: 1,2
		""",
		"""\
		　・スタート
		　・終了
		""",		
```

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　`choice` 命令は次のメッセージにかかる、ということにしたらどうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　うーむむむ、できなくはないか、やってみるかだぜ」  

.