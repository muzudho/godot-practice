# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・コンクリート（Its concrete；その具体的な）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 状態機械
var statemachine_of_message_window = load("res://🍋scripts/🪑grayscale_🍉visual_novel/👤programmer/📂message_windows/statemachines/message_window.gd").new()

# 祖先の直下の子
var ancestor_children_dictionary = {}

# ページ送り時の対応関数の変数
var on_message_window_page_forward = func():
	pass

# 可視性
var is_appear = true

# メッセージ・スピード（１秒当たりの文字数）
var msg_speed = 20.0

# テキストブロック汎用
#	段落の何番目（０開始）を次に読込むか
var paragraph_item_index = 0
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null
#	選択肢配列のインデックス
var choices_index = 0


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# メッセージ・ウィンドウの軸取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏MessageWindows/🐵Monkey_🍉VisualNovel",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# 準備
# ーーーーーーーー


func _ready():
	
	# 状態機械のセットアップ
	self.statemachine_of_message_window.on_talked_2 = self.on_talked_2
	self.statemachine_of_message_window.on_page_forward = self.on_page_forward
	self.statemachine_of_message_window.on_all_characters_pushed = self.on_all_characters_pushed
	self.statemachine_of_message_window.on_all_pages_flushed = self.on_all_pages_flushed


# 状態遷移するだけ
func on_talked_2():

	var illust_a = self.monkey().of_staff().programmer().owner_node().images.find_node(self.name)

	# 表示
	self.set_visible_subtree(true)
	illust_a.modulate.a = 1.0	# メッセージ追加による不透明化

	# 選択肢なら
	if self.is_choices():
		#print("［伝言窓　”" + self.name + "”］　選択肢開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.monkey().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.monkey().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.monkey().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()
	
	else:
		#print("［伝言窓　”" + self.name + "”］　台詞開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.monkey().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.monkey().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.monkey().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# ページ送り
# 状態遷移機械から呼出される
func on_page_forward():
	# 選択肢モードなら
	if self.is_choices():

		# カーソル音
		self.monkey().of_staff().programmer().get_instruction_node(&"📗SoundFx").play_se("🔔選択肢確定音")

		var row_number = self.get_row_number_of_choices()
		#print("［伝言窓　”" + self.name + "”］　選んだ選択肢行番号：［" + str(row_number) + "］")

		# 選択肢の行番号を、上位ノードへエスカレーションします
		self.monkey().of_staff().programmer().scenario_player_node().on_choice_selected(row_number)

		# 選択肢はお役御免
		self.choices_row_numbers = null
		
	else:
		#print("［伝言窓　”" + self.name + "”］　ページ送り")

		# 効果音
		self.monkey().of_staff().programmer().get_instruction_node(&"📗SoundFx").play_se("🔔ページめくり音")
		
		# ページ送りをしたことを、呼出し元へ伝える
		self.on_message_window_page_forward.call()

	# 空っぽのウィンドウを残して、次の指示を待ちます
	# テキストブロック
	var text_block_node = self.monkey().get_text_block(self.name)
	if true:
		# テキストが空っぽ
		text_block_node.text = ""
		# 全てのブリンカー　状態機械［決めた］
		self.monkey().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.monkey().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		self.monkey().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()


func on_all_characters_pushed():
	# 選択肢
	if self.is_choices():
		# 文末ブリンカー	状態機械［考える］
		self.monkey().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()

	# それ以外
	else:
		# 文末ブリンカー	状態機械［考える］
		self.monkey().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.monkey().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# 初期化
#	ウィンドウが存在しない状態に戻します
func on_all_pages_flushed():
	#print("［伝言窓　”" + self.name + "”］　オン・オール・ページズ・フィニッシュド］（非表示）")
	var illust_a = self.monkey().of_staff().programmer().owner_node().images.find_node(self.name)

	# テキストブロック
	var text_block_node = self.monkey().get_text_block(self.name)
	# テキストが空っぽ
	text_block_node.text = ""

	# 選択肢
	if self.is_choices():
		# 全てのブリンカー　状態機械［決めた］
		self.monkey().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
	else:
		# 全てのブリンカー　状態機械［決めた］
		self.monkey().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.monkey().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()

	# この要素の初期状態は、非表示、透明
	self.set_visible_subtree(false)
	illust_a.modulate.a = 0.0	# 初期化による透明化


# ーーーーーーーー
# その他のイベントハンドラ
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

		self.count_of_typewriter += delta

		# １文字 50ms でも、結構ゆっくり
		var wait_time = 1 / self.msg_speed	# 旧 0.05
	
		# メッセージの早送り
		if self.monkey().of_staff().programmer().message_windows_globe_node().is_fast_forward:
			# print("［テキストブロック］　メッセージの早送り")
			wait_time = 1 / (self.msg_speed * self.msg_speed) # 旧 0.01
	
		if wait_time <= self.count_of_typewriter:

			# TODO キャッシュ化したい
			# テキストブロック
			var text_block_node = self.monkey().get_text_block(self.name)

			if 0 < self.text_block_buffer.length():
				# バッファーの先頭の１文字を切り取って、テキストブロックへ移動
				text_block_node.text += self.pop_head_of_text_block()
			else:
				# 完全表示中
				#print("［伝言窓　”" + self.name + "”］　プロセス　完全表示中だ")
				self.statemachine_of_message_window.all_characters_pushed()
			
			self.count_of_typewriter -= wait_time


# 仮想キー入力時
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func on_virtual_key_input(
		vk_name,
		vk_state,
		vk_occurence,
		vk_during):

	# 選択肢カーソル
	self.monkey().get_choices_cursor(self.name).on_virtual_key_input(
			vk_name,
			vk_state,
			vk_occurence,
			vk_during)

	if vk_name == &"VK_FastForward":
		# 押下中のみ、メッセージの早送りを有効にする（トグル式にすると、戻し方が分からんとかになる）
		if vk_during == &"Pressing":
			print("［伝言窓］　早送りボタン押下 vk_during:" + vk_during)
			self.monkey().of_staff().programmer().message_windows_globe_node().is_fast_forward = true

		elif vk_during == &"Neutral":
			print("［伝言窓］　早送りボタン解放 vk_during:" + vk_during)
			self.monkey().of_staff().programmer().message_windows_globe_node().is_fast_forward = false

		else:
			print("［伝言窓］　早送りボタン無視 vk_during:" + vk_during)
			pass

	# 完全表示中
	if self.statemachine_of_message_window.is_completed():

		# 選択肢モードなら
		if self.is_choices():
			
			# 押下時
			if vk_occurence == &"Pressed":
				
				# TODO カーソルの上下もここにくる？

				# 確定ボタン以外は無効
				if vk_name != &"VK_Ok":
					#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキーではないのでメッセージ送りしません")
					return
					
				else:
					#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時　エンターキー　ページ送りする")
					# 選択肢を確定した
					# ページ送り
					self.statemachine_of_message_window.page_forward()
					return

			else:
				#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力＞完全表示中＞選択肢＞押下時ではない")
				pass
		
		# 通常テキストモードなら
		else:
			# 何かキーを押したとき
			if vk_occurence == &"Pressed":
				
				# ページ早送りボタンは無効
				if vk_name == &"VK_FastForward":
					#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキーでは、メッセージ送りしません")
					return

				#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時　メッセージ早送りキー以外だ（" + vk_name + "）　ページ送りする")
				# ページ送り
				self.statemachine_of_message_window.page_forward()

			else:
				#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　選択肢ではない　押下時ではないから何もしない")
				pass

	else:
		#print("［伝言窓　”" + self.name + "”］　アンハンドルド・キー入力　完全表示中ではないから何もしない")
		pass


# ーーーーーーーー
# その他のメソッド
# ーーーーーーーー


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# サブツリーの visible を設定
func set_visible_subtree(
		visible_flag):			# bool

	var illust_a = self.monkey().of_staff().programmer().owner_node().images.find_node(self.name)
	#print("［伝言窓　”" + self.name + "”］　現可視性：" + str(illust_a.visible) + "　次可視性：" + str(visible_flag))

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if visible_flag != illust_a.visible:

		#print("［伝言窓　”" + self.name + "”］　可視性：" + str(visible_flag))

		illust_a.visible = visible_flag
		self.monkey().get_canvas_layer(self.name).visible = visible_flag

		# 子ノード
		for child in self.monkey().get_text_block(self.name).get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(visible_flag)


# 選択肢カーソル位置のリセット
func reset_cursor_position():
	self.monkey().get_choices_cursor(self.name).reset_cursor_position()


# サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(
	is_process):	# bool

	# 処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	# 処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	# 処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	# 処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():

		#print("［伝言窓　”" + self.name + "”］　プロセッシング：" + str(is_process))

		self.set_process(is_process)

		# 子ノード
		for child in self.monkey().get_text_block(self.name).get_children():
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

		#print("［伝言窓　”" + self.name + "”］　appear：" + str(appear_flag))

		var illust_a = self.monkey().of_staff().programmer().owner_node().images.find_node(self.name)
		self.is_appear = appear_flag

		if self.is_appear:
			# 画面内に戻す
			illust_a.position += Vector2(0, -720)
			self.monkey().get_text_block(self.name).position += Vector2(0, -720)

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
			self.monkey().get_text_block(self.name).position -= Vector2(0, -720)

		# 子ノード
		for child in self.monkey().get_text_block(self.name).get_children():
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
