# パーサー・フォー・パラグラフ（Parser For Paragraph；段落のための解析機）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー

# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
	
	# ト書きなら実行して抜ける
	if self.is_state_directions(paragraph_text):
		self.execute_stage_directions(paragraph_text)
		return

	# 選択肢なら、選択肢を表示して選ばせる
	if self.is_choices():
		self.execute_choices(paragraph_text)
		return

	# 通常文書の表示
	self.print_normal_text(paragraph_text)


# ト書きか？
#
#	先頭行が "!" １文字ならト書き
func is_state_directions(paragraph_text):
	var first_head_tail = StringHelper.split_head_line_or_tail(paragraph_text)
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	var first_head = first_head_tail[0].strip_edges()
	return first_head.strip_edges() == "!"


# ト書きを実行
func execute_stage_directions(paragraph_text):
	# 先頭行（"!" １文字）を捨てる	
	var first_head_tail = StringHelper.split_head_line_or_tail(paragraph_text)
	var first_tail = first_head_tail[1] 
		
	# 以降、本文
	print("［シナリオエンジン］　ト書き本文：[" + first_tail + "]")

	# さらに先頭行を取得
	var second_head_tail = StringHelper.split_head_line_or_tail(first_tail)
	
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
			if instruction_code in self.monkey().internal().directory_for_instruction_code_and_node_name:
				var instruction_node_name = self.monkey().internal().directory_for_instruction_code_and_node_name[instruction_code]
				var instruction = self.monkey().of_programmer().get_instruction(instruction_node_name)
				instruction.do_it(second_head)
			
		# さらに先頭行を取得
		second_head_tail = StringHelper.split_head_line_or_tail(second_tail)

	# ーーーーーーーー
	# ［ト書き］終わり
	# ーーーーーーーー
	self.monkey().internal().is_department_not_found = false


# メッセージ・ウィンドウは選択肢か？
func is_choices():
	# 選択肢かどうかは、メッセージ・ウィンドウに設定されている。
	return self.monkey().get_current_message_window_gui().choices_row_numbers != null


# 選択肢なら表示
func execute_choices(paragraph_text):
	#print("［シナリオエンジン］　準備中　選択肢なら表示")
	self.monkey().of_programmer().get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)


# 通常文書の表示	
func print_normal_text(paragraph_text):
	#print("［シナリオエンジン］　準備中　通常文書の表示")
	self.monkey().of_programmer().get_instruction(&"📘NormalText").do_it(paragraph_text)
