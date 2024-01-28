# ステートマシン・ビヘイビア（Statemachine Behaviour；状態遷移機械の振る舞い）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー


func _ready():
	self.monkey().statemachine().behaviour_of_entry = behaviour_of_entry
	self.monkey().statemachine().behaviour_of_exit = behaviour_of_exit
	self.monkey().statemachine().behaviour_of_try_inputting_again = behaviour_of_try_inputting_again


# ーーーーーーーー
# イベントハンドラ
# ーーーーーーーー

# 開始時の振る舞い
func behaviour_of_entry():
	# ローカルのプログラマー・ノードへアクセス
	self.monkey().the_programmer_node().on_key_config_entered()


# 終了時の振る舞い
func behaviour_of_exit():
	self.monkey().moderator().clear_count_by_step()
	
	# 画面表示、演奏
	self.monkey().display().on_exit()

	# キーコンフィグ呼出し元
	self.monkey().owner_key_config_node().on_exit()


# 入力に再挑戦
func behaviour_of_try_inputting_again(reason):
	# キャンセル・ボタン押下後、再入力
	if reason == &"CancelButtonPushed":
		# キー・コンフィグ項目を、１つか、２つ（レバー時）戻す
		self.monkey().display().on_cancel_button_pushed()
		self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)

		self.monkey().moderator().key_config_item_number -= 1
		# さらに連続して戻したいケースもある
		# レバーの上
		if self.monkey().moderator().key_config_item_number == 5 and self.monkey().owner_key_config_node().key_config[&"VK_Down"] == self.monkey().owner_key_config_node().key_config[&"VK_Up"]:
			self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)
			self.monkey().moderator().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Down")
		# レバーの左
		elif self.monkey().moderator().key_config_item_number == 7 and self.monkey().owner_key_config_node().key_config[&"VK_Right"] == self.monkey().owner_key_config_node().key_config[&"VK_Left"]:
			self.monkey().display().set_empty_the_button_message(self.monkey().moderator().key_config_item_number)
			self.monkey().moderator().key_config_item_number -= 1
			self.monkey().owner_key_config_node().key_config.erase(&"VK_Right")
		
		self.monkey().display().set_press_message_to_button(self.monkey().moderator().key_config_item_number)
		
		if self.monkey().moderator().previous_virtual_key_name != null:
			self.monkey().owner_key_config_node().key_config.erase(self.monkey().moderator().previous_virtual_key_name)
		
		self.monkey().moderator().clear_count_by_step()

	# 既存のキーと被って、再入力
	elif reason == &"KeyDuplicated":
		self.monkey().display().on_pushed_button_denied(1)
		self.monkey().moderator().clear_count_by_step()
	
	# インターバル後
	elif reason == &"AfterInterval":
		self.monkey().display().set_press_message_to_button(self.monkey().moderator().key_config_item_number)

	# 下キーがボタンなら、上ボタンも再入力
	elif reason == &"SelectUpButton":
		self.monkey().display().on_pushed_button_denied(2)

	# 右キーがボタンなら、左ボタンも再入力
	elif reason == &"SelectLeftButton":
		self.monkey().display().on_pushed_button_denied(3)

	else:
		print("［キーコンフィグ］　▲！　エラー　reason:" + reason)
