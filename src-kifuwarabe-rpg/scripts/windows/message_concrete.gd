#	コンクリート・メッセージ・ウィンドウ（Concrete Message Window；具体的な伝言窓）
extends Sprite2D


#	状態機械
var statemachine_of_message_window = load("res://scripts/statemachines/message_window.gd").new()


#	アシスタント・ディレクターを取得
func get_assistant_director():
	return $"../../../AssistantDirector"


#	音楽家を取得
func get_musician():
	return $"../../../Musician"


func get_snapshot(department_node_name):
	return $"../../../System/Snapshots".get_node(department_node_name)


#	メッセージ出力先ウィンドウ変更。ノード名を指定
func redirect_me():

	# 全ての文字は吐き出されたものとする
	self.statemachine_of_message_window.all_pages_flushed()

	print("［メッセージウィンドウ　”" + self.name + "”］　リダイレクトしてきた")
	
	# 新しいウィンドウ
	self.get_snapshot("VisualNovelDepartment").message_window_name_obj = self.name # StringName 型。 String ではない


#	次の指示を待ちます
func awaiting_order():
	#	メッセージウィンドウは指示待ちだ
	self.get_assistant_director().get_snapshot("VisualNovelDepartment").is_message_window_waiting_for_order = true


#	先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	#	最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［メッセージ・ウィンドウ］　head：　[" + head + "]")
	# print("［メッセージ・ウィンドウ］　tail：　[" + tail + "]")
	return [head, tail]


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool
	
	print("［メッセージウィンドウ　”" + self.name + "”］　プロセッシング：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード
		for child in $"CanvasLayer/TextBlock".get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


#	サブツリーの visible を設定
func set_visible_subtree(
	is_visible):					# bool
	
	print("［メッセージウィンドウ　”" + self.name + "”］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in $"CanvasLayer/TextBlock".get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)


#	テキストボックスなどにフォーカスが無いときの入力を拾う
func on_unhandled_key_input(event):
	print("［メッセージウィンドウ　”" + self.name + "”］　アンハンドルド・キー入力")

	#	完全表示中
	if self.statemachine_of_message_window.is_completed():

		#	選択肢モードなら
		if self.get_snapshot("VisualNovelDepartment").is_choice_mode:
			
			#	何かキーを押したとき
			if event.is_pressed():
				
				#	確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					# print("［抽象メッセージ・ウィンドウ］　選択肢モードでは、エンターキー以外ではメッセージ送りしません")
					return
					
				else:
					#	選択肢を確定した
					#	ページ送り
					self.statemachine_of_message_window.page_forward()
					return
		
		#	それ以外なら
		else:
		
			#	何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					# print("［抽象メッセージ・ウィンドウ］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
				
				#	ページ送り
				self.statemachine_of_message_window.page_forward()


#	メッセージ追加
func on_talk(
	new_text,						# str
	choices_row_numbers = null):	# number_array

	#	空っぽのウィンドウを残します
	#	テキストブロック
	var text_block_node = self.get_node("CanvasLayer/TextBlock")
	if true:
		#		テキストが空っぽ
		text_block_node.text = ""
		#		表示
		text_block_node.show()

	#	表示
	self.show()
	self.get_node("CanvasLayer").show()
	self.modulate.a = 1.0	# メッセージ追加による不透明化


	#	テキスト設定
	self.get_snapshot("VisualNovelDepartment").text_block_buffer = new_text

	#	選択肢なら
	if choices_row_numbers != null:
		print("［メッセージウィンドウ　”" + self.name + "”］　選択肢：[" + new_text + "]")

		var snapshot = self.get_snapshot("VisualNovelDepartment")
		if true:
			snapshot.is_choice_mode = true
			snapshot.choice_row_numbers = choices_row_numbers

		#	テキストブロック
		if true:
			# メッセージエンド・ブリンカー　状態機械［決めた］
			text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
			text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
			
			# メッセージエンド・ブリンカー　状態機械［考える］
			text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.think()

	#	それ以外なら
	else:
		print("［メッセージウィンドウ　”" + self.name + "”］　台詞：[" + new_text + "]")

		var snapshot = self.get_snapshot("VisualNovelDepartment")
		if true:
			snapshot.is_choice_mode = false
			snapshot.choice_row_numbers = []

		#	テキストブロック
		if true:
			# メッセージエンド・ブリンカー　状態機械［決めた］
			text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()
			
			# メッセージエンド・ブリンカー　状態機械［考える］
			text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.think()
			text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.think()


#	ページ送り
func on_page_forward():
	#	選択肢モードなら
	if self.get_snapshot("VisualNovelDepartment").is_choice_mode:

		#	カーソル音
		self.get_musician().playSe("選択肢確定音")

		var row_number = self.get_node("CanvasLayer/TextBlock/ChoiceCursor").selected_row_number	
		print("［メッセージウィンドウ　”" + self.name + "”］　選んだ選択肢行番号：［" + str(row_number) + "］")

		#	選択肢の行番号を、上位ノードへエスカレーションします
		self.get_assistant_director().on_choice_selected(row_number)
		
	else:	
		print("［メッセージウィンドウ　”" + self.name + "”］　ページ送り")

		#	効果音
		self.get_musician().playSe("ページめくり音")
		
		self.awaiting_order()

	#	空っぽのウィンドウを残して、次の指示を待ちます
	#	テキストブロック
	var text_block_node = self.get_node("CanvasLayer/TextBlock")
	if true:
		#		テキストが空っぽ
		text_block_node.text = ""
		#		全てのブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()


func on_all_characters_pushed():
	#	テキストブロック
	var text_block_node = self.get_node("CanvasLayer/TextBlock")
	#		エンド・オブ・メッセージ・ブリンカー	状態機械［考える］
	#
	#			選択肢
	if self.get_snapshot("VisualNovelDepartment").is_choice_mode:
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.think()

	#			それ以外
	else:
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.think()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.think()


#	初期化
#		ウィンドウが存在しない状態に戻します
func on_all_pages_flushed():
	print("［メッセージ・ウィンドウ　”" + self.name + "”］　オン・オール・ページズ・フィニッシュド］（非表示）")

	#	テキストブロック
	var text_block_node = self.get_node("CanvasLayer/TextBlock")
	if true:
		#		テキストが空っぽ
		text_block_node.text = ""
		#		全てのブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()
		#		非表示
		text_block_node.hide()

	#	この要素の初期状態は、非表示、透明
	self.hide()
	self.modulate.a = 0.0	# 初期化による透明化


func _ready():
	#	状態機械のセットアップ
	self.statemachine_of_message_window.on_talk = self.on_talk
	self.statemachine_of_message_window.on_page_forward = self.on_page_forward
	self.statemachine_of_message_window.on_all_characters_pushed = self.on_all_characters_pushed
	self.statemachine_of_message_window.on_all_pages_flushed = self.on_all_pages_flushed

	#	最初は非表示
	self.hide()


func _process(delta):

	#	メッセージ・ウィンドウが存在しないなら、働かない
	if self.statemachine_of_message_window.is_none():
		pass

	#	タイプライター風表示中
	elif self.statemachine_of_message_window.is_typewriter():

		self.get_snapshot("VisualNovelDepartment").count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 0.05
	
		# メッセージの早送り
		if Input.is_key_pressed(KEY_R):
			# print("［テキストブロック］　メッセージの早送り")
			wait_time = 0.01
	
		if wait_time <= self.get_snapshot("VisualNovelDepartment").count_of_typewriter:

			#	TODO キャッシュ化したい
			#	テキストブロック
			var text_block_node = self.get_node("CanvasLayer/TextBlock")

			if 0 < self.get_snapshot("VisualNovelDepartment").text_block_buffer.length():
				# １文字追加
				text_block_node.text += self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(0, 1)
				self.get_snapshot("VisualNovelDepartment").text_block_buffer = self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(1, self.get_snapshot("VisualNovelDepartment").text_block_buffer.length()-1)
			else:
				# 完全表示中
				self.statemachine_of_message_window.all_characters_pushed()
			
			self.get_snapshot("VisualNovelDepartment").count_of_typewriter -= wait_time