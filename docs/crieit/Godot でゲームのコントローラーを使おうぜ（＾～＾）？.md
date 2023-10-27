# 親記事から来た

📖　[Godot って何だぜ（＾～＾）？](https://crieit.net/posts/Godot-65115761b6a17)  

# はじめに

![202310__photo__27-2220--Gamepad.jpg](https://crieit.now.sh/upload_images/d713d338edceee98e75f4eccda2800e9653bb92629320.jpg)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　ゲームパッドが届いたので　Godot　はゲームパッドを使えるか　調べようぜ？」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　こういうコントローラーは　どうやって使うの？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ハードウェアと　ハードウェアは結局　ピンが束になったバスで　つながってるだけで  
そこを電気信号が通るだけだぜ。  
現代だと　USB規格　を使うだろうから、  
USB端子を　USBポートに差し込めば  
OS に何か刺さった、という　自動認識まではしてくれるんじゃないかな」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　やってくれだぜ」  

![202310__photo__27-2232--Gamepad-o2o0.jpg](https://crieit.now.sh/upload_images/c06c18cdbaa0040dc757352a36e64819653bbc515950e.jpg)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　じゃあ　USB ケーブルを指すぜ。無線のもあるな」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　USB メモリータイプの端子挿したら　PCから音が出て　反応して　セットアップが自動的に始まって  
セットアップが終わったぜ」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　電池は？」  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　ケーブル挿して１、２時間でチャージが終わるそうだぜ。電池は取り出せなさそう」  

![kifuwarabe-futsu.png](https://crieit.now.sh/upload_images/beaf94b260ae2602ca8cf7f5bbc769c261daf8686dbda.png)  
「　じゃあ　ケーブル挿せだぜ」  

## Godot の説明書読もうぜ？

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👇　説明書読むか～」  

📖　[Controllers, gamepads, and joysticks](https://docs.godotengine.org/en/stable/tutorials/inputs/controllers_gamepads_joysticks.html)  

```
E 0:00:00:0571   director.gd:24 @ _process(): The InputMap action "move_back" doesn't exist. Did you mean "ui_text_backspace"?
  <C++ エラー>      Condition "!InputMap::get_singleton()->has_action(p_action)" is true. Returning: 0.0
  <C++ ソース>      core/input/input.cpp:346 @ get_action_raw_strength()
  <スタックトレース>     director.gd:24 @ _process()
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　いや　もう　エラー出たが」  

![202310__godot__27-2316--InputMap.png](https://crieit.now.sh/upload_images/ff4a2920b1acef9476e36663df09bc5b653bc6549e0ed.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　インプットマップが空なのと　何か関係あるかだぜ？」  

![202310__godot__27-2316--InputMap-o2o0.png](https://crieit.now.sh/upload_images/2644461e23db9ed66971483e7c6e1225653bc6ee33603.png)  

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　あっ、何か出た！」  

![ohkina-hiyoko-futsu2.png](https://crieit.now.sh/upload_images/96fb09724c3ce40ee0861a0fd1da563d61daf8a09d9bc.png)  
「　`ui_left` というのが使えるんじゃないの？」  

```gd
func _process(_delta):
	
	var velocity = Input.get_vector(
			&"ui_left",		# 左の方
			&"ui_right",	# 右の方
			&"ui_forward",	# 上の方
			&"ui_back")		# 下の方

	$"GuiArtist/CanvasLayer/←→値".text = str(velocity.x)
```

![ramen-tabero-futsu2.png](https://crieit.now.sh/upload_images/d27ea8dcfad541918d9094b9aed83e7d61daf8532bbbe.png)  
「　👆　よし、取れたぜ」  
