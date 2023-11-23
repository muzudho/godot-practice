extends Node2D


class_name MessageWindowProgram


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 状態機械
var statemachine_of_message_window = load("res://🍋scripts/🪑grayscale_🍉visual_novel/🍱message_windows/statemachines/message_window.gd").new()

# ページ送り時の対応関数
var on_message_window_page_forward = func():
	pass

# 可視性
var is_appear = true

# メッセージ・スピード（１秒当たりの文字数）
var msg_speed = 20.0

# テキストブロック汎用
#	セクションの何番目（０開始）を次に読込むか
var section_item_index = 0
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
func hub():
	pass


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

	var illust_a = self.hub().get_programs_hub().get_illust(self.name)

	# 表示
	self.set_visible_subtree(true)
	illust_a.modulate.a = 1.0	# メッセージ追加による不透明化

	var message_window_gui = self.hub().get_programs_hub().get_current_message_window_gui()

	# 選択肢なら
	if message_window_gui.is_choices():
		print("［伝言窓　”" + self.name + "”］　選択肢開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.hub().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.hub().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.hub().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()
	
	else:
		print("［伝言窓　”" + self.name + "”］　台詞開始")
		# メッセージエンド・ブリンカー　状態機械［決めた］
		self.hub().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
		
		# メッセージエンド・ブリンカー　状態機械［考える］
		self.hub().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.hub().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# ページ送り
# 状態遷移機械から呼出される
func on_page_forward():
	var message_window_gui = self.hub().get_programs_hub().get_current_message_window_gui()

	# 選択肢モードなら
	if message_window_gui.is_choices():

		# カーソル音
		self.hub().get_programs_hub().get_instruction(&"📗Se").play_se("🔔選択肢確定音")

		var row_number = message_window_gui.get_row_number_of_choices()
		print("［伝言窓　”" + self.name + "”］　選んだ選択肢行番号：［" + str(row_number) + "］")

		# 選択肢の行番号を、上位ノードへエスカレーションします
		self.hub().get_programs_hub().on_choice_selected(row_number)

		# 選択肢はお役御免
		message_window_gui.choices_row_numbers = null
		
	else:
		print("［伝言窓　”" + self.name + "”］　ページ送り")

		# 効果音
		self.hub().get_programs_hub().get_instruction(&"📗Se").play_se("🔔ページめくり音")
		
		# ページ送りをしたことを、呼出し元へ伝える
		self.on_message_window_page_forward.call()

	# 空っぽのウィンドウを残して、次の指示を待ちます
	# テキストブロック
	var text_block_node = self.hub().get_text_block(self.name)
	if true:
		# テキストが空っぽ
		text_block_node.text = ""
		# 全てのブリンカー　状態機械［決めた］
		self.hub().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.hub().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()
		self.hub().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()


func on_all_characters_pushed():
	var message_window_gui = self.hub().get_programs_hub().get_current_message_window_gui()

	# 選択肢
	if message_window_gui.is_choices():
		# 文末ブリンカー	状態機械［考える］
		self.hub().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.think()

	# それ以外
	else:
		# 文末ブリンカー	状態機械［考える］
		self.hub().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.think()
		self.hub().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.think()


# 初期化
#	ウィンドウが存在しない状態に戻します
func on_all_pages_flushed():
	var message_window_gui = self.hub().get_programs_hub().get_current_message_window_gui()

	print("［伝言窓　”" + self.name + "”］　オン・オール・ページズ・フィニッシュド］（非表示）")
	var illust_a = self.hub().get_programs_hub().get_illust(self.name)

	# テキストブロック
	var text_block_node = self.hub().get_text_block(self.name)
	# テキストが空っぽ
	text_block_node.text = ""

	# 選択肢
	if message_window_gui.is_choices():
		# 全てのブリンカー　状態機械［決めた］
		self.hub().get_choices_cursor(self.name).statemachine_of_end_of_message_blinker.decide()
	else:
		# 全てのブリンカー　状態機械［決めた］
		self.hub().get_blinker_triangle(self.name).statemachine_of_end_of_message_blinker.decide()
		self.hub().get_blinker_underscore(self.name).statemachine_of_end_of_message_blinker.decide()

	# この要素の初期状態は、非表示、透明
	self.set_visible_subtree(false)
	illust_a.modulate.a = 0.0	# 初期化による透明化


# ーーーーーーーー
# その他
# ーーーーーーーー


# サブツリーの visible を設定
func set_visible_subtree(
		visible_flag):			# bool

	var illust_a = self.hub().get_programs_hub().get_illust(self.name)
	print("［伝言窓　”" + self.name + "”］　現可視性：" + str(illust_a.visible) + "　次可視性：" + str(visible_flag))

	# 見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	# 隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	# 見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	# 隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if visible_flag != illust_a.visible:

		print("［伝言窓　”" + self.name + "”］　可視性：" + str(visible_flag))

		illust_a.visible = visible_flag
		self.hub().get_canvas_layer(self.name).visible = visible_flag

		# 子ノード
		for child in self.hub().get_text_block(self.name).get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(visible_flag)
