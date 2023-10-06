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

# スクリプト設計

![202310__godot__06-2258--Scenario.png](https://crieit.now.sh/upload_images/13c8db1716d8a958b900245ff9688cb3652012c4e79c1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　例えば　`!bgm きふわらべファイター２.ogg` と書いておけば  
BGM が鳴ることにしたらどうだぜ？」  

![202310__godot__06-2303--bgm.png](https://crieit.now.sh/upload_images/e72d54cfefb1cdd389df97939bcc07fa652013dfcb72a.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　鳴らないが」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　台本を読んで演技する人って　英語で何て言うんだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　パフォーマー（Performer；演者）じゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　演者が　ＢＧＭを鳴らすわけじゃないしな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　バックバンドのことかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シナリオ　というのが　おかしいのかもしらん。  
素直に　プログラム（Program；進行表）という名前にした方がいいんだろうか？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シナリオの上位概念として　プログラムを置くの？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　コンピューターがいうプログラムと、  
番組制作がいうプログラムは　また別物なんだよな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　分かった、 `Director`　の下に　`AssistantDirector` 　を置こう！」  

![202310__godot__06-2325--AssistantDirector.png](https://crieit.now.sh/upload_images/fd7e7281c823db8ea13fc830f4a5735e6520190f94283.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`ScenarioPlayer` とかいう造語を `AssistantDirector` に変更したぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　アシスタント・ディレクターと　メッセージ・ウィンドウは　どっちが偉いんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アシスタント・ディレクターの方が　偉いと思いたいが……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ユーザーの入力と、シナリオの強制力は　どっちが強いの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ユーザーも　シナリオに従ってほしい」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　メッセージ・ウィンドウが持っている **メッセージ送り** という働きが  
かなりの強権で　アシスタント・ディレクターなんか無視して  
有無を言わさず　メッセージ送り　するわよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　うーん　裁量が　ぐちゃぐちゃ　だ……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　メッセージ・ウィンドウが持つべき権利は  **ウィンドウを消すから、次のメッセージくれ** であって、  
**メッセージ送り** ではないはずなのよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ　メッセージ・ウィンドウが　シナリオを持っているのが悪くて、  
アシスタント・ディレクターが　セリフだけを千切って  
メッセージ・ウィンドウに渡せばいいんだ」  

```gd
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
# ｜　　　　　　　＋ーーーーーーーー＋
# ｜　　　　　　　｜　０．非表示中　｜
# ｜　　　　　　　＋ーーー＋ーーーー＋
# ｜　　　　　　　　　　　｜
# ｜　　　　　　　　　　　｜　シナリオ・データ設定
# ｜　　　　　　　　　　　｜
# ｜　　　＋ーーーーーー＞＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーーーーーーーーーー＋
# ｜　　　｜　　　｜　１．タイプライター風表示中　｜
# ｜　　　｜　　　＋ーーー＋ーーーーーーーーーーー＋
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜　バッファーが空になった
# ｜　　　｜　　　　　　　Ｖ
# ｜　　　｜　　　＋ーーーーーーーーー＋
# ｜　　　｜　　　｜　２．完全表示中　｜
# ｜　　　｜　　　＋ーーー＋ーーーーー＋
# ｜　　　｜　　　　　　　※上位のオブジェクトに指示待ちの通知を送る
# ｜　　　｜　　　　　　　※これにて自律を停止
# ｜　　　｜
# ｜　　　｜
# ｜　　　｜　　　　　　　※外部からの入力
# ｜　　　｜　　　　　　　｜
# ｜　　　｜　　　　　　　｜
# ｜　　　＋ーーーー＜ーー＋　まだ続きがある。ページ・フォワード
# ｜　　　　　　　　はい　｜
# ｜　　　　　　　　　　　｜
# ＋ーーーーーーーーーーー＋　すべての文字を吐き出した。オール・ページ・フラッシュド
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　完全な自律を停止して、外部からの入力を待つ状態遷移に変えなくてはダメだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`.clear_and_awaiting_order()` みたいなメソッドを作るか」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　作った。そして調整して変更した」  

```gd
		"""
		!bgm きふわらべファイター２.ogg
		""",
		"""\
		!choice 1,2
		　・６筋の７段目の駒を６段目に突く
		　・角道を止める
		""",
```

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　これは　セリフか？　命令か？　どう区別する？」  

```gd
		"""
		!
		bgm きふわらべファイター２.ogg
		""",
		"""\
		!
		choice 1,2
		　・６筋の７段目の駒を６段目に突く
		　・角道を止める
		""",
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　命令のメッセージは　`!`　だけの行から始まるように　仕様を変更するか……？」  

![202310__godot__07-0208--BGM-o2o0.png](https://crieit.now.sh/upload_images/38b0d7d67f4b75b23eed21a44a14992e65203f39cd4f2.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　大改造して　BGM　の名前も検出できるようにしたぜ」  

# BGMを鳴らせだぜ

.![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　ＢＧＭを鳴らせだぜ」  
