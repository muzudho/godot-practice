# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・アブストラクト（Its abstract；その抽象的な）
extends MessageWindowProgram


class_name AbstractMessageWindow


# ーーーーーーーー
# その他
# ーーーーーーーー


func _process(delta):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# 伝言窓が存在しないなら、働かない
	if self.statemachine_of_message_window.is_none():
		return

	# タイプライター風表示中
	if self.statemachine_of_message_window.is_typewriter():

		var message_window_gui = self.hub().get_programs_hub().get_current_message_window_gui()

		message_window_gui.count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 1 / self.msg_speed	# 旧 0.05
	
		# メッセージの早送り
		if self.hub().is_fast_forward:
			# print("［テキストブロック］　メッセージの早送り")
			wait_time = 1 / (self.msg_speed * self.msg_speed) # 旧 0.01
	
		if wait_time <= message_window_gui.count_of_typewriter:

			# TODO キャッシュ化したい
			# テキストブロック
			var text_block_node = self.hub().get_text_block(self.name)

			if 0 < message_window_gui.text_block_buffer.length():
				# バッファーの先頭の１文字を切り取って、テキストブロックへ移動
				text_block_node.text += message_window_gui.pop_head_of_text_block()
			else:
				# 完全表示中
				print("［伝言窓　”" + self.name + "”］　プロセス　完全表示中だ")
				self.statemachine_of_message_window.all_characters_pushed()
			
			message_window_gui.count_of_typewriter -= wait_time


# 選択肢カーソル位置のリセット
func reset_cursor_position():
	self.hub().get_choices_cursor(self.name).reset_cursor_position()


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():

		print("［伝言窓　”" + self.name + "”］　プロセッシング：" + str(is_process))

		self.set_process(is_process)

		# 子ノード
		for child in self.hub().get_text_block(self.name).get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


# サブツリーの appear を設定
func set_appear_subtree(
		appear_flag):		# bool

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if appear_flag != self.is_appear:

		print("［伝言窓　”" + self.name + "”］　appear：" + str(appear_flag))

		var illust_a = self.hub().get_programs_hub().get_illust(self.name)
		self.is_appear = appear_flag

		if self.is_appear:
			# 画面内に戻す
			illust_a.position += Vector2(0, -720)
			self.hub().get_text_block(self.name).position += Vector2(0, -720)

			## 会話が停止してしまっているなら、再開する（すぐ停止するかもしれない）
			#if self.statemachine_of_message_window.is_none():
			#	print("［伝言窓　”" + self.name + "”］　伝言窓が消えてしまっているので、会話を再開する")
			#	#self.statemachine_of_message_window.talk()
			#
			#	# パースをする
			#	#.set_parse_lock(false)

		else:
			# 画面下の外に押し出す
			illust_a.position += Vector2(0, 720)
			self.hub().get_text_block(self.name).position -= Vector2(0, -720)

		# 子ノード
		for child in self.hub().get_text_block(self.name).get_children():
			if child.has_method("set_appear_subtree"):
				child.set_appear_subtree(appear_flag)


# テキストブロックのバッファーが残っているか？
func has_text_block_buffer():
	return 0 < self.text_block_buffer.length()


# テキスト・ブロックの先頭１文字を切り取って返す
func pop_head_of_text_block():
	var head = self.text_block_buffer.substr(0, 1)
	self.text_block_buffer = self.text_block_buffer.substr(1)
	return head


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# 選択肢カーソルが指しているのは何行目か？　序数。該当がなければ 1 を返す
func get_row_number_of_choices():
	if self.choices_row_numbers == null:
		return 1

	return self.choices_row_numbers[self.choices_index]


# メッセージを記録するだけ
func remember(
		new_text):		# str

	# 設定
	self.text_block_buffer = new_text

	# 選択肢なら
	if self.is_choices():
		print("［部門スナップ写］　リメンバー　選択肢：[" + new_text + "]")

	# それ以外なら
	else:
		print("［部門スナップ写］　リメンバー　台詞：[" + new_text + "]")


# 仮想キー入力時
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 選択肢カーソル
	self.hub().get_choices_cursor(self.name).on_virtual_key_input(virtual_key, lever_value, vk_operation)

	if virtual_key == &"VK_FastForward":
		# メッセージの早送りを有効にする（トグル式にすると、戻し方が分からんとかになる）
		if vk_operation == &"VKO_Pressed":
			self.hub().is_fast_forward = true

		elif vk_operation == &"VKO_Released":
			self.hub().is_fast_forward = false

	# 完全表示中
	if self.statemachine_of_message_window.is_completed():

		# 選択肢モードなら
		if self.is_choices():
			
			# 押下時
			if vk_operation == &"VKO_Pressed":
				
				# TODO カーソルの上下もここにくる？

				# 確定ボタン以外は無効
				if virtual_key != &"VK_Ok":
					print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキーではないのでメッセージ送りしません")
					return
					
				else:
					print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキー　ページ送りする")
					# 選択肢を確定した
					# ページ送り
					self.statemachine_of_message_window.page_forward()
					return

			else:
				print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時ではない")
		
		# 通常テキストモードなら
		else:
			# 何かキーを押したとき
			if vk_operation == &"VKO_Pressed":
				
				# ページ早送りボタンは無効
				if virtual_key == &"VK_FastForward":
					print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキーでは、メッセージ送りしません")
					return

				print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキー以外だ（" + virtual_key + "）　ページ送りする")
				# ページ送り
				self.statemachine_of_message_window.page_forward()

			else:
				print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時ではないから何もしない")
				pass

	else:
		print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　完全表示中ではないから何もしない")
