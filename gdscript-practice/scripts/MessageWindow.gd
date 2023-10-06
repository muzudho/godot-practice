# メッセージ・ウィンドウ（Message Window）
extends Node

# 状態遷移機械
var statemachine = load("scripts/MessageWindowStatemachine.gd").new()


# テキストエリアへ、内容を渡す
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　テキストエリアへ、内容を渡す")
	$"./TextBlock".set_scenario_array(scenario_array)


# 下位ノードで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	# print("［メッセージ・ウィンドウ］　選んだ選択肢行番号：" + str(row_number))
	$"../AssistantDirector".on_choice_selected(row_number)


# サブツリーが全てインスタンス化されたときに呼び出される
func _ready():
	# ステートマシーンを、子にも参照させる
	$"Background".statemachine = self.statemachine
	$"TextBlock".statemachine = self.statemachine
	$"TextBlock/BlinkerTriangle".statemachine = self.statemachine
	$"TextBlock/BlinkerUnderscore".statemachine = self.statemachine
	$"TextBlock/ChoiceCursor".statemachine = self.statemachine


func _process(_delta):
	pass

func _unhandled_key_input(event):
	
	# 完全表示中
	if self.statemachine.is_completed():

		# 選択肢モードなら
		if $"TextBlock".is_choice_mode:
			
			# 何かキーを押したとき
			if event.is_pressed():
				#  and event is InputEventKey and event.pressed
				
				# 確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					print("［テキストブロック］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
					
				else:
					# 選択肢の行番号を、上位ノードへエスカレーションします
					self.on_choice_selected($"TextBlock/ChoiceCursor".selected_row_number)
					return
		
		# 非モードなら
		else:
		
			# 何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					print("［テキストブロック］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
					
				# ブリンカーを消す
				$"TextBlock".clear_blinker()
				
				if 0 < $"TextBlock".scenario_array.size():
					# まだあるよ
					
					# メッセージ送り
					$"TextBlock".forward_message()
					
					# タイプライター風表示へ状態遷移
					self.statemachine.page_forward()
					
				else:
					# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
					$"TextBlock".initialize()
					self.statemachine.all_page_flushed()
					
