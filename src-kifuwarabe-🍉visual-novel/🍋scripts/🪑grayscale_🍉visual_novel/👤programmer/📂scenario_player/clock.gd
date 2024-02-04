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
	var department_value = self.monkey().owner_node().get_current_department_value()
	
	# メッセージ・ウィンドウ・オブジェクト
	var message_window_gui = self.monkey().get_current_message_window_gui()

	# シナリオのパースを開始してよいか？（ここで待機しないと、一瞬で全部消化してしまう）
	if not department_value.is_parse_lock():
		
		# セクションがまだ残っているなら
		if message_window_gui.section_item_index < self.monkey().scenario_helper_node().get_current_section_size_of_scenario():
		
			# そのセクションの次のパラグラフを取得
			var paragraph = self.monkey().owner_node().get_current_paragraph_of_scenario()

			# カウントアップ
			message_window_gui.section_item_index += 1
			
			# 段落が文字列
			if paragraph is String:
				
				var latest_message = paragraph + ""	# 文字列を参照ではなく、コピーしたい

				# ここで、命令と、台詞は区別する
				self.monkey().parser_for_paragraph_node().parse_paragraph(latest_message)
			
			# 段落が匿名関数かもしれない
			else:
				print("［助監］　TODO 匿名関数かもしれない呼出してみよ")
				paragraph.call()

		# セクションは、もう無いよ
		else:
			if not self.monkey().get_current_message_window_gui().statemachine_of_message_window.is_none():
				# 伝言窓を閉じる
				self.monkey().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()
