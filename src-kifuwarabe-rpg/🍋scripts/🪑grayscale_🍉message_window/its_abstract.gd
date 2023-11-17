# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・アブストラクト（Its abstract；その抽象的な）
extends Sprite2D


class_name AbstractMessageWindow


# 状態機械
var statemachine_of_message_window = load("res://🍋scripts/🪑grayscale_🍉message_window/statemachines/message_window.gd").new()

# 可視性
var is_appear = true

# 選択肢カーソルの原点
var choices_cursor_origin_x = 0.0
var choices_cursor_origin_y = 0.0


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


# メッセージ・ウィンドウの軸取得
func get_pibot():
	pass


# 選択肢カーソル位置のリセット
func reset_cursor_position():
	self.get_pibot().get_choices_cursor(self.name).reset_cursor_position()


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():

		var snapshot = self.get_pibot().get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　プロセッシング：" + str(is_process))

		self.set_process(is_process)

		# 子ノード
		for child in self.get_pibot().get_text_block(self.name).get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


# サブツリーの visible を設定
func set_visible_subtree(
		visible_flag):			# bool

	print("［伝言窓　”" + self.name + "”］　現可視性：" + str(self.visible) + "　次可視性：" + str(visible_flag))

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if visible_flag != self.visible:

		var snapshot = self.get_pibot().get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　可視性：" + str(visible_flag))

		self.visible = visible_flag
		self.get_pibot().get_canvas_layer(self.name).visible = visible_flag

		# 子ノード
		for child in self.get_pibot().get_text_block(self.name).get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(visible_flag)


# サブツリーの appear を設定
func set_appear_subtree(
		appear_flag):		# bool

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if appear_flag != self.is_appear:

		var snapshot = self.get_pibot().get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　appear：" + str(appear_flag))

		self.is_appear = appear_flag

		if self.is_appear:
			# 画面内に戻す
			self.position += Vector2(0, -720)
			self.get_pibot().get_text_block(self.name).position += Vector2(0, -720)

			## 会話が停止してしまっているなら、再開する（すぐ停止するかもしれない）
			#if self.statemachine_of_message_window.is_none():
			#	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　伝言窓が消えてしまっているので、会話を再開する")
			#	#self.statemachine_of_message_window.talk()
			#
			#	# パースをする
			#	#snapshot.set_parse_lock(false)

		else:
			# 画面下の外に押し出す
			self.position += Vector2(0, 720)
			self.get_pibot().get_text_block(self.name).position -= Vector2(0, -720)

		# 子ノード
		for child in self.get_pibot().get_text_block(self.name).get_children():
			if child.has_method("set_appear_subtree"):
				child.set_appear_subtree(appear_flag)


# 仮想キー入力時
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 選択肢カーソル
	self.get_pibot().get_choices_cursor(self.name).on_virtual_key_input(virtual_key, lever_value, vk_operation)

	if virtual_key == &"VK_FastForward":
		# メッセージの早送りを有効にする（トグル式にすると、戻し方が分からんとかになる）
		if vk_operation == &"VKO_Pressed":
			self.get_pibot().get_director().is_fast_forward = true

		elif vk_operation == &"VKO_Released":
			self.get_pibot().get_director().is_fast_forward = false

	var snapshot = self.get_pibot().get_director().get_current_snapshot()
	var message_window_a = snapshot.message_window

	# 完全表示中
	if self.statemachine_of_message_window.is_completed():

		# 選択肢モードなら
		if message_window_a.is_choices():
			
			# 押下時
			if vk_operation == &"VKO_Pressed":
				
				# TODO カーソルの上下もここにくる？

				# 確定ボタン以外は無効
				if virtual_key != &"VK_Ok":
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキーではないのでメッセージ送りしません")
					return
					
				else:
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキー　ページ送りする")
					# 選択肢を確定した
					# ページ送り
					self.statemachine_of_message_window.page_forward()
					return

			else:
				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時ではない")
		
		# 通常テキストモードなら
		else:
			# 何かキーを押したとき
			if vk_operation == &"VKO_Pressed":
				
				# ページ早送りボタンは無効
				if virtual_key == &"VK_FastForward":
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキーでは、メッセージ送りしません")
					return

				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキー以外だ（" + virtual_key + "）　ページ送りする")
				# ページ送り
				self.statemachine_of_message_window.page_forward()

			else:
				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢ではない　押下時ではないから何もしない")
				pass

	else:
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　完全表示中ではないから何もしない")


# 状態遷移するだけ
func on_talked_2():

	# 表示
	self.set_visible_subtree(true)
	self.modulate.a = 1.0	# メッセージ追加による不透明化

	var snapshot = self.get_pibot().get_director().get_current_snapshot()
	var message_window_a = snapshot.message_window

	# 選択肢なら
	if message_window_a.is_choices():
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選択肢開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.get_pibot().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.get_pibot().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.get_pibot().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()
	
	else:
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　台詞開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.get_pibot().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.get_pibot().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.get_pibot().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# ページ送り
func on_page_forward():
	var snapshot = self.get_pibot().get_director().get_current_snapshot()
	var message_window_a = snapshot.message_window

	# 選択肢モードなら
	if message_window_a.is_choices():

		# カーソル音
		self.get_pibot().get_assistant_director().get_node("Se").play_se("🔔選択肢確定音")

		var row_number = message_window_a.get_row_number_of_choices()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選んだ選択肢行番号：［" + str(row_number) + "］")

		# 選択肢の行番号を、上位ノードへエスカレーションします
		self.get_pibot().get_assistant_director().on_choice_selected(row_number)

		# 選択肢はお役御免
		message_window_a.choices_row_numbers = null
		
	else:
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　ページ送り")

		# 効果音
		self.get_pibot().get_assistant_director().get_node("Se").play_se("🔔ページめくり音")
		
		# パースを開始してよい
		self.get_pibot().get_director().get_current_snapshot().set_parse_lock(false)

	# 空っぽのウィンドウを残して、次の指示を待ちます
	# テキストブロック
	var text_block_node = self.get_pibot().get_text_block(self.name)
	if true:
		# テキストが空っぽ
		text_block_node.text = ""
		# 全てのブリンカー　状態機械［決めた］
		self.get_pibot().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.get_pibot().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		self.get_pibot().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()


func on_all_characters_pushed():
	var snapshot = self.get_pibot().get_director().get_current_snapshot()
	var message_window_a = snapshot.message_window

	# 選択肢
	if message_window_a.is_choices():
		# 文末ブリンカー	状態機械［考える］
		self.get_pibot().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()

	# それ以外
	else:
		# 文末ブリンカー	状態機械［考える］
		self.get_pibot().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.get_pibot().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# 初期化
#	ウィンドウが存在しない状態に戻します
func on_all_pages_flushed():
	var snapshot = self.get_pibot().get_director().get_current_snapshot()
	var message_window_a = snapshot.message_window

	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　オン・オール・ページズ・フィニッシュド］（非表示）")

	# テキストブロック
	var text_block_node = self.get_pibot().get_text_block(self.name)
	# テキストが空っぽ
	text_block_node.text = ""

	# 選択肢
	if message_window_a.is_choices():
		# 全てのブリンカー　状態機械［決めた］
		self.get_pibot().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
	else:
		# 全てのブリンカー　状態機械［決めた］
		self.get_pibot().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.get_pibot().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()

	# この要素の初期状態は、非表示、透明
	self.set_visible_subtree(false)
	self.modulate.a = 0.0	# 初期化による透明化
