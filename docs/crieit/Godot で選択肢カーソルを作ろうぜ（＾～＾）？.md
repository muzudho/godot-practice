# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　選択肢カーソルは」  

```
→ ・攻める
　・守る
　・投了
　・勝ち宣言
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　上記の場合は　`1,2,3,4`　と表し、」  

```
　さあ選べ
→ ・居飛車
　・振り飛車
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　上記の場合は　`2,3`　と表す。  
つまり　どの行の頭にカーソルが止まるか、序数で表す」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　このような数列を入れている配列を `choices_row_numbers` と呼ぶぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　汎用性があるかは知らんが、まあ　いいんじゃないか」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　現在、カーソルが指している `choices_row_numbers` 配列の要素のインデックスを
`choices_index` と呼ぶ。初期値は `0`」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　現在、カーソルが指している行番号を取得するには、  
`get_row_number_of_choices()` メソッドを使う」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　選択肢カーソルを下へ移動できるかは、 `can_cursor_down()` メソッドを使う。  
真偽値を返す」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　選択肢カーソルを上へ移動できるかは、 `can_cursor_up()` メソッドを使う。  
真偽値を返す」  

## あっ！

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　レバーを押したか、離したかを見てないな。  
レバーを押したときと、離したときで　２回　入力が入っている」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　直せ！」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　レバーを押したときだけ反応するようにしたら、  
不具合が１つ直って、別の不具合が出てきたぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　前進よ、前進」  

## ウィンドウごとの、カーソルの初期位置をどう記憶する？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　カーソルの初期位置を　どう記憶するか。  
初期位置というより、原点がいいのか」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　`choices_cursor_origin_x` と、 `choices_cursor_origin_y` 変数を用意しろだぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　先頭が１行目とは限らないんだよな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`get_cursor_x()` と、 `get_cursor_y()` メソッドを作りなさいよ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`font_height` を 32、 `line_space_height` を 16 として、  
座標を計算してみるぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ラベルは　`get_transform().x` や、 `get_transform().y` より、  
`offset_left` 、 `offset_top` を使った方がいいのかだぜ？  
よく分からんなあ」  

.