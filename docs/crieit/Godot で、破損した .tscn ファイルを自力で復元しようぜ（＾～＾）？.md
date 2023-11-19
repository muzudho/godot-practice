# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　リソース・フォルダーの名称変更とか、  
ノード名の変更とか、  
子シーンの生成とか、
やりまくってたら　`.tscn` ファイルのＩｄの整合性が取れなくなったのか、 `.tscn` ファイルを読み込まなくなったぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　地獄ね」  

![202311__shogi__19-1116--font-crushed.png](https://crieit.now.sh/upload_images/0e92962ce1d9035efefab6dd8dfc5b3c6559702ea1a94.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　設定をすべて復元しないと、フォント情報が消えていたりするぜ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　ファイルの破損とか、Godot のユーザーサポートの、サポート外だろ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ゲームではなく、　Godot　を作るレベルのスキルを　プログラミング・スキルと呼ぶのよ。  
あんたのお父んは　プログラミング・スキルを持ったプログラマーで、  
破損したファイルの復元とか、　何も仕様がないところからの解析とか　するのが通常業務よ」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　なりたくない職業だな」  

## gd_scene

📄 `*.tscn`:  

```tscn
[gd_scene load_steps=78 format=3 uid="uid://ccxa7p87p2u60"]
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　`.tscn` ファイルの先頭は　`gd_scene`　ブラケットで始まるが、このファイルの書式もよく分からない」  

## ext_resource

```tscn
[ext_resource type="Script" path="res://🍋scripts/🪑grayscale_🍉kifuwarabe_rpg/director.gd" id="1_wmnp6"]
[ext_resource type="Texture2D" uid="uid://bkfsr571tdwqf" path="res://🍋images/🪑grayscale/1280x720/grid.png" id="2_ivwoj"]
[ext_resource type="AudioStream" uid="uid://wtqqhswcs7ni" path="res://🍋audio_bgm/🪑sakuramaru/きふわらべファイター２.ogg" id="8_8nkdr"]
[ext_resource type="LabelSettings" uid="uid://dc5ae2mnxhltk" path="res://🍋label_settings/🪑grayscale/game_title.tres" id="43_phx2h"]
[ext_resource type="PackedScene" uid="uid://daqtppg5rtuat" path="res://downloads_from_🍉kifuwarabe_visual_novel/📂programmer_🎬Instructions_🍉kifuwarabe_visual_novel.tscn" id="58_sadl4"]
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　以下、 `id` 順で `ext_resource` ブラケットが並ぶぜ。  
Ｉｄ順って　読むとき　何も嬉しくない……」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　お父んが　🍋　の文字を付けたやつ、だいたい `ext_resource` と一致するな」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`.tscn` に並んでいる `ext_resourec` ブラケットと、  
ファイル・エクスプローラーに並んでいる　素材ファイルを　１つ１つ　在るかチェックすればいいのね。  
棚卸みたいよね」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　それぐらい　プログラムでやればいいのでは……」  

## sub_resource

```tscn
[sub_resource type="CanvasItemMaterial" id="CanvasItemMaterial_glhd8"]


[sub_resource type="LabelSettings" id="LabelSettings_f3kmi"]
line_spacing = 1.0
font = ExtResource("47_nlh77")
font_size = 32
outline_size = 10
outline_color = Color(0.12549, 0.12549, 0.12549, 1)
shadow_size = 5
shadow_color = Color(0.12549, 0.12549, 0.12549, 1)
shadow_offset = Vector2(3, 3)


[sub_resource type="LabelSettings" id="LabelSettings_ts82g"]
line_spacing = 1.0
font = ExtResource("47_nlh77")
font_size = 24
outline_size = 10
outline_color = Color(0.12549, 0.12549, 0.12549, 1)
shadow_size = 5
shadow_color = Color(0.12549, 0.12549, 0.12549, 1)
shadow_offset = Vector2(3, 3)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　以下、 `.tscn` ファイルに書けそうなテキストデータは　`sub_resource`　として並ぶぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　ラベルのフォント設定とかねえ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`ExtResource("47_nlh77")` のように、Ｉｄが紐づけされている。  
これが　１つでも整合性が取れないと　`*.tscn` ファイルは読めなくなる」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　つらい」  

![202311__shogi__19-1101--label-settings.png](https://crieit.now.sh/upload_images/24e63e9bbb39ffd652fb74d9503853ef65596cc3d0288.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　例えば　この画面のように　フォントに色付けたり、ドロップシャドウを濃くしたり、  
ちょっと傾けたり、１度しか使わないような設定が　`sub_resource` だぜ」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　`.tscn` ファイルが破損すると　この角度をちょっとずらしたやつの設定とか  
手動で　Ｉｄの紐づけを復元していくぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　地獄をバリエーション豊かにしないでほしいわね」  

.