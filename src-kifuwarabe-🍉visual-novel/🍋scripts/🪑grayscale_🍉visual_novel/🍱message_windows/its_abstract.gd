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
