# メッセージ・ウィンドウ（Message Window；伝言窓）
extends Sprite2D


# 状態機械
var statemachine_of_message_window = load("res://scripts/statemachines/message_window.gd").new()


# 関数の変数
var director_get_current_snapshot = null


var is_appear = true




# アシスタント・ディレクターを取得
func get_assistant_director():
	return $"../../../AssistantDirector"


# 音楽家を取得
func get_musician():
	return $"../../../Musician"


func get_canvas_layer():
	var canvas_layer_path = "../" + str(self.name) + "_CanvasLayer"
	var canvas_layer = self.get_node(canvas_layer_path)
	return canvas_layer


func get_text_block():
	var text_block_path = "../" + str(self.name) + "_CanvasLayer/TextBlock"
	var text_block = self.get_node(text_block_path)
	return text_block


func set_director_get_current_snapshot_subtree(it):
	self.director_get_current_snapshot = it

	# 子ノード
	for child in self.get_text_block().get_children():
		if child.has_method("set_director_get_current_snapshot_subtree"):
			child.set_director_get_current_snapshot_subtree(it)


# メッセージ出力先ウィンドウ変更。ノード名を指定
func redirect_me():

	# 全ての文字は吐き出されたものとする
	#self.statemachine_of_message_window.all_pages_flushed()

	var snapshot = self.director_get_current_snapshot.call()

	print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　リダイレクトしてきた")

	# 新しいウィンドウ
	snapshot.message_window_name_obj = self.name # StringName 型。 String ではない


# 先頭行と、それ以外に分けます
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	var head = text.substr(0, index)
	var tail = text.substr(index+1)

	#print("［伝言窓］　head：　[" + head + "]")
	#print("［伝言窓］　tail：　[" + tail + "]")

	return [head, tail]


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():

		var snapshot = self.director_get_current_snapshot.call()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　プロセッシング：" + str(is_process))

		self.set_process(is_process)

		# 子ノード
		for child in self.get_text_block().get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


# サブツリーの visible を設定
func set_visible_subtree(
	is_visible):					# bool

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:

		var snapshot = self.director_get_current_snapshot.call()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　可視性：" + str(is_visible))

		self.visible = is_visible
		self.get_canvas_layer().visible = is_visible

		# 子ノード
		for child in self.get_text_block().get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)


# サブツリーの appear を設定
func set_appear_subtree(
	is_appear):		# bool

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_appear != self.is_appear:

		var snapshot = self.director_get_current_snapshot.call()
		print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　appear：" + str(is_appear))

		self.is_appear = is_appear

		if self.is_appear:
			# 画面内に戻す
			self.position += Vector2(0, -720)
			self.get_text_block().position += Vector2(0, -720)

			## 会話が停止してしまっているなら、再開する（すぐ停止するかもしれない）
			#if self.statemachine_of_message_window.is_none():
			#	print("［メッセージウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　メッセージ・ウィンドウが消えてしまっているので、会話を再開する")
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
				child.set_appear_subtree(is_appear)


# テキストボックスなどにフォーカスが無いときの入力を拾う
func on_unhandled_key_input(event):

	var snapshot = self.director_get_current_snapshot.call()

	# 完全表示中
	if self.statemachine_of_message_window.is_completed():

		# 選択肢モードなら
		if snapshot.is_choices():
			
			# 押下時
			if event.is_pressed():
				
				# 確定ボタン以外は無効
				if event.keycode != KEY_ENTER:
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢　押下時　エンターキーではないのでメッセージ送りしません")
					return
					
				else:
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢　押下時　エンターキー　ページ送りする")
					# 選択肢を確定した
					# ページ送り
					self.statemachine_of_message_window.page_forward()
					return

			else:
				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢　押下時ではない")
		
		# それ以外なら
		else:
			# 何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢ではない　押下時　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return

				print("［伝言窓　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　アンハンドルド・キー入力　選択肢ではない　押下時　Ｒキー以外　ページ送りする")
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

	var snapshot = self.director_get_current_snapshot.call()

	# テキストブロック
	var text_block_node = self.get_text_block()

	# 選択肢なら
	if snapshot.is_choices():
		print("［メッセージウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選択肢開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.decide()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.think()
	
	else:
		print("［メッセージウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　台詞開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		text_block_node.get_node("ChoiceCursor").statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		text_block_node.get_node("BlinkerTriangle").statemachine_of_end_of_message_blinker.think()
		text_block_node.get_node("BlinkerUnderscore").statemachine_of_end_of_message_blinker.think()


# ページ送り
func on_page_forward():
	var snapshot = self.director_get_current_snapshot.call()

	# 選択肢モードなら
	if snapshot.is_choices():

		# カーソル音
		self.get_musician().playSe("選択肢確定音")

		var row_number = self.get_text_block().get_node("ChoiceCursor").selected_row_number
		print("［メッセージウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　選んだ選択肢行番号：［" + str(row_number) + "］")

		# 選択肢の行番号を、上位ノードへエスカレーションします
		self.get_assistant_director().on_choice_selected(row_number)

		# 選択肢はお役御免
		snapshot.choices_row_numbers = null
		
	else:
		print("［メッセージウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　ページ送り")

		# 効果音
		self.get_musician().playSe("ページめくり音")
		
		# パースを開始してよい
		self.director_get_current_snapshot.call().set_parse_lock(false)

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
	var snapshot = self.director_get_current_snapshot.call()

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
	var snapshot = self.director_get_current_snapshot.call()
	print("［メッセージ・ウィンドウ　”" + self.name + "”］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　オン・オール・ページズ・フィニッシュド］（非表示）")

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

	# 最初は非表示
	# self.set_visible_subtree(false)


func _process(delta):

	# 一時的にどこかに消えているのなら処理しない
	if not self.is_appear:
		return

	# メッセージ・ウィンドウが存在しないなら、働かない
	if self.statemachine_of_message_window.is_none():
		pass

	# タイプライター風表示中
	elif self.statemachine_of_message_window.is_typewriter():

		var snapshot = self.director_get_current_snapshot.call()

		snapshot.count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 0.05
	
		# メッセージの早送り
		if Input.is_key_pressed(KEY_R):
			# print("［テキストブロック］（" + str(snapshot.name) + "　" + snapshot.section_name + "）　メッセージの早送り")
			wait_time = 0.01
	
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
