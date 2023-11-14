# メッセージ・ウィンドウ（Message Window；伝言窓）
extends Sprite2D


# 状態機械
var statemachine_of_message_window = load("res://res_🍋scripts/🪑grayscale_🎬message_window/statemachines/message_window.gd").new()

var is_appear = true

# 選択肢カーソルの原点
var choices_cursor_origin_x = 0.0
var choices_cursor_origin_y = 0.0


# 監督取得
func get_director():
	return $"../../../../../Director"


# 助監取得
func get_assistant_director():
	return $"../../../../AssistantDirector"


func get_canvas_layer():
	var path = "../../../../MessageWindow_" + str(self.name)
	return self.get_node(path)


func get_text_block():
	var path = "../../../../MessageWindow_" + str(self.name) + "/TextBlock"
	return self.get_node(path)


func get_choice_cursor():
	var path = "../../../../MessageWindow_" + str(self.name) + "/TextBlock/ChoiceCursor"
	return self.get_node(path)


# 先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1)

	#print("［伝言窓］　head：　[" + head + "]")
	#print("［伝言窓］　tail：　[" + tail + "]")

	return [head, tail]


func reset_cursor_position():
	self.get_choice_cursor().reset_cursor_position()


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():

		var snapshot = self.get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　プロセッシング：" + str(is_process))

		self.set_process(is_process)

		# 子ノード
		for child in self.get_text_block().get_children():
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

		var snapshot = self.get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　可視性：" + str(visible_flag))

		self.visible = visible_flag
		self.get_canvas_layer().visible = visible_flag

		# 子ノード
		for child in self.get_text_block().get_children():
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

		var snapshot = self.get_director().get_current_snapshot()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　appear：" + str(appear_flag))

		self.is_appear = appear_flag

		if self.is_appear:
			# 画面内に戻す
			self.position += Vector2(0, -720)
			self.get_text_block().position += Vector2(0, -720)

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
			self.get_text_block().position -= Vector2(0, -720)

		# 子ノード
		for child in self.get_text_block().get_children():
			if child.has_method("set_appear_subtree"):
				child.set_appear_subtree(appear_flag)


# 仮想キー入力時
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 選択肢カーソル
	self.get_canvas_layer().get_node("TextBlock/ChoiceCursor").on_virtual_key_input(virtual_key, lever_value, vk_operation)

	if virtual_key == &"VK_FastForward":
		# メッセージの早送りを有効にする（トグル式にすると、戻し方が分からんとかになる）
		if vk_operation == &"VKO_Pressed":
			self.get_director().is_fast_forward = true

		elif vk_operation == &"VKO_Released":
			self.get_director().is_fast_forward = false

	var snapshot = self.get_director().get_current_snapshot()

	# 完全表示中
	if self.statemachine_of_message_window.is_completed():

		# 選択肢モードなら
		if snapshot.is_choices():
			
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

	var snapshot = self.get_director().get_current_snapshot()

	# テキストブロック
	var text_block_node = self.get_text_block()

	# 選択肢なら
	if snapshot.is_choices():
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選択肢開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.think()
	
	else:
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　台詞開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.think()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.think()


# ページ送り
func on_page_forward():
	var snapshot = self.get_director().get_current_snapshot()

	# 選択肢モードなら
	if snapshot.is_choices():

		# カーソル音
		self.get_assistant_director().get_node("Se").play_se("🔔選択肢確定音")

		var row_number = snapshot.get_row_number_of_choices()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選んだ選択肢行番号：［" + str(row_number) + "］")

		# 選択肢の行番号を、上位ノードへエスカレーションします
		self.get_assistant_director().on_choice_selected(row_number)

		# 選択肢はお役御免
		snapshot.choices_row_numbers = null
		
	else:
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　ページ送り")

		# 効果音
		self.get_assistant_director().get_node("Se").play_se("🔔ページめくり音")
		
		# パースを開始してよい
		self.get_director().get_current_snapshot().set_parse_lock(false)

	# 空っぽのウィンドウを残して、次の指示を待ちます
	# テキストブロック
	var text_block_node = self.get_text_block()
	if true:
		# テキストが空っぽ
		text_block_node.text = ""
		# 全てのブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()


func on_all_characters_pushed():
	var snapshot = self.get_director().get_current_snapshot()

	# テキストブロック
	var text_block_node = self.get_text_block()
	# 選択肢
	if snapshot.is_choices():
		# 文末ブリンカー	状態機械［考える］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.think()

	# それ以外
	else:
		# 文末ブリンカー	状態機械［考える］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.think()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.think()


# 初期化
#	ウィンドウが存在しない状態に戻します
func on_all_pages_flushed():
	var snapshot = self.get_director().get_current_snapshot()
	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　オン・オール・ページズ・フィニッシュド］（非表示）")

	# テキストブロック
	var text_block_node = self.get_text_block()
	# テキストが空っぽ
	text_block_node.text = ""

	# 選択肢
	if snapshot.is_choices():
		# 全てのブリンカー　状態機械［決めた］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()
	else:
		# 全てのブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()

	# この要素の初期状態は、非表示、透明
	self.set_visible_subtree(false)
	self.modulate.a = 0.0	# 初期化による透明化


func _ready():
	
	# 最初は、テスト用文字列が入ってたりするので消す
	self.get_text_block().text = ""
	
	# 状態機械のセットアップ
	self.statemachine_of_message_window.on_talked_2 = self.on_talked_2
	self.statemachine_of_message_window.on_page_forward = self.on_page_forward
	self.statemachine_of_message_window.on_all_characters_pushed = self.on_all_characters_pushed
	self.statemachine_of_message_window.on_all_pages_flushed = self.on_all_pages_flushed

	# 選択肢カーソルの初期位置を記憶
	self.choices_cursor_origin_x = self.get_choice_cursor().get_transform().x.x # Vector To Scalar
	self.choices_cursor_origin_y = self.get_choice_cursor().get_transform().y.y


func _process(delta):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# 伝言窓が存在しないなら、働かない
	if self.statemachine_of_message_window.is_none():
		return

	# タイプライター風表示中
	if self.statemachine_of_message_window.is_typewriter():

		var snapshot = self.get_director().get_current_snapshot()

		snapshot.count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 1 / snapshot.msg_speed	# 旧 0.05
	
		# メッセージの早送り
		if self.get_director().is_fast_forward:
			# print("［テキストブロック］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　メッセージの早送り")
			wait_time = 1 / (snapshot.msg_speed * snapshot.msg_speed) # 旧 0.01
	
		if wait_time <= snapshot.count_of_typewriter:

			# TODO キャッシュ化したい
			# テキストブロック
			var text_block_node = self.get_text_block()

			if 0 < snapshot.text_block_buffer.length():
				# バッファーの先頭の１文字を切り取って、テキストブロックへ移動
				text_block_node.text += snapshot.text_block_buffer.substr(0, 1)
				snapshot.text_block_buffer = snapshot.text_block_buffer.substr(1)
			else:
				# 完全表示中
				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　プロセス　完全表示中だ")
				self.statemachine_of_message_window.all_characters_pushed()
			
			snapshot.count_of_typewriter -= wait_time
