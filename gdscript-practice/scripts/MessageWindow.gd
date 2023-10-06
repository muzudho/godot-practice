# メッセージ・ウィンドウ（Message Window）
extends Node

# 状態遷移機械
var statemachine = load("scripts/MessageWindowStatemachine.gd").new()
var scenario_array = []


# シナリオ・データ設定
func set_scenario_array(scenario_array):
	print("［メッセージ・ウィンドウ］　シナリオ・データを受け取った")
	self.scenario_array = scenario_array

	# ウィンドウを空っぽにして、次のメッセージを待ちます
	self.clear_and_receive()

	# 次に表示するべきメッセージを取得
	var latest_message = self.scenario_array.pop_front()

	# メッセージを追加
	self.push_message(latest_message)

	# タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()


# ウィンドウを空っぽにして、次のメッセージを待ちます
func clear_and_receive():
	$"TextBlock".text = ""

# 次に表示するべきメッセージを取得
func fetch_message():
	return self.scenario_array.pop_front()

# メッセージを追加
func push_message(temp_text):
	# 先頭行の最初と、最終行の最後の表示されない文字を消去
	temp_text = temp_text.strip_edges()
	
	# print("［テキストブロック］　台詞はまだあるよ")
	print("［テキストブロック］　台詞はまだあるよ。テキスト：　[" + temp_text + "]")

	
	# 選択肢かどうか判定
	if temp_text.begins_with("!choice "):
		print("［テキストブロック］　選択肢だ")
		$"TextBlock".is_choice_mode = true
		
		# じゃあ、先頭行は省きたい
		var index = temp_text.find("\n")
		print(index)
		var head = temp_text.substr(0, index)
		var tail = temp_text.substr(index+1, temp_text.length() - (index+1))
		# print("［テキストブロック］　head：　[" + head + "]")
		# print("［テキストブロック］　tail：　[" + tail + "]")

		# head
		var csv = head.substr(8, head.length()-8)
		# TODO 昇順であること
		var string_packed_array = csv.split(",", true, 0)
		var size = string_packed_array.size()
		# print("［テキストブロック］　選択肢サイズ：" + str(size))
		
		# 文字列型を数値型に変換
		$"TextBlock".choice_row_numbers = []
		$"TextBlock".choice_row_numbers.resize(size)
		# print("［テキストブロック］　行番号一覧")
		for i in range(0, size):
			$"TextBlock".choice_row_numbers[i] = string_packed_array[i].to_int()
			# print(self.choice_row_numbers[i])
					
		# tail
		temp_text = tail
	else:
		# print("［テキストブロック］　選択肢ではない")
		$"TextBlock".is_choice_mode = false
		$"TextBlock".choice_row_numbers = []
	
	$"TextBlock".text_buffer = temp_text


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

# テキストボックスなどにフォーカスが無いときの入力を拾う
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
				
				if 0 < self.scenario_array.size():
					# まだあるよ

					# ウィンドウを空っぽにして、次のメッセージを待ちます
					self.clear_and_receive()

					# 次に表示するべきメッセージを取得
					var latest_message = self.scenario_array.pop_front()

					# メッセージを追加
					self.push_message(latest_message)
					
					# タイプライター風表示へ状態遷移
					self.statemachine.page_forward()
					
				else:
					# 出すメッセージが無ければ、メッセージ・ウィンドウを閉じる
					$"TextBlock".initialize()
					self.statemachine.all_page_flushed()
					
