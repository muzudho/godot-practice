# 親の記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　**GDScript** の説明は　下のリンク先にあるぜ」  

📖　[Godot Engine 4.2の日本語のドキュメント / スクリプト言語](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/scripting_languages.html#doc-scripting)  

# ノード

![202309__godot__30-0005--Node-o2o0.png](https://crieit.now.sh/upload_images/fdd39aeaa2d5c671f89ffed9d658be156516e889b7f77.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　**Godot** にあるものは全て　ノード（Node）で、  
**GDScript** というのは　そのノードを操作するものみたいだな」  

# Python に似ているが全然別物

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　GDScript は Python に似ているが　全然別物ということだぜ。  
新しく覚え直せだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　また、GDScript の実行速度は遅いらしいぜ。  
GDScript は C++ 言語で書かれたプログラムを呼び出すから、内部的な処理は速いらしいぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　Python と同じ生き方してんな」  

# Godot の独特な用語：　シーン

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　👇　Godot には　ノードと　シーンという用語が出てくるんだけど、  
計算機科学の　わたしたちから見ると　造語のクセがあるわよ」  

📖　[ノードとシーン](https://docs.godotengine.org/ja/4.x/getting_started/step_by_step/nodes_and_scenes.html)

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　えーと、つまり」  

![202309__godot__30-0031--GraphTheory.png](https://crieit.now.sh/upload_images/3f070cde77a220f4642ea4987d8605926516ee88a3639.png)  

.![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　グラフセオリー（Graph Theory；グラフ理論）の一題材の　ツリー・ストラクチャー（Tree Structure；木構造）を  
わたしたちは　知っているが」  

![202309__godot__30-0035--GodotScene.png](https://crieit.now.sh/upload_images/0c720d2ecfdc095edc3554898aae1be36516ef2d9a4a9.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　Godot は　ツリーのことを　シーン（Scene）と言い換えているのかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　多分そう」  

![202309__godot__30-0039--SubTree.png](https://crieit.now.sh/upload_images/c723716349b74fe153556ddc74bae6306516f01b5fe5a.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　さらに　計算機科学の　わたしたちは　木の中に含まれるサブツリー（Subtree；部分木）を知っているぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　部分木もまた　木よね」  

![202309__godot__30-0043--GodotSceneNest.png](https://crieit.now.sh/upload_images/5e451eea55c0b09804de8b311bfb3e1c6516f0ee9926c.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　Godot では、 シーンもまた　ノードになる、という　**言い方**　をしている」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　シーンは　ツリーなんだ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　シーン、つまり　サブツリーのファイルの拡張子は 　`.tscn`　のようね」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　なんて発音するか分からん嫌な拡張子だ……　ティーシーン？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　Godot は、 `.tscn` を再生するプレイヤーなのよ」  

# GDScript Reference

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👇　GDScript のリファレンスがあるそうだぜ。リンクをメモしておこう」  

📖　[GDScript reference](https://docs.godotengine.org/ja/4.x/tutorials/scripting/gdscript/gdscript_basics.html#doc-gdscript)  

# なんか　画像素材を１つ用意しろだぜ

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　プログラムのレッスンを進めていくんで、なにか　小さな画像素材を　１つ用意してくれだぜ」  

![2016_8_6_0_20_30_88_c1.png](https://crieit.now.sh/upload_images/81b266d4e53136836776cee61a431baf6516f3666e8a1.png)  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　👆　わたしで　いいかだぜ？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　しかたないな……　じゃあ　それで」  

.