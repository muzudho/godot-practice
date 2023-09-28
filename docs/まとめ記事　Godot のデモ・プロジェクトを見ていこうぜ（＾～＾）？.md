# 前の記事

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　Godot （ゴドー）のデモ・プロジェクトは、以下のレポジトリ―に置かれているぜ」  

📖　[godotengine/godot-demo-projects](https://github.com/godotengine/godot-demo-projects)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　Godot のポータルは　取っ散らかっていて　**入り口にドアが１００個ぐらいあり用事の無い部屋に入ってしまう**　という状況だが、  
初級者向けのドキュメントは　**Learn**　に　あるぜ」  

📖　[Godot Engine 4.2の日本語のドキュメント](https://docs.godotengine.org/ja/4.x/getting_started/first_2d_game/index.html)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　結論言うと　う～ん洋ゲー畑　よ。　あんたたちの思ってる　ＪＲＰＧ　とも　同ソ　とも違うから  
わたしたちは　アウェーでマイナーよ。　端っこで　細々と　やりなさい」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　インディーゲームを自称する人は好きそう。わたしは嫌い」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　2Dゲームの　デモ・プロジェクトは　いろいろ入っているが、どれから　見ていくんだぜ？」  

![202309_shogi_28-1947--ProjectManager.png](https://crieit.now.sh/upload_images/26abd0af4ce82242b357602c1da3fc9e65155a2c97ac9.png)  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　アルファベットの昇順で良くない？」  

# bullet_shower

学習の難しさの目安：　初級者の上の方  

![202309__godot__28-2005--BulletShower.png](https://crieit.now.sh/upload_images/0f703136916a2f0c2008c5747f3ca78665155e4103848.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　画面右側から　パーティクル（粒）が　ゆっくり左へ移動してくるから、  
マウスポインターに追随する顔の絵を　粒に当たらないように　避けてあげましょう、という  
一種の弾幕ゲームのようなものだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　粒は　PNG画像なんで、 `bullet.png` を大量に画面上にばら撒いたあと、  
時間経過とともに　粒が左へ動く、という書き方を `bullets.gd` ファイル１つで覚えることができるぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　でも　初級者がソース見たら　うわっ　と思うわよ」  

# dodge_the_creeps

学習の難しさの目安：　強い初級者　卒業レベル  

![202309_godot_25-2033--dodge_the_creeps.png](https://crieit.now.sh/upload_images/2475544ad04d6392c591b8188bf42d3a6515650bb44a9.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　音量がデカい。うるさい」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　キーボードのカーソルキーの上下左右を使って、目玉の化け物を  
気持ち悪い化け物に衝突しないように　逃がすゲームよ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　このデモ・プロジェクトには　ドキュメントがある。  
２Ｄゲームの作り方を覚えるための　最初の課題という位置づけのようだぜ」  

📖　[Godot Engine 4.2の日本語のドキュメント](https://docs.godotengine.org/ja/4.x/getting_started/first_2d_game/index.html)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　本当の初級者は　これでも難しい。　強い初級者向けだぜ。  
部活で　気合が入ってるぐらいのやつが　やるやつ」  

# finite_state_machine

学習の難しさの目安：　中級者　情報処理やるやつ必修  

![202309_godot_25-2052--finite-state-machine.png](https://crieit.now.sh/upload_images/6c088224e4ec44b769d394181cefe31d651569394f0b5.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　有限オートマトンだぜ。　コンピューターを使う、あらゆる仕事で役に立つ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　状態遷移図を知ってるやつが見ると　ソース　すいすい読めるが、  
知らないやつが見ても　ソース読めないだろうから、  
初級者向けとは　言い難い……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　デモ・プログラムであって、レッスン用のプログラムじゃないのよ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Godot のスキル習得用の　階段状にステップアップしていける　チュートリアルが欲しかったのに……」  

# glow

学習の難しさの目安：　不明。マウスボタン押下でオブジェクトをずらしたい人向け。　ソースコードは短いが理解しがたい

![202309_godot_25-2111--glow.png](https://crieit.now.sh/upload_images/fa877c6268763e1bf71617e2528cc60465156d98d4252.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　マウスの任意のボタンを押下すると　マウスポインターの移動に応じて  
洞窟が　水平方向に　ずれてくれるという　センスがよく分からんものだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　なんだか　よく分からんデモねえ」  

# hexagonal_map

学習の難しさの目安：　初級者の下の方。　眺めるのは簡単、理解するのは難しい

![202309__godot__28-2138--hexagonal-map.png](https://crieit.now.sh/upload_images/ec3594af5e4393f3c7973ce9236ac096651573e56064e.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　みんな大好き　６角形の升　ヘックスだぜ。
キーボードの上下左右カーソルで　ゴブリンをずらすことぐらいは　できるぜ」  

![202309__godot__28-2141--hexagonal-map-editor.png](https://crieit.now.sh/upload_images/cb2277a58949ecac08c5bb2d63a1b1f76515749f1e676.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　また、編集画面では　六角形のグリッドが付いているぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　エディターの下側の　その　タイルって　どうやって出したの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　最初から出ていた」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　緑の化け物は　ゴブリンではなくて　トロールのようだが、  
トロールを　カーソルで移動する以外は　ヘックスで　マップを作ろうということだけ  
自分で勝手に覚えろといった感じだな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　肝心の使い方は　分からん」  

# instancing

学習の難しさの目安：　初級者の下の方。　早めに習得できるか  

![202309__godot__28-2159--instancing.png](https://crieit.now.sh/upload_images/cf2d67616a3c3e53f22f16a1044dc92f651578f5be463.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　インスタンシエートと言えば、ゲームの空間にオブジェクトを１つ生成することだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　マウスでクリックしたところに　ボーリングの球のようなものが１個　新規作成されるぜ。  
物理計算が働いているようで、　コップの中に水をそそぐように　どんどん　溜まっていくぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　やっぱり、インスタンシエートする手順を覚えることが　第一義　だと思うが、  
それにしても　`*.tscn`　ファイルが球の素（もと）となって　球を　インスタンシエートするのは　godot　よく分からん、  
まあ　ソース見てみろだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　それ以外のとこは　物理エンジンと　コリジョン判定で押し切ってる感じかしらねえ」  

# isometric

# kinematic_character

# light2d_as_mask

# lights_and_shadows

# navigation

# navigation_astar

# particles

# physics_platformer

# physics_tests

# platformer

# pong

# role_playing_game

# screen_space_shaders

# skeleton

# sprite_shaders

# tween