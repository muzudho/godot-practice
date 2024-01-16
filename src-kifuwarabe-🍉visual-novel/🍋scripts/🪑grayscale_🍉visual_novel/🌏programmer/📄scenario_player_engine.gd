# シナリオ再生エンジン
# TODO ここにシナリオを読取る処理を移動したい
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}

# 全命令（キー："命令名:"　値：ノード名）
var directory_for_instruction_code_and_node_name = null


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🛩️Hub",
			self.ancestors)


# 全ての命令コード一覧
func get_all_instruction_codes():
	if self.directory_for_instruction_code_and_node_name == null:
		self.directory_for_instruction_code_and_node_name = {}	# キー：StringName, 値：None

		MonkeyHelper.search_node_name_begins_with(
				# 命令のノード名は `📗` で始まるものとする
				&"📗",
				# 探す場所
				# 本当は `🌏Programmer` ノードの下のどこかにある `📂ScenarioPlayer_🍉VisualNovel` ノードのさらに下の `📂Instructions` ノードの下を探して欲しいが。
				self.hub().get_programmer(),
				func(child_node):
					# コードにノード名を紐づける
					self.directory_for_instruction_code_and_node_name[child_node.code] = child_node.name)

	return self.directory_for_instruction_code_and_node_name


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# 「§」セクションの再生
func play_section():
	var department_value = self.hub().get_current_department_value()
	var message_window_gui = self.hub().get_current_message_window_gui()

	# 全部消化済みの場合
	if self.hub().get_current_section_size_of_scenario() <= message_window_gui.section_item_index:
		print("［シナリオ再生エンジン］（" + department_value.name + "　" + department_value.section_name + "）　セクションを読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window_gui.statemachine_of_message_window.is_completed():
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.section_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not message_window_gui.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window_gui.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.section_name + "）　パースを開始してよい（本当か？）")
			# パースを開始してよい
			department_value.set_parse_lock(false)


# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
		
	# ト書きなら実行
	if self.execute_stage_directions(paragraph_text):
		# すれば抜ける
		return

	# 選択肢なら表示
	if self.print_choices(paragraph_text):
		# すれば抜ける
		return

	# 通常文書の表示
	self.print_normal_text(paragraph_text)


# 通常文書の表示	
func print_normal_text(paragraph_text):
	#print("［シナリオエンジン］　準備中　通常文書の表示")
	self.hub().get_instruction(&"📘NormalText").do_it(paragraph_text)


# 選択肢なら表示
func print_choices(paragraph_text):
	#print("［シナリオエンジン］　準備中　選択肢なら表示")
	var message_window_gui = self.hub().get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.hub().get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)
		return true

	return false


# ト書きなら実行
func execute_stage_directions(paragraph_text):
	print("［シナリオエンジン］　準備中　ト書きなら実行")
	
	# ［ト書き］かどうか判定
	var first_head_tail = self.hub().split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
		
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［助監］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = self.hub().split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]
			# print("［助監］　second_head：[" + second_head + "]")
			# print("［助監］　second_tail：[" + second_tail + "]")
			# 文字列の配列に分割
			var string_packed_array = second_head.split(":", true, 1)
			var instruction_code = string_packed_array[0] + ":"

			# コメント
			if second_head.begins_with("#"):
				pass

			else:
				# 例えば `img:` といったコードから、 `📗Img` といった命令ノードを検索し、それを実行します
				if instruction_code in self.directory_for_instruction_code_and_node_name:
					var instruction_node_name = self.directory_for_instruction_code_and_node_name[instruction_code]
					var instruction = self.hub().get_instruction(instruction_node_name)
					instruction.do_it(second_head)
				
			# さらに先頭行を取得
			second_head_tail = self.hub().split_head_line_or_tail(second_tail)

		# ーーーーーーーー
		# ［ト書き］終わり
		# ーーーーーーーー
		self.hub().is_department_not_found = false
		return true

	return false

