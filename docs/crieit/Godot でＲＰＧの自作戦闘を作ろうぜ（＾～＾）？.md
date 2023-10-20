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

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`push_and_hide` と、 `pop_and_show` かな？」  

```gd
# どの部門で、そのキーを押されたら、どの部門へ移動するか？
var key_pressed_mappings = {
	"📗ビジュアルノベル部門" : {
		KEY_ESCAPE : "📗システムメニュー部門",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE : "📗ビジュアルノベル部門",
	},
}
```

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　キーを押したときに　どこへ飛ぶかは指定できるが、  
命令を書けないのは不便だよな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そこを命令ブロックに改造するか……」  

```gd
# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
var key_pressed_stage_directions = {
	"📗ビジュアルノベル部門" : {
		KEY_ESCAPE :
			"""\
			!
			department:		📗システムメニュー部門
			""",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE :
			"""\
			!
			department:		📗ビジュアルノベル部門
			""",
	},
}
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ここまでは　でけたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　その　ト書き　に、どのメッセージ・ウィンドウを閉じて、  
どのメッセージ・ウィンドウを開くか　書けばいいのよ」  

```gd
# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
var key_pressed_stage_directions = {
	"📗ビジュアルノベル部門" : {
		KEY_ESCAPE :
			"""\
			!
			m-wnd:			■下, hide
			department:		📗システムメニュー部門
			m-wnd:			■中央
			""",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE :
			"""\
			!
			m-wnd:			■中央, hide
			department:		📗ビジュアルノベル部門
			m-wnd:			■下
			""",
	},
}
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こう書けるようにしたけど、 `■下` メッセージ・ウィンドウは出てないかもしれないし、  
勝手に隠したり、勝手に出したりしたら　出てなかったメッセージ・ウィンドウが出ることになるかも」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　そこを `%current_it_then_push_to_stack%` とか、 `%pop_from_stack_then_current_it%` とか、書けないかだぜ？」  

```gd
# どの部門で、そのキーを押されたら、ト書きを１つ実行できる
var key_pressed_stage_directions = {
	"📗ビジュアルノベル部門" : {
		KEY_ESCAPE :
			# `%hide_current_it_then_push_it_to_stack%` - 現在のウィンドウを隠し、そして、それをスタックへプッシュする
			"""\
			!
			m-wnd:			%hide_current_it_then_push_it_to_stack%
			department:		📗システムメニュー部門
			m-wnd:			■中央
			""",
	},
	"📗システムメニュー部門" : {
		KEY_ESCAPE :
			# `%pop_it_from_stack_then_show_current_it%` - スタックからウィンドウをポップし、そして、それを見せる
			"""\
			!
			m-wnd:			■中央, hide
			department:		📗ビジュアルノベル部門
			m-wnd:			%pop_it_from_stack_then_show_current_it%
			""",
	},
}
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こう書けるようにしたぜ」  

# 戦闘シーンを分けたい

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　今回の改造の応用で、ビジュアルノベル部門と、バトル部門を分けなさいよ」  

```gd
        # ...
        [
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗バトル部門
		goto:		§初戦闘シーン
		m-wnd:		■下
		""",
	],
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで　バトルシーンへ飛んで」  

```gd
        # ...
        [
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		§崎川市最強振興会館
		m-wnd:		■下
		""",
	],
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで　バトルシーンから戻ってこれるようにしたぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　関数みたいだな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　これで　下地は整ったわね」  

## 引数が要るのでは？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　これが関数とするのなら、引数を渡せないと　実用的じゃないな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`%argument1%` とか書ければいいんじゃないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　命令の至る所を `%argument1%` という書き方に対応させなくちゃいけないし、  
パーサーから見て　どういう書き方がいいのか　調べないといけないぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`%arg_1%` とかでいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そこは　数字にする必要があるかだぜ？　名前じゃダメかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　名前の方が　ゲームスクリプト　らしいかしらねえ？」  

```gd
        # ...
        [
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗バトル部門
		arg:		%clear%
		arg:		monster, ヘム将棋
		arg:		return, §２回目戦闘シーン
		goto:		§初戦闘シーン
		m-wnd:		■下
		""",
	],
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで実引数を渡して」  

```gd
	#	初戦闘シーン
	"§初戦闘シーン":[
		# コダック
		"""\
		!
		telop:		崎川駅周辺地図, hide
		bg:			崎川駅周辺地図, hide
		bg:			戦闘シーン
		bg:			川掘町線ロード
		bgm:		🎵バトル１, 8.6
		#monster:	きふわらべ
		monster:	%arg_monster%
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		お父ん
		「おっと　戦闘シーンはまだ
		　できてないらしいぜ
		""",
		"""\
		!
		monster:	%arg_monster%, hide
		""",
		# 部門変更
		"""\
		!
		m-wnd:		■下, hide
		department:	📗ビジュアルノベル部門
		goto:		%arg_return%
		m-wnd:		■下
		""",
	],
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで仮引数を受け取れるようにしたぜ。  
今日はここまでだな」  

# 📅 2023-10-17 tue ⏰ 18:52

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ツツジが咲いている背景画像が欲しいんだが」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父んなら　２時間で描けるだろ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　モデルがあるから　フリー素材で補えないのが　不利よねえ」  

## 話しは飛ぶが戦闘画面の仕様は固めた

![202310__godot__18-0019--BattleScene.png](https://crieit.now.sh/upload_images/247212bf40d94a26326a909307a589e9652ea6529e85f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　話しは飛ぶが戦闘画面の仕様は固めたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　こういうの先に出すと　アイデアマン気取りの変人が  
わたしはこういう風にした方がいいとか　言ってきて　後から　真似されたとか  
言い出すんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そういう輩は　自分を大きく見せれるように　ファンがいっぱいいるとこに　噛みつきにいくんだぜ。  
わたしに嚙みついても　自分を大きく見せられないぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　わらう」  

## 仮組した

📺　[動画](https://x.com/muzudho1/status/1714326815815450982?s=20)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　仮組した。今日は終わり」  

# 📅 2023-10-19 thu もうちょい何とかならんの？

![202310__godot__19-1943--BattleScene.png](https://crieit.now.sh/upload_images/a18022121d30d8ed5574486c8cd8aa626531089475bc9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　キャラクター画像をもう少し小さくして　データ表示の面積を増やすかな？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　戦闘中の数字表示は　テロップ　でやるという建付けなの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　会話シーンと同じだぜ。一貫性があるだろ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　城の堅さなどの　４つの数字が　目立たなくないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ウィンドウの枠も付けるかどうか　考えどこだぜ」  

![202310__godot__19-2143--BattleScene.png](https://crieit.now.sh/upload_images/c4e9961e252fc5af9fb5019c4881702e653124d5332d8.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シンメトリーに気を使って　バランスを安定させて、  
**主な瑕** は　画面から省くことにしたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　すっきりさせたわねえ。  
ごちゃごちゃ　している画面を　長時間観るのは　つらいですからねえ」  

## トランジションが欲しくない？

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　トランジションが欲しくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シェーダーを書くのは嫌だ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　スリープ機能があれば、シナリオ・スクリプトで疑似的に実装できるのでは？」  

📖　[[Godot] 一時スリープ（ウェイト）を実装する！1行で書けます](https://worktoolsmith.com/godot-sleep-wait/)  

```gd
yield(get_tree().create_timer(1.0), "timeout")
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　分けわからん命令だが　真似てみるか」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot 4.x では使えね」  

📖　[In gdscript, is there codes looks like "python's time.sleep()"](https://ask.godotengine.org/154730/in-gdscript-is-there-codes-looks-like-pythons-time-sleep)  

```gd
# wait 2 seconds
await get_tree().create_timer(2).timeout 
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　スリープしないぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`async` が無いのに `await` が効くの？」  

## スリープは自力実装した

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　サンプル動かないので、スリープは自力実装した」  

📺　[動画](https://x.com/muzudho1/status/1715041232815317005?s=20)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　トランジションも実装したぜ」  

# 📅 2023-10-20 fri ⏰ 19:15

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　戦闘画面じゃなくて、戦闘を作りましょう」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　**玉の遠さ** を　１０　にして、　１ターン毎に　３　減って　４ターンで戦闘終了するのを  
試しに作ってみればいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　**玉の遠さ** が　１以上か、１未満か　分ける処理が必要だなあ。  
ト書き　で　どう書こう？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　**GDScript** 自体がゲームスクリプトなのだから、  
シナリオの途中で GDScript で書けないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot に **匿名関数** が有るかないか　調べてみるか」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　あるのでは？」  

📖　[GDScript Anonymous Functions](https://gamedevacademy.org/gdscript-functions-tutorial-complete-guide/#GDScript_Anonymous_Functions)  

![202310__godot__20-2005--AnonymousFunction-o2o0.png](https://crieit.now.sh/upload_images/a9dd9b19a09d4d1e299da7d1f8e983d665325f7e78415.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こういう風に　シナリオ・スクリプト　に書くことができたぜ」  

![202310__godot__20-2009--AnonymousFunctionCall-o2o0.png](https://crieit.now.sh/upload_images/dccb204a3b1bb1b3da5c66cf9ea5b21865326005f3f1c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　シナリオ・リーダーの方には　こう書けばいいんだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　これを　どう　シナリオ・スクリプト　に組み込んだら　良さそうだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　引数で渡すものって　無くない？　全部　グローバル変数でいいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そういう　やり方もある」  

![202310__godot__20-2030--AnonymousFunction_o2o0.png](https://crieit.now.sh/upload_images/fefebb0366d47cc364cca935ab20e62d6532651fb3621.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こういう感じで　変数をセットできるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　変数の書式は　コマンド・プロンプトの環境変数みたいな　`%xxxx%`　で行くのか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　他にいい案があれば変えてもいいぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　開きと　閉じが　分かんないのよね。  
`${xxx}` か、 `{xxx}` が　いいんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　その見た目だと　式が書けるように見えてしまう。  
あくまで　変数なんだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`$'xxx'` で　どうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　視覚的に見にくいぜ。それだったら `<xxx>` とかの方が良くないかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　HTMLタグを将来的に実装する予定がないなら　いいんじゃない？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`%xxxx%` でいいかもしれないな」  

## 匿名関数の中で Goto命令を使えないの？

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　匿名関数の中で Goto命令を使えないの？」  

![202310__godot__20-2108--AnonymousFunction-o2o0.png](https://crieit.now.sh/upload_images/0196dfbdfdf66760c4236c59a12a97bf65326e0d65ad2.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　こんな感じで使えるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　もう　ほとんどの機能は　実装できてるんじゃないか？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シナリオ・スクリプトじゃなくて　GDScript 剥き出しだけど、いいんじゃないの？」  

## 戦闘データはどこに書く？

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`玉の遠さ` みたいな　戦闘シーンだけで使うデータって　どこに書けばいいの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　どこでもいいんじゃないか？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`BattleArtist` でどうだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そんな肩書きのやつ　いるかな？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　スコアラー（Scorer）で　いいんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しっくりくるぜ。　それで」  

![202310__godot__20-2359--Scorer-o2o0.png](https://crieit.now.sh/upload_images/5fbef252917411d2e8fad20bdbe6d2c2653295ef35b1b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　スコアラーが　戦闘用紙を持っているという建付けにしようぜ」  

![202310__godot__21-0007--BattleSheet.png](https://crieit.now.sh/upload_images/1471df849730a687d13b65b57d8e8b69653297b83306f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　データは　これでいいかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　これは　キャラ・データじゃなくて、戦闘シーンのデータだというのを　はっきりさせた方が  
あとで間違わなくて済むんじゃない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　デパートメントという言葉が　なんか合ってないな。　シーンに名称変更していいかな？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　シーンは　Godot　と用語が被るんで」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot ほんと国語がクソだな」  

![202310__godot__21-0021--MonsterData.png](https://crieit.now.sh/upload_images/a5a489331cedf5f7a7220dda90a7ba3865329af4a42a7.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　モンスターデータは　こんな感じで　書いておこうぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しかし　Ｉｄって　ソースにハードコーディングするもんじゃないな、分かりづらいな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ルックアップ関数と併用してはどうか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　それでいこう」  

## 台詞の中の変数

![202310__godot__21-0220--Name--o2o0.png](https://crieit.now.sh/upload_images/f5abcf4165ce9171b71152726ead33046532b7139ed48.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　台詞の中で　変数を使いたいことってあるよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot で正規表現は使えるのかしら？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　有るようだぜ」  

📖　[RegEx](https://docs.godotengine.org/en/stable/classes/class_regex.html)  

```gd
		"""\
		{{arg_sente_name}}
		「銀が上がる
		""",
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ハンドルバーズなんかを真似て　こういう書き方の方がいいのかなあ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`%xxxx%` を廃止して `{{xxxx}}` に統一してくれだぜ」  

.