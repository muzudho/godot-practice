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

.