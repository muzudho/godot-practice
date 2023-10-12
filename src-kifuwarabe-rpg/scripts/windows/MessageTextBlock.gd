# テキスト・ブロック（TextBlock）
extends Label

# メッセージ・ウィンドウの状態遷移図（親ノードがセットする）
var statemachine = null

var is_visible_initialized = false


func get_snapshot(department_node_name):
	return $"../../../../../System/Snapshots".get_node(department_node_name)


#	初期化の前に
#		初期化の一種ですが、初期化より先に行います。
#		引数を渡すことが **初期化** との違いです
func before_initialize(parent_statemachine):
	print("［テキストブロック］　初期化の前に")
	
	#	親からステートマシンを受け取る
	self.statemachine = parent_statemachine
	
	#	子どもにも渡す
	$"BlinkerTriangle".before_initialize(self.statemachine)
	$"BlinkerUnderscore".before_initialize(self.statemachine)
	$"ChoiceCursor".before_initialize(self.statemachine)


#	初期化
#		ウィンドウが無い状態に戻すことを想定しています。
#		引数を渡さずに呼び出せることが **初期化の前に** との違いです
func initialize():
	print("［テキストブロック］　初期化（非表示）")

	# テキストが空っぽ
	self.text = ""
	
	#	全てのブリンカーを透明にして非表示にしておく
	$"BlinkerTriangle".initialize()
	$"BlinkerUnderscore".initialize()
	$"ChoiceCursor".initialize()

	#	非表示
	self.hide()
	self.is_visible_initialized = false


#	空欄化
#		初期化の一種ですが、ウィンドウは残しておきます
func emptize():
	print("［テキストブロック］　空欄化（表示）")

	# テキストが空っぽ
	self.text = ""
	
	# ブリンカーを透明にして表示しておく
	$"BlinkerTriangle".emptize()
	$"BlinkerUnderscore".emptize()
	$"ChoiceCursor".emptize()

	#	表示
	self.show()
	self.is_visible_initialized = false


# メッセージを追加
func push_message(new_text, choice_row_numbers = null):

	#	テキスト設定
	self.get_snapshot("VisualNovelDepartment").text_block_buffer = new_text

	#	空欄化
	self.emptize()

	#	選択肢なら
	if choice_row_numbers != null:
		print("［テキストブロック］　選択肢：　[" + new_text + "]")
		self.get_snapshot("VisualNovelDepartment").is_choice_mode = true
		self.get_snapshot("VisualNovelDepartment").choice_row_numbers = choice_row_numbers

		# メッセージエンド・ブリンカーは無いことにする
		$"BlinkerTriangle".initialize()
		$"BlinkerUnderscore".initialize()

	#	それ以外なら
	else:
		print("［テキストブロック］　台詞：　[" + new_text + "]")
		self.get_snapshot("VisualNovelDepartment").is_choice_mode = false
		self.get_snapshot("VisualNovelDepartment").choice_row_numbers = []



#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	print("［テキストブロック］　プロセッシング：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード
		for child in self.get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


#	サブツリーの visible を設定
func set_visible_subtree(is_visible):
	print("［テキストブロック］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in self.get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)


# Called when the node enters the scene tree for the first time.
func _ready():
	self.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#	TODO ★ タイプライター機能は、スナップショット、またはメッセージの方に持たせたい
func _process(delta):
	
	# 非表示のときは働かない
	if self.visible:
	
		# タイプライター風表示中
		if self.statemachine.is_typewriter():
			
			if not self.is_visible_initialized:
				# 初回に可視化
				self.visible = true
				self.is_visible_initialized = true
			
			self.get_snapshot("VisualNovelDepartment").count_of_typewriter += delta

			# １文字 50ms でも、結構ゆっくり
			var wait_time = 0.05
		
			# メッセージの早送り
			if Input.is_key_pressed(KEY_R):
				# print("［テキストブロック］　メッセージの早送り")
				wait_time = 0.01
		
			if wait_time <= self.get_snapshot("VisualNovelDepartment").count_of_typewriter:
				if 0 < self.get_snapshot("VisualNovelDepartment").text_block_buffer.length():
					# １文字追加
					self.text += self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(0, 1)
					self.get_snapshot("VisualNovelDepartment").text_block_buffer = self.get_snapshot("VisualNovelDepartment").text_block_buffer.substr(1, self.get_snapshot("VisualNovelDepartment").text_block_buffer.length()-1)
				else:
					# 完全表示中
					self.statemachine.all_character_pushed()
				
				self.get_snapshot("VisualNovelDepartment").count_of_typewriter -= wait_time
