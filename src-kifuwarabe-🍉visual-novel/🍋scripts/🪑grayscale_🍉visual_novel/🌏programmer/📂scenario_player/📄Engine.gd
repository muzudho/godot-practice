# シナリオ再生エンジン
# TODO ここにシナリオを読取る処理を移動したい
extends Node


# ーーーーーーーー
# 共通メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🛩️Hub",
			self.ancestors)


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


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

			# 以下の命令は、アルファベット順で並べてある
			#
			# コメント
			if second_head.begins_with("#"):
				pass

			else:
				# `img:` といったコードから、 `📗Img` といった命令ノードを検索し、それを実行します
				if instruction_code in self.hub().directory_for_instruction_code_and_node_name:
					var instruction_node_name = self.hub().directory_for_instruction_code_and_node_name[instruction_code]
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

