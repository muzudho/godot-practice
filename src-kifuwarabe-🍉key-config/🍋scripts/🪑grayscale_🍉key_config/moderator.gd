# モデレーター（Moderator；司会進行）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー

func clear_count_by_step():
	self.monkey().internal().counter_of_wait = 0.0
	self.monkey().internal().button_number = -1
	

# 時計の動き
func on_tick(
		delta,
		previous_virtual_key_name,
		virtual_key_name):
	self.monkey().internal().previous_virtual_key_name = previous_virtual_key_name
	self.monkey().internal().virtual_key_name = virtual_key_name
	
	# 起動直後に　レバーが入った状態で始まることがあるから、最初は、入力を数フレーム無視するウェイトから始めること
	if self.monkey().statemachine().state == &"IntervalUntilPrompt":
		if self.monkey().internal().counter_of_wait < 0.5:
			self.monkey().internal().counter_of_wait += delta
			return
			
		self.monkey().statemachine().go_prompt()
		return

	# プロンプト表示
	elif self.monkey().statemachine().state == &"Prompt":
		self.monkey().statemachine().try_inputting_again(&"AfterInterval")
		return
		
	elif self.monkey().statemachine().state == &"IntervalUntilInput":
		if self.monkey().internal().counter_of_wait < 0.5:
			self.monkey().internal().counter_of_wait += delta
			return

		# 最終ステップ＋１の時、完了
		if self.monkey().internal().key_config_item_number == 8:
			# 完了メッセージを見せるために、効果音とも併せて、少し長めに
			if self.monkey().internal().counter_of_wait < 1.5:
				self.monkey().internal().counter_of_wait += delta
				return
			
			# キー・コンフィグ画面を終了
			self.monkey().statemachine().exit()
			return

		self.monkey().statemachine().go_input()
		return

	elif self.monkey().statemachine().state == &"InputOk":
		# キャンセルボタン押下時
		if self.monkey().owner_key_config_node().is_cancel_button_pressed(self.monkey().internal().button_number):
			self.monkey().statemachine().try_inputting_again(&"CancelButtonPushed")
			return

		# 既存のキーと被る場合、やり直しさせる
		if self.monkey().owner_key_config_node().is_key_duplicated(self.monkey().internal().button_number):
			self.monkey().statemachine().try_inputting_again(&"KeyDuplicated")
			return
		
		# 入力を受け付けた
		self.monkey().statemachine().input_accepted()
