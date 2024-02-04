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

# ディレクターの `_process(delta)` が呼出す
func on_process(delta):

	# ト書きで指定したスリープ値が残っている間は、シナリオを進めません
	if 0.0 < self.monkey().of_staff().programmer().owner_node().sleep_seconds:
		self.monkey().of_staff().programmer().owner_node().sleep_seconds -= delta
		return

	# デパートメント・オブジェクト
	var department_obj = self.monkey().owner_node().get_current_department_value()
	
	# メッセージ・ウィンドウ・オブジェクト
	var message_window_gui = self.monkey().get_current_message_window_gui()

	# シナリオのパースを開始してよいか？（ここで待機しないと、一瞬で全部消化してしまう）
	if not department_obj.is_parse_lock():
		
		# 段落がまだ残っているなら
		if message_window_gui.paragraph_item_index < self.monkey().scenario_helper_node().get_current_paragraph_array_size():
		
			var scenario_book = ScenarioBookshelf.get_scenario_book_that_document_merged(
					department_obj.name,
					self.monkey().of_staff().scenario_writer().owner_node())

			# その段落配列の次のテキストブロックを取得
			var text_block = self.monkey().scenario_helper_node().get_current_text_block(scenario_book)

			# カウントアップ
			message_window_gui.paragraph_item_index += 1
			
			# 段落が文字列
			if text_block is String:
				
				var latest_message = text_block + ""	# 文字列を参照ではなく、コピーしたい

				# ここで、命令と、台詞は区別する
				self.monkey().parser_for_text_block_node().parse_text_block(latest_message)
			
			# 段落が匿名関数かもしれない
			else:
				print("［助監］　TODO 匿名関数かもしれない呼出してみよ")
				text_block.call()	# このテキストブロックは、文字列ではなく、匿名関数のはず

		# 段落は、もう無いよ
		else:
			if not self.monkey().get_current_message_window_gui().statemachine_of_message_window.is_none():
				# 伝言窓を閉じる
				self.monkey().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()
