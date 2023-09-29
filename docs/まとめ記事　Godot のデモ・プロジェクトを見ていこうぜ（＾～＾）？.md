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
「　👆　画面右側から　パーティクル（粒）（※実際はPNG画像）が　ゆっくり左へ移動してくるから、  
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

学習の難しさの目安：　初級者の下の方。　眺めるのは簡単、理解するのは難しい  

![202309__godot__28-2218--isometric.png](https://crieit.now.sh/upload_images/f08901216860c62b0d6f98a25eeb05e465157d5ec31ad.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　アイソメトリックというのは　誇張とか入ってなくて　線が　真面目に　きっちり　してるやつだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　その説明では　何を言わんとしているか　分からんな……」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　方眼紙っぽいやつよ」  

![202309__godot__28-2218--isometric-tileMap.png](https://crieit.now.sh/upload_images/834a99920f681caa74a5afc30b097ebb65157e503195f.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　編集画面で　タイルマップを選べば　クォータービュー用のグリッドも出てくるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　やっぱり　第一義は　タイルマップの使い方を覚えることだと思うんだが……」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　肝心のタイルマップの使い方が分からないぜ」  

# kinematic_character

学習の難しさの目安：　初級者の上の方  

![202309__godot__28-2237--KinematicCharacter.png](https://crieit.now.sh/upload_images/42662b6ddcdfc12d670617d4acb55bc9651581bddfa05.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　キーボードの左右キーで移動、スペース・キーでジャンプする　白い箱を操って  
画面左上のピンクの箱を目指すアクションゲームだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　キネマティック（Kinematic）ってどういう意味？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　運動らしいんだが、なんのことだか分からないぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　坂とか　回転する円とか　上下に移動するリフトとかあるから、運動なんじゃないの？」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　アクション・ゲームの作り方かな。  
左右への移動と　ジャンプのソースコードは　短くて　読みやすい」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しかし海外の人は　ステージとか　マップのことを　`level`　って呼ぶんだな。  
ステージが入っているフォルダ―の名前が　`level`　だぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　文化が違うのよ」  

# light2d_as_mask

学習の難しさの目安：　不明。仕組みが分からんかった  

![202309__godot__28-2251--Light2D_as_mask.png](https://crieit.now.sh/upload_images/5e27c469d76e19ed179ae436244199b165158515776e4.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　マスクという機能を使えば　幕に穴を開けたみたいな効果があって、  
これを　スポットライトみたいな演出に使えるという古典的なテクニックのデモだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`AnimationPlayer`　というのを使って　画像を移動させてるんで  
それを見てもいいし」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　グレーの色が　なんなのか　分からんかった」  

# lights_and_shadows

学習の難しさの目安：　不明  

![202309__godot__28-2259--LightsAndShadows.png](https://crieit.now.sh/upload_images/d9120cd9c415e47fb7e0b2ccf3a24bc5651586e3cda3c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　光源が勝手に移動するんで、光沢と陰影を眺めるデモだぜ」  

![202309__godot__28-2302--DirectionalLight.png](https://crieit.now.sh/upload_images/3be3b15978d58475877129d077f821d0651587a7c82de.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　キーボードの　`d`　キーを打鍵すると　光源が指向性を持つぜ」  

![202309__godot__28-2305--PointLights.png](https://crieit.now.sh/upload_images/c3421f6c3fc250ad014e986b529ae56e6515882a1e2b0.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　キーボードの　`p`　キーを打鍵すると　光が消えてしまったぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`s`　キーと　`h`　キーにも何か仕掛けがあるようだが、　光がボヤっとしたり　しゃきっとしたり　ぐらいで  
わたしには　分からん」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　画面上にテキストを置くための　ラベル　を覚えたり」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ライトの可視性（Visible）を　オンにしたり、オフにしたりするところが　見所じゃないか？」  

# navigation

学習の難しさの目安：　実行不能  

![202309__godot__28-2323--Navigation.png](https://crieit.now.sh/upload_images/cf0f0ffe52ba6d5dc95f993d1512844565158c8051044.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　コンパイル・エラーで動かなかったぜ」  

# navigation_astar

学習の難しさの目安：　上級者  

![202309__godot__28-2313--ASterArgorithm.png](https://crieit.now.sh/upload_images/ba1f73e3a33e4640dc26ea20db16924265158a3c59416.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　これは　有名な　エー・スター・アルゴリズム（A* argorithum）だぜ。  
マウスで　升をクリックすれば、最短距離の道筋を示して　移動してくれるぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　画面上のクリックした位置の取り方とかかな」  

# particles

学習の難しさの目安：　上級者  

![202309__godot__28-2326--Particles.png](https://crieit.now.sh/upload_images/3e2bc68318ebe9e94c86f022fcdf913e65158d475d6e5.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　パーティクル（粒）のデモだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　スペース・キーを打鍵すると　一時停止するぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　上キー、下キー、 `g` キーを打鍵しても　細かな違いが出るが　わたしには分からん」  

![202309__godot__28-2331--ParticleTrails.png](https://crieit.now.sh/upload_images/fb98a65035d96708704b7dd268640dea65158e41010d5.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`t` キーを打鍵すると　粒が尾を引くぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　粒を飛ばせば　炎に見えたり、液体に見えたり、煙に見えたり、応用範囲が広いやつだぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　パーティクルは　プログラム要らずで　**インスペクター** ビューの設定を適当にいじれば  
適当に振る舞いが変わることを　覚えるぐらいかな」  

# physics_platformer

学習の難しさの目安：　上級者  

![202309__godot__28-2337--PhysicsPlatformer.png](https://crieit.now.sh/upload_images/36f4b557f2b0875868a2127cee8f527d65158fcaa8468.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ＢＧＭがバカでかい！　うるさい！」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ロックマンみたいな　アクション・ゲームだぜ。  
`A`、 `D`、`W` キーで　左右移動とジャンプ、スペース・キーで重力に従う球　発射だぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ステージ上のコインを全部取っても　何も起きないわよ！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　プラットフォーム（Platform）って、移動する足場のことなんだ、へぇ、みたいな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　難しくて　分からんかったか」  

# physics_tests

![202309__godot__29-2017--PhysicsTests.png](https://crieit.now.sh/upload_images/ed5fdba14768d5b484269431068f7ad76516b281c12c3.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　物理演算のテストじゃないか？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`R` キーを打鍵すると　もう１回テストするぜ」  

![202309__godot__29-2020--BoxStack.png](https://crieit.now.sh/upload_images/e7b3632c123d10105c455cce8abe550d6516b324b05fa.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　左上の `TESTS` のボタンから　いろいろ選べる。これは　詰まれた箱を眺めるテストだぜ」  

![202309__godot__29-2022--BoxPyramid.png](https://crieit.now.sh/upload_images/9847d5ddf4b3b5ad16e64b687bf80e1f6516b39a6a63a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ピラミッド状にも積むテスト」  

![202309__godot__29-2026--Collision.png](https://crieit.now.sh/upload_images/d973f3cdb6bf60436e348db5519dc21c6516b47a34ea6.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　直方体をぶつけるテストだぜ。明るい緑色になってるやつは　当たってるぜ。  
直方体の形も　いくつかの中から選べるぜ」  

![202309__godot__29-2035--CharacterSlopes.png](https://crieit.now.sh/upload_images/e71270b8dda511422bd209a4f8ce469d6516b757dbd29.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　縦長の楕円みたいなカプセルを `A`、`D`、`W` キーを使って操作して、坂道を昇り降りするテストだぜ」  

![202309__godot__29-2303--CharacterTileMap.png](https://crieit.now.sh/upload_images/e52e61eef525841880c2b62f0220f0046516d95dd13c2.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Tilemap` は、タイルでステージが作られてるな。キーボードを打鍵して、このステージで長方形のキャラクターを操作するテストだぜ」  

![202309__godot__29-2306--CharacterPixels.png](https://crieit.now.sh/upload_images/6707fb0d0c89fdee379e491a774ce5056516d9e0c4528.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Pixels` も　長方形を操作するテスト」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`One way Collision` というテストは強制終了して落ちた」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　テストを繰り返したあと　PC をスリープしたのがダメなのでは」  

![202309__godot__29-2309--OneWayCollision.png](https://crieit.now.sh/upload_images/a63249afab62d961b879d7248e44b9536516dab3c2d20.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　起動したけど　意味分からん。説明不能」  

![202309__godot__29-2311--Joints.png](https://crieit.now.sh/upload_images/28c25c0ad2ffe0bcc04350bb6ad4dae06516db37e3a93.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Joints` 。マウスで　オブジェクトを引きずることができて、鎖みたいにつながってるぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　つながり方も　ゴムみたいなやつとか　選べたり、  
２つのオブジェクトは　ぶつかるかどうかも　設定できるぜ」  

![202309__godot__29-2314--Raycasting.png](https://crieit.now.sh/upload_images/d4598e22155bd6cee2ba9dc48f0b3e466516dbf358b23.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`Raycasting` は、直線上に見えない球を飛ばして　ぶつかるポイントを調べるやつだぜ」  

![202309__godot__29-2316--PerformanceTest.png](https://crieit.now.sh/upload_images/74dd6d33b947b483fcf84d53e1be84fc6516dc51b9db1.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　その他に　パフォーマンス・テストがあるが　何やってるか　さっぱり」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　GDScript がいっぱい入っているが　どれも見る気が起きない」  

# platformer

![202309__godot__29-2320--Platformer.png](https://crieit.now.sh/upload_images/00e1f9465f7105bcdf04672dbb3ee0dd6516dd48a3705.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ＢＧＭがバカでかい！　うるさい！」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ロックマンみたいな　アクション・ゲームだぜ。  
`A`、 `D`、`W` キーで　左右移動とジャンプ、スペース・キーで重力に従う球　発射だぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ステージ上のコインを全部取っても　何も起きないわよ！」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　プラットフォーム（Platform）って、移動する足場のことなんだ、へぇ、みたいな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　難しくて　分からんかったか」  

# pong

学習の難しさの目安：　初級者の真ん中の方  

![202309__godot__29-2322--Pong.png](https://crieit.now.sh/upload_images/d81d135f4de480e8a4a6d1bdeddb8d336516ddcb226fe.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ビデオゲーム史に出てくる　お金を入れて遊ぶアーケードゲームのようなやつの　最初のやつだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　左の水色の板（※パドル）はキーボードの `W`、`S` キーで上下に動かす。  
右の赤紫の板はキーボードのカーソルの　上下キーで上下に動かすぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　このデモ・プロジェクトからは　何を学べるんだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　パドルを上下に動かす GDScript とかが簡単かなあ」  

# role_playing_game

# screen_space_shaders

# skeleton

# sprite_shaders

# tween