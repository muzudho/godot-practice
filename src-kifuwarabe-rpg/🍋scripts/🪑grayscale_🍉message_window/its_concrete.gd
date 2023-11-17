# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・コンクリート（Its concrete；その具体的な）
extends AbstractMessageWindow


# メッセージ・ウィンドウの軸取得
func get_pibot():
	return $"../../MessageWindows"


func _ready():
	
	# 最初は、テスト用文字列が入ってたりするので消す
	self.get_pibot().get_text_block(self.name).text = ""
	
	# 状態機械のセットアップ
	self.statemachine_of_message_window.on_talked_2 = self.on_talked_2
	self.statemachine_of_message_window.on_page_forward = self.on_page_forward
	self.statemachine_of_message_window.on_all_characters_pushed = self.on_all_characters_pushed
	self.statemachine_of_message_window.on_all_pages_flushed = self.on_all_pages_flushed

	# 選択肢カーソルの初期位置を記憶
	self.choices_cursor_origin_x = self.get_pibot().get_choices_cursor(self.name).get_transform().x.x # Vector To Scalar
	self.choices_cursor_origin_y = self.get_pibot().get_choices_cursor(self.name).get_transform().y.y


func _process(delta):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# 伝言窓が存在しないなら、働かない
	if self.statemachine_of_message_window.is_none():
		return

	# タイプライター風表示中
	if self.statemachine_of_message_window.is_typewriter():

		var snapshot = self.get_pibot().get_director().get_current_snapshot()
		var message_window_a = snapshot.message_window

		message_window_a.count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 1 / message_window_a.msg_speed	# 旧 0.05
	
		# メッセージの早送り
		if self.get_pibot().get_director().is_fast_forward:
			# print("［テキストブロック］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　メッセージの早送り")
			wait_time = 1 / (message_window_a.msg_speed * message_window_a.msg_speed) # 旧 0.01
	
		if wait_time <= message_window_a.count_of_typewriter:

			# TODO キャッシュ化したい
			# テキストブロック
			var text_block_node = self.get_pibot().get_text_block(self.name)

			if 0 < message_window_a.text_block_buffer.length():
				# バッファーの先頭の１文字を切り取って、テキストブロックへ移動
				text_block_node.text += message_window_a.pop_head_of_text_block()
			else:
				# 完全表示中
				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　プロセス　完全表示中だ")
				self.statemachine_of_message_window.all_characters_pushed()
			
			message_window_a.count_of_typewriter -= wait_time
