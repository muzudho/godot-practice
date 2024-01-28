# モデレーター（Moderator；司会進行）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 操作したボタン　（変数を増やしたくないのでレバーは＋１０００して入れる）
var button_number = -1

# 起動直後に　レバーが入った状態で始まることがあるから、１秒ぐらい無視するためのカウンター
var counter_of_wait = 0.0

# キーコンフィグのキーの数に対応
var key_config_item_number = 0


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# その他
# ーーーーーーーー

# ボタンが重複するか？
func is_key_duplicated(button_number_1):
	return button_number_1 in self.monkey().owner_key_config_node().key_config.values()


# キャンセルボタン押下か？
func is_cancel_button_pressed(button_number_1):
	if not (&"VK_Cancel" in self.monkey().owner_key_config_node().key_config):
		return false
	
	return button_number_1 == self.monkey().owner_key_config_node().key_config[&"VK_Cancel"]


func clear_count_by_step():
	self.counter_of_wait = 0.0
	self.button_number = -1
	

func on_step_regular(
		delta,
		previous_virtual_key_name,
		virtual_key_name):
	
	# 起動直後に　レバーが入った状態で始まることがあるから、最初は、入力を数フレーム無視するウェイトから始めること
	if self.monkey().statemachine().state == &"IntervalUntilPrompt":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return
			
		self.monkey().statemachine().go_prompt()
		return

	elif self.monkey().statemachine().state == &"Prompt":
		# プロンプト表示
		self.monkey().display().set_press_message_to_button(self.key_config_item_number)
		self.monkey().statemachine().wait_before_input()
		return
		
	elif self.monkey().statemachine().state == &"IntervalUntilInput":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return

		# 最終ステップ＋１の時、完了
		if self.key_config_item_number == 8:
			# 完了メッセージを見せるために、効果音とも併せて、少し長めに
			if self.counter_of_wait < 1.5:
				self.counter_of_wait += delta
				return
			
			# キー・コンフィグ画面を終了
			self.monkey().statemachine().exit()

			self.clear_count_by_step()			
			self.monkey().display().on_exit()
			return

		self.monkey().statemachine().state = &"WaitingForInput"
		self.clear_count_by_step()
		return

	elif self.monkey().statemachine().state == &"InputOk":
		# キャンセルボタン押下時は、１つか、２つ戻す
		if self.is_cancel_button_pressed(self.button_number):
			self.monkey().display().set_key_canceled()
			
			self.monkey().statemachine().wait_before_input()
			self.monkey().display().set_empty_the_button_message(self.key_config_item_number)
			
			self.key_config_item_number -= 1
			# さらに連続して戻したいケースもある
			# レバーの上
			if self.key_config_item_number == 5 and self.monkey().owner_key_config_node().key_config[&"VK_Down"] == self.monkey().owner_key_config_node().key_config[&"VK_Up"]:
				self.monkey().display().set_empty_the_button_message(self.key_config_item_number)
				self.key_config_item_number -= 1
				self.monkey().owner_key_config_node().key_config.erase(&"VK_Down")
			# レバーの左
			elif self.key_config_item_number == 7 and self.monkey().owner_key_config_node().key_config[&"VK_Right"] == self.monkey().owner_key_config_node().key_config[&"VK_Left"]:
				self.monkey().display().set_empty_the_button_message(self.key_config_item_number)
				self.key_config_item_number -= 1
				self.monkey().owner_key_config_node().key_config.erase(&"VK_Right")
			
			self.monkey().display().set_press_message_to_button(self.key_config_item_number)
			
			if previous_virtual_key_name != null:
				self.monkey().owner_key_config_node().key_config.erase(previous_virtual_key_name)
			
			self.clear_count_by_step()
			return

		# 既存のキーと被る場合、やり直しさせる
		if self.is_key_duplicated(self.button_number):
			self.monkey().display().set_key_denied(1)
			self.monkey().statemachine().wait_before_input()
			self.clear_count_by_step()
			return
			
		# 決定
		self.monkey().display().set_key_accepted()
		self.monkey().display().set_done_message_the_button(self.key_config_item_number, self.button_number)
		self.monkey().owner_key_config_node().key_config[virtual_key_name] = self.button_number

		# レバーの下
		if self.key_config_item_number == 4:
			if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Down"]:
				# 軸を選択したなら、レバーの上の選択はスキップ
				self.monkey().owner_key_config_node().key_config[&"VK_Up"] = self.button_number
				self.monkey().display().set_done_message_the_button(self.key_config_item_number + 1, self.button_number)
				self.key_config_item_number += 2
			else:
				self.key_config_item_number += 1
		# レバーの右
		elif self.key_config_item_number == 6:
			if 1000 <= self.monkey().owner_key_config_node().key_config[&"VK_Right"]:
				# 軸を選択したなら、レバーの左の選択はスキップ
				self.monkey().owner_key_config_node().key_config[&"VK_Left"] = self.button_number
				self.monkey().display().set_done_message_the_button(self.key_config_item_number + 1, self.button_number)
				self.key_config_item_number += 2
			else:
				self.key_config_item_number += 1
		else:
			self.key_config_item_number += 1
		
		
		self.monkey().statemachine().state = &"IntervalUntilPrompt"
