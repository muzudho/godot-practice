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

.