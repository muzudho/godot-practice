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

var previous_virtual_key_name = &""
var virtual_key_name = &""


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
	self.previous_virtual_key_name = previous_virtual_key_name
	self.virtual_key_name = virtual_key_name
	
	# 起動直後に　レバーが入った状態で始まることがあるから、最初は、入力を数フレーム無視するウェイトから始めること
	if self.monkey().statemachine().state == &"IntervalUntilPrompt":
		if self.counter_of_wait < 0.5:
			self.counter_of_wait += delta
			return
			
		self.monkey().statemachine().go_prompt()
		return

	elif self.monkey().statemachine().state == &"Prompt":
		# プロンプト表示
		self.monkey().statemachine().wait_before_input(&"AfterInterval")
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
			return

		self.monkey().statemachine().go_input()
		return

	elif self.monkey().statemachine().state == &"InputOk":
		# キャンセルボタン押下時
		if self.is_cancel_button_pressed(self.button_number):
			self.monkey().statemachine().wait_before_input(&"CancelButtonPushed")
			return

		# 既存のキーと被る場合、やり直しさせる
		if self.is_key_duplicated(self.button_number):
			self.monkey().statemachine().wait_before_input(&"KeyDuplicated")
			return
		
		# 入力を受け付けた
		self.monkey().statemachine().input_accepted()
