#	メッセージ・ウィンドウ（Message Window；伝言窓）
extends Node2D


#	状態遷移機械
var statemachine = load("scripts/MessageWindowStatemachine.gd").new()


#	メッセージ・ウィンドウを閉じる
func initialize():
	$"System/TextBlock".initialize()
	self.statemachine.all_page_flushed()


#	ウィンドウを空っぽにして、次の指示を待ちます
func clear_and_awaiting_order():
	print("［メッセージ・ウィンドウ］　ウィンドウを空っぽにして、次の指示を待ちます")
	$"System/TextBlock".text = ""

	#	メッセージウィンドウは指示待ちだ
	$"../../AssistantDirector".is_message_window_waiting_for_order = true


#	先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	#	最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1, text.length() - (index+1))
	# print("［メッセージ・ウィンドウ］　head：　[" + head + "]")
	# print("［メッセージ・ウィンドウ］　tail：　[" + tail + "]")
	return [head, tail]


#	メッセージを追加
func push_message(text, node_name):
	# print("［メッセージ・ウィンドウ］　台詞追加")
	print("［メッセージ・ウィンドウ］　台詞：　[" + node_name + "][" + text + "]")

	#	表示
	self.show()
	$"System".show()
	self.get_node(node_name).show()

	#	メッセージ追加
	$"System/TextBlock".push_message(text)

	#	タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()


#	選択肢を追加
func push_choices(row_numbers, text, node_name):
	print("［メッセージ・ウィンドウ］　選択肢：　[" + node_name + "][" + text + "]")

	#	表示
	self.show()
	$"System".show()
	self.get_node(node_name).show()

	#	メッセージ追加
	$"System/TextBlock".push_choices(row_numbers, text)

	#	タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()



#	ページ送り
func on_page_forward():
	#	効果音
	$"../../Musician".playSe("ページめくり音")
	
	#	ブリンカーを消す
	$"System/TextBlock".clear_blinker()

	#	ウィンドウを空っぽにして、次の指示を待ちます
	self.clear_and_awaiting_order()


#	下位ノードで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected():
	#	カーソル音
	$"../../Musician".playSe("選択肢確定音")
	
	var row_number = $"System/TextBlock/ChoiceCursor".selected_row_number	
	print("［メッセージ・ウィンドウ］　選んだ選択肢行番号：" + str(row_number))

	#	選択肢の行番号を、上位ノードへエスカレーションします
	$"../../AssistantDirector".on_choice_selected(row_number)


#	サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# ステートマシーンを、子にも参照させる
	$"下".statemachine = self.statemachine
	$"System/TextBlock".statemachine = self.statemachine
	$"System/TextBlock/BlinkerTriangle".statemachine = self.statemachine
	$"System/TextBlock/BlinkerUnderscore".statemachine = self.statemachine
	$"System/TextBlock/ChoiceCursor".statemachine = self.statemachine

	#	ウィンドウを空っぽにする
	$"System/TextBlock".text = ""


#	テキストボックスなどにフォーカスが無いときの入力を拾う
func _unhandled_key_input(event):
	
	#	完全表示中
	if self.statemachine.is_completed():

		#	選択肢モードなら
		if $"System/TextBlock".is_choice_mode:
			
			#	何かキーを押したとき
			if event.is_pressed():
				
				#	確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					# print("［メッセージ・ウィンドウ］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
					
				else:
					#	選択肢を確定した
					self.on_choice_selected()
					return
		
		#	それ以外なら
		else:
		
			#	何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					# print("［メッセージ・ウィンドウ］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
				
				#	ページ送り
				self.on_page_forward()
