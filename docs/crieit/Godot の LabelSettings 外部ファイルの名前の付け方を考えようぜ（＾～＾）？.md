# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　既にあるのに、同じものを作ってしまうのは　失敗の初期工程だぜ」  

## 実践1

```plaintext
battle_light_blue.tres
battle_light_green.tres
credits_roll.tres
game_title.tres
label_setting_large.tres
label_setting_medium.tres
large_font.tres
main_medium.tres
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ファイル名の付け方で　一番気にすることは、　同じものを何個も作ることがないようにすることだぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　戦闘シーンとか　タイトル画面とか　使う場所で分けるのはどうなの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　別れるばかりで整理ではない」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父んが　分けたのに……」  

![202311__godot__20-1851--label-settings.png](https://crieit.now.sh/upload_images/2741cdcd70f4c6c908d44d87929a05f8655b2c59a89d3.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ひとまず　ラベル設定で　１番優先される項目は　独断で　フォント・サイズということにしよう。  
上図では　32 ピクセルのフォントだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　この　ラベル設定の外部ファイルの名前を　`medium.tres`　と名付けるとしようぜ？」  

![202311__godot__20-1900--large-label.png](https://crieit.now.sh/upload_images/cc8e9af7e65aa0317707b0c9b31c7cc6655b2e8a087f5.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　一辺が　２倍になったフォントのラベル設定は　`large.tres`　と名付けようぜ？」  

## 実践2

```
title_copyright.tscn
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　使う場面、使う箇所によって　フォントを　細かく設定していては  
ファイルが増える一方なんで……」  

```
medium_thin.tscn
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　文字サイズ中、線の太さは細い、みたいな　名前の方を　使うことにするぜ」  

![202311__godot__20-2040--large-settings.png](https://crieit.now.sh/upload_images/101bd96e6f8c52fd69d7d2789474b776655b45d83aa6b.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ひとまず　これぐらいでいいだろう」  

# 親記事へ戻る

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

.
.