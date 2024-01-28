# クロック（Clock；時計）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 時計
# ーーーーーーーー

func on_process(delta):

	# 状態遷移機械が止まっていれば、入力も無視します
	if self.monkey().statemachine().is_terminated():
		return
	
	if not (self.monkey().statemachine().state in [&"IntervalUntilPrompt", &"Prompt", &"IntervalUntilInput", &"InputOk"]):
		return
	
	# 初回
	if self.monkey().internal().key_config_item_number == 0:
		# 画面の表示、演奏
		self.monkey().display().perform_at_open_scene()
		self.monkey().internal().key_config_item_number += 1
		self.monkey().internal().clear_count_by_step()
	
	# ーーーーーーーー
	# （１）キャンセルボタン、メニューボタン
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 1:
		self.on_tick(
				delta,
				null,
				&"VK_Cancel")
	
	# ーーーーーーーー
	# （２）決定ボタン、メッセージ送りボタン
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 2:
		self.on_tick(
				delta,
				&"VK_Cancel",
				&"VK_Ok")
		
	# ーーーーーーーー
	# （３）メッセージ早送りボタン
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 3:
		self.on_tick(
				delta,
				&"VK_Ok",
				&"VK_FastForward")
		
	# ーーーーーーーー
	# （４）レバーの下
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 4:
		self.on_tick(
				delta,
				&"VK_FastForward",
				&"VK_Down")
		
	# ーーーーーーーー
	# （５）レバーの上
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 5:
		self.on_tick(
				delta,
				&"VK_Down",
				&"VK_Up")
		
	# ーーーーーーーー
	# （６）レバーの右
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 6:
		self.on_tick(
				delta,
				&"VK_Up",
				&"VK_Right")
		
	# ーーーーーーーー
	# （７）レバーの左
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 7:
		self.on_tick(
				delta,
				&"VK_Right",
				&"VK_Left")
	
	# ーーーーーーーー
	# 完了
	# ーーーーーーーー
	elif self.monkey().internal().key_config_item_number == 8:
		self.on_tick(
				delta,
				&"VK_Left",
				null)


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
