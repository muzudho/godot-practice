# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot でテキストを表示しようぜ？」  

![202309__godot__30-1620--Label-o2o0.png](https://crieit.now.sh/upload_images/cf0abb291bf583d88021459e0d1f792e6517cc80c0db5.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　Label と RichTextLabel は見つかるが」  

![202309__godot__30-1623--LabelSettings-o2o0.png](https://crieit.now.sh/upload_images/b38b42c9f5e773bd178196f16df1a6146517cd3af1321.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォント・サイズを　いくつにするのが適切なのか　現代のディスプレイ事情では　分からんなあ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ゲームの画面サイズを　先に確定した方が　よくない？」  

# 画面サイズ

![202309__godot__30-1629--WindowSize-o2o0.png](https://crieit.now.sh/upload_images/a55091fedf78d07ad31cdee47b7ee36a6517d005e4039.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　画面サイズを　1280 x 720 ピクセルに縛ろうぜ？」  

# グリッド

![202309__godot__30-1642--Text.png](https://crieit.now.sh/upload_images/1d17ee24775cd63ffe7e5bc10b5cc8086517d18b7604b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォントを適当に設定して……、グリッドが無いと　サイズ感をつかめないな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　シェーダーで勝手に作れという　界隈みたいよ」  

📖　[2D Grid](https://godotshaders.com/shader/2d-grids/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　また勉強か」  

📖　[Your first 2D shader](https://docs.godotengine.org/ja/4.x/tutorials/shaders/your_first_shader/your_first_2d_shader.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ダメだ　シェーダー難しい　画像でやる」  

![202309__godot__30-1657--Tileset-o2o0.png](https://crieit.now.sh/upload_images/89f2e6b989ae2b0c7ba631e030520e886517d8169440f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Windows Paint で線を引き、 GIMP で背景色を抜いたぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　技術の無さを　労働で補うの　わらう」  

![202309__godot__30-1716--Grid.png](https://crieit.now.sh/upload_images/890cd8fd2b965a8f1d2d238efcd3ff496517d96223e6d.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　ぴったりなの　わらう」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　これ、工作用紙の罫線のデザインよね」  

📖　[参考画像](https://www.bing.com/images/search?q=工作用紙&form=HDRSC3&first=1)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　近所で入手しやすいアイテムだぜ。８の倍数にアレンジしたぜ」  

# フォントをインストールしようぜ？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot のデフォルトのフォントが　クソ　で嫌いだぜ。  
他の日本人は　誰一人　疑問にも思わず　放置しているのか？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　海外が本場なんじゃないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　他のフォントに変えられないのかだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　調べろだぜ」  

📖　[【Godot】日本語フォントの設定方法 (Godot3.4〜3.5)](https://2dgames.jp/godot-font-resourse/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　フォント作成者のページを見にいったら　フォント・ファイルをソースに同梱して配布するのをやめてくれといった趣旨が　書いてあった」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　当然よね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　この　`M PLUS 1 Code`　フォントなら　わたしの感覚に合うんだが、オープンソースのゲームに同梱していいんだろうか？」  

📖　[M PLUS 1 Code](https://mplusfonts.github.io/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　ダウンロードできるページは　ここだろうか？」  

📖　[Git Hub/MPLUS FONTS](https://github.com/coz-m/MPLUS_FONTS/tree/master/fonts/otf)  

![202309__godot__30-1803--font-o2o0.png](https://crieit.now.sh/upload_images/72bdf3541e97c48a4406157c48ebee256517e4d01bc59.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　再配布可能なライセンスの　フォント・ファイルをダウンロードしてきたぜ」  

![202309__godot__30-1808--NewResource-o2o0.png](https://crieit.now.sh/upload_images/0f4e4b247b39448f3d77cbabc81d426a6517e5bcb0b05.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォント・ファイルを置いても　認識しないようなので、  
リソースを新規作成するぜ」  

![202309__godot__30-1810--FontFile-o2o0.png](https://crieit.now.sh/upload_images/8c09021e7a311b0c954395e2648fc96a6517e6357bfb0.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　説明と画面が違うんで　あとは勘で進むぜ。 `FontFile` でどうか？」  

![202309__godot__30-1813--NewFontFile-o2o0.png](https://crieit.now.sh/upload_images/8794e1e8cd299f36bed98d81d922cf1c6517e6cef1b02.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`new_font_file.tres` というファイルを作った」  

![202309__godot__30-1815--SelectAFile-o2o0.png](https://crieit.now.sh/upload_images/52e16df39534b864823ea747a794bfc76517e770594cf.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　フォント・ファイルと紐づけよ」  

![202309__godot__30-1818--QuickLoad-o2o0.png](https://crieit.now.sh/upload_images/348ad9a32beec66aaf4435bd74e149ce6517e817d3033.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これで　フォントを選べるようになったぜ」  

![202309__godot__30-1821--Mplus1CodeFont.png](https://crieit.now.sh/upload_images/a896b46925cd8b0dd952c4d2a8217efc6517e8c87c5f5.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　よし、まともな　フォントになったぜ」  

![202309__godot__30-1840--Pixel.png](https://crieit.now.sh/upload_images/00fa1a296be3dabe90d96d6df40f88eb6517ed355ba68.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　おお、このフォント、　**分かってる** フォントだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　多分、 `M Plus 1 Code` フォントの作者が　古臭い日本人なのでは？」  

# 古臭いウィンドウ

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　じゃあ　次は　昔ながらの　古臭いウィンドウを　作ってみましょう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　なんで　わたしたちのやることは　昔とか、古臭いという　形容詞が付くんだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　事実だろ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　**あの** メッセージ・ウィンドウ、現代では　何て呼ばれてるんだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　`StyleBoxFlat` じゃないか？」  

📖　[Theme Variation with StyleBoxTexture returns wrong type #66850](https://bytemeta.vip/repo/godotengine/godot/issues/66850)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　適当に触ってみるか」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　存在しなかった」  

![202309__godot__30-1901--MessageWindow-o2o2o0.png](https://crieit.now.sh/upload_images/c37bdd9c061ac2f77e0aaa9e4102439c6517fba538491.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　そんなときは　Windows Paint で枠を描いて　GIMP で透明度を抜けばいいんだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　技術の無さを　労働で補うの　わらう」  

![202309__godot__30-1944--FixedMessageWindow.png](https://crieit.now.sh/upload_images/9fa2d4312d2781b7c5b72bb52b235b916517fc24c95c9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　固定長で十分だろ」  

![202309__godot__30-1947--FixedMessageWindow-Run.png](https://crieit.now.sh/upload_images/9bb6619bbdd4ab1f5744e418159478456517fce84b68e.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　１、２、３、　……　全角で１行２０文字、３段で  
計　６０文字でいいの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　シナリオライターに　足らん　と言われても　ごめんなさい　しようぜ」  

# 背景を付けましょう

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　バックが方眼紙だと　落ち着かないから　背景を付けましょう」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　オープンソースで　ばらまくのに　ライセンスが適していないフリー素材が　あるからな。  
素材を揃えるのが　難しいぜ」  

![202309__godot__30-2016--Background.png](https://crieit.now.sh/upload_images/1b7a72896d0bfea7544f3e0613303047651803b8a0887.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　コンピューター将棋選手権の会場だぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　著作権的に問題があるのではないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　著作権的に　問題のある素材しか　持ってないぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　困ったわねえ。　素材不足は深刻ねえ」  

# ブリンカー

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　メッセージ・ウィンドウの最後で点滅してる　アレの名前　何だぜ？  
アレを作ろうぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　アレは　文字だろ。　文字と同じように　輪郭を付けて、ドロップシャドウもしなければ  
浮いてしまうだろ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　外字で作れないの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`.otf` ファイルを使っているのに　外字が出てくるのか分からん」  

![202309__godot__30-2237--TextEndBlinker-o2o0.png](https://crieit.now.sh/upload_images/fe4f0f14dc51f17b5558b17aa94054f5651829260dc10.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　とりあえず　Windows Paint と GIMP で　それっぽいのを作って、画面に置いてみようぜ？」  

![202309__godot__30-2300--TextEndBlinkerTest.png](https://crieit.now.sh/upload_images/5cb686df8c66140ddc82eabc38ff391365182a0808e6b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　どうだぜ？　溶け込んでいるかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　浮いているわねぇ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　スポイトで色を吸ってみたけど、白は (248, 248, 248) で同じなんだけど、  
影の色が　違うのよね。影は　半透明にしなきゃ。  
あと、フォントには　アンチエイリアシングが　かかってんのよ」  

![202309__godot__30-2237--TextEndBlinker-o2o2o0.png](https://crieit.now.sh/upload_images/7069410fdde441eab2ebd53f37e76ce365182d48d24d4.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ドロップシャドウも　アンチエイリアシングも　見よう見まねで　Windows Paint と GIMP で　やってみようぜ？」  

![202309__godot__30-2317--TextEndBlinkerTest.png](https://crieit.now.sh/upload_images/4b103bdcca0a239a05bf3b71443b08aa65182e02e2481.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　今度は　どうだぜ？　溶け込んでいるかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　さっきよりは　マシな気がするけど、　三角形が　でかくて　主張が強い気がするのよねえ」  

![202309__godot__30-2321--UnderscoreTriangle.png](https://crieit.now.sh/upload_images/c6a04305412378e070ba4c27bcffd11a65182efd54c6e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　参考に　アンダースコアと　逆三角形の文字を横に並べたが、そんなに違うかだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　逆三角形と　アンダースコアを重ねて置けばいいと思う」  

![202309__godot__30-2340--TextendBlinker.png](https://crieit.now.sh/upload_images/c1dab69174649ab00983be1e615a88a865183390cd792.png)

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これでどうだぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　目の錯覚か　暗く見えるけど　もう　こんなもんで　いいんじゃない？」  

## ブリンカーを点滅させようぜ？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　タイマーを使わなくても、 `_process()` を使えば点滅できるんじゃないか？」  

```gd
extends Label

var count = 0

# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	
	if 0.75 <= count: 
		visible = not visible
		count -= 0.75
```

📺　[動画](https://x.com/muzudho1/status/1708135914936172709?s=20)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　この動画に映ってるブリンカーで　充分よ」  

# 文字が１個ずつ出てくるやつをやろうぜ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　カタカタカタカタ、ってやつ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`Label` コントロールには　テキストを全文入れてるじゃないか。  
あれを　空っぽにして、１文字ずつ　入れていくということかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　そうなるな」  

![202310__godot__01-0022--SetText-o2o0.png](https://crieit.now.sh/upload_images/342c16a4485f52f41514d4fd9c32fb1965183da99fb4c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　例えば、こう書いても　同じことだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　そのテキストを、別のところに保存しておいて、  
時間経過とともに　ラベルに追加していけばいいのよ」  

## 文字列の長さを計るには？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　GDScript で 文字列の長さを計るには？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　この中から探せだぜ」  

📖　[Godot Engine / String](https://docs.godotengine.org/en/stable/classes/class_string.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　スライス　無いのか。じゃあ　Ｃ言語風に書けばいいんだ」  

```gd
extends Label

var count = 0

var text_storage = """お父ん、なんで唐揚げを食べているんだぜ？
ダイエットはどうした？
野菜を TABERO だぜ！
"""

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	
	if 0.05 <= count:
		if 0 < self.text_storage.length():
			self.text += text_storage.substr(0, 1)
			text_storage = text_storage.substr(1, self.text_storage.length()-1)
		count -= 0.05
```

📺　[動画](https://x.com/muzudho1/status/1708144700593705033?s=20)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　この動画に映ってるタイプライター風の文字列出力で　充分よ」  

# 文字が出終わってから　ブリンカーが出るように　合わせてくれだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　文字が出終わってから　ブリンカーが出るように　合わせてくれだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　別のノードの変数を　どうやって参照するのか……。調べるか」  

📖　[[Godot]$(ドルマーク)とget_node関数の違いについて](https://igarashisant.com/2023/02/26/godot_get_node/)  

![202310__godot__01-0105--Blinker-o2o0.png](https://crieit.now.sh/upload_images/de9d5de79f593814fa71adb43065a094651847839148b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ツリー構造を変えて」  

```gd
extends Label

# 点滅用
var is_blink_started = false
var count_of_blink = 0

# タイプライターの文字出力間隔
var count_of_typewriter = 0

# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# テキストを出し終えたか？
	count_of_typewriter += delta
	if not is_blink_started and 0.5 <= count_of_typewriter:
		var message_window_text = $".."
		if message_window_text.get("text_storage").length() < 1:
			is_blink_started = true
			visible = true
			
		count_of_typewriter -= 0.5

	# 点滅
	if is_blink_started:
		count_of_blink += delta
		if 0.75 <= count_of_blink: 
			visible = not visible
			count_of_blink -= 0.75
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ブリンカーのスクリプトも変更」  

📺　[動画](https://x.com/muzudho1/status/1708152891582914856?s=20)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　この動画に映ってるメッセージ・ウィンドウで　充分よ」  

# メッセージ送り、してくれだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　メッセージ送り、してくれだぜ」  

## Push any key

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　何か　どれでも　キーを押したかどうかの判定って、どうやんの？」

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　シグナルを使うことになるんじゃないか？」  

📖　[How to detect if any key is pressed](https://www.reddit.com/r/godot/comments/ie54wt/how_to_detect_if_any_key_is_pressed/)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　Godot では　どんなコレクション・クラスを使えるんだぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　配列しかないんじゃないか？」  

📖　[Godot Engine / Array](https://docs.godotengine.org/en/stable/classes/class_array.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
（カタカタカタカタ）  

📄 `textend_blinker.gd`:  

```gd
extends Label

# 点滅用
var is_blink_started = false
var count_of_blink = 0

# タイプライターの文字出力間隔
var count_of_typewriter = 0

# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# テキストを出し終えたか？
	count_of_typewriter += delta
	if not is_blink_started and 0.5 <= count_of_typewriter:
		var message_window_text = $".."
		if message_window_text.get("text_storage").length() < 1:
			is_blink_started = true
			visible = true
			
		count_of_typewriter -= 0.5

	# 点滅
	if is_blink_started:
		count_of_blink += delta
		if 0.75 <= count_of_blink: 
			visible = not visible
			count_of_blink -= 0.75

func reset():
	self.visible = false
	self.is_blink_started = false
	self.count_of_blink = 0
	self.count_of_typewriter = 0
```

📄 `MessageWindowText.gd`:  

```gd
extends Label

var count_of_typewriter = 0

var scenario_array = [
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	お父ん、知ってたら教えてくれだぜ。
	エスフェン（SFEN）の 7g7f って何だぜ？
	""",
	"""\
	あー。７筋の７段目の駒を
	６段目に突くことだぜ。
	分かったら　もう寝ろ
	""",
	"""\
	3c3d　って何だぜ？
	""",
	"""\
	角換わりだろ。
	もう寝ろ
	""",
	"""\
	お父ん、なんで唐揚げを食べているんだぜ？
	ダイエットはどうした？
	野菜を TABERO だぜ！
	""",
	# ２３４５６７８９０１２３４５６７８９０
	"""\
	元気になりたくて唐揚げを食べるんだぜ。
	カロリー計算をしようと思ったときもあった
	限界まで食べてしまうので止めた
	""",
]

var text_storage = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初のテキスト
	self.text = ""
	
	if self.text_storage == "" and 0 < self.scenario_array.size():
		self.text_storage = self.scenario_array.pop_front()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# タイプライター風出力
	count_of_typewriter += delta
	
	if 0.05 <= count_of_typewriter:
		if 0 < self.text_storage.length():
			self.text += text_storage.substr(0, 1)
			text_storage = text_storage.substr(1, self.text_storage.length()-1)
		count_of_typewriter -= 0.05

func _unhandled_key_input(event):

	print("_unhandled_key_input")

	# 何かキーを押したとき
	if event.is_pressed():
		print("_unhandled_key_input is_pressed")
		# TODO ブリンカーを消す
		$"BlinkerTriangle".reset()
		$"BlinkerUnderscore".reset()
		
		# メッセージ送り
		if self.text_storage == "":
			self.text = ""
			
			if 0 < self.scenario_array.size():
				self.text_storage = self.scenario_array.pop_front()
```

📺　[動画](https://x.com/muzudho1/status/1708165210731844060?s=20)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👆　この動画に映ってるメッセージ・ウィンドウで　だいたい　充分よ」  

# メッセージ・ウィンドウを閉じてくれだぜ

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　出すメッセージが無いんだったら、メッセージ・ウィンドウを閉じてくれだぜ」  

![202310__godot__01-0210--CloseMessageWindow-o2o0.png](https://crieit.now.sh/upload_images/9703b472e2ce93a989d38466961e5f78651856ba7c22c.png)  

```gd
			else:
				# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
				$"..".visible = false
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これで　オッケー」  

# 誰が　しゃべってるか　分からない

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　誰がしゃべってるか　分かんなくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　顔グラ（Face Graphic）を出すと　素材不足で　苦しむしな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　工夫で乗り切るか。  
昔のゲームは　ちからわざ　が使えないときは　ごめんなさい　で通していたからな」  

![202310__godot__01-0230--Name.png](https://crieit.now.sh/upload_images/19d7e0f4b639417f9a24a001d14cd52665185b702e460.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　メッセージ・ウィンドウの中に　名前を書くとかな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　それで十分ねえ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　カギかっこ付けたから　１行に　１９文字しか入らないぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ごめんなさい　するんだぜ」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# 以下、追加機能

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　メッセージの早送り機能が欲しくない？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　どのボタンを押したら　早送りするんだぜ？  
まだ　キーボードで遊ぶのか、ゲームパッドで遊ぶのか、何も決まってないぜ？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　とりあえず　キーボードに絞ってもいいのでは？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　じゃあ　スーパーファミコンの `R` ボタンとか　よく使ったから、キーボードの　`R` キーでいいか」  

```gd
		# １文字 50ms でも、結構ゆっくり
		var wait_time = 0.05
	
		# メッセージの早送り
		if Input.is_key_pressed(KEY_R):
			print("［テキストブロック］　メッセージの早送り")
			wait_time = 0.01
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　こんな感じで　ウェイトを変えればいいぜ」  

```gd
			if event.keycode == KEY_R:
				print("［テキストブロック］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
				return
			# 選択肢モードの場合は、確定ボタン以外は無効
			elif self.is_choice_mode and event is InputEventKey and event.pressed:
				if event.keycode != KEY_ENTER:
					print("［テキストブロック］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
				else:
					print("［テキストブロック］　選んだ選択肢行番号：" + str($"ChoiceCursor".selected_row_number))
					pass
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　逆に、メッセージ送りには　`R` キーは使えないぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`送り` とか `早送り` とか　国語が難しいな」  

.