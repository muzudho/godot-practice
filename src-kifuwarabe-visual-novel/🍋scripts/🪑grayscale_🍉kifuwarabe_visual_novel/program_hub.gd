# プログラム・ハブ（Program Hub；プログラムの中心地）
extends Node


# 全角数字
var zenkaku_numbers = ["０", "１", "２", "３", "４", "５", "６", "７", "８", "９"]


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督取得
func get_director():
	return $"../../../Director"


# シナリオライター取得
func get_scenario_writer():
	return self.get_director().get_node("📂ScenarioWriter")


# シナリオ・リーダー取得
func get_scenario_reader():
	return self.get_scenario_writer().get_node("System/Reader")


# BGM取得
func get_bgm():
	return self.get_director().get_node("📂Musician_BGM")


# 効果音取得
func get_se():
	return self.get_director().get_node("📂Musician_SE")


# 背景アーティスト
func get_background_artist():
	return self.get_director().get_node("📂BackgroundArtist")


# イラストレーター取得
func get_illustrator():
	return self.get_director().get_node("📂Illustrator")


# テロップ・コーディネーター取得
func get_telop_coordinator():
	return self.get_director().get_node("📂TelopCoordinator")


# モンスターの全身像
func get_monster_whole_body():
	return self.get_director().get_node("MonsterTrainer/WholeBody")


# モンスター・フェースズ
func get_monster_faces():
	return self.get_director().get_node("MonsterTrainer/Faces")


# 命令ノード取得
func get_instruction(instruction_name):
	return $"../🍱Instructions_🍉KifuwarabeVisualNovel".get_node(instruction_name)



# ーーーーーーーー
# その他
# ーーーーーーーー


# 変数展開する
# `target_before_change` - １行かもしれないし、段落かもしれないし、匿名関数かもしれない
func expand_variables(target_before_change):
	
	target_before_change = target_before_change.strip_edges()
		
	if target_before_change is String:
		# ここで `{{banana}} などの引数を　変数展開したい
		
		# 無限に変数展開することを防ぐため、変換前文字列と、変換後文字列は別途用意する
		var terget_after_change = ""
				
		var from = 0
		
		while from < target_before_change.length():
			var open_index = target_before_change.find("{{", from)
			var close_index = target_before_change.find("}}", from)
			
			if from <= open_index and open_index + 2 < close_index:

				# Head
				terget_after_change += target_before_change.substr(from, open_index - from)

				# 変数名取得
				var key = target_before_change.substr(open_index + 2, close_index - (open_index + 2))
				print("［助監　変数展開］　変数キー：［" + key + "］")
				
				if key in self.get_director().stage_directions_variables:
					var value = self.get_director().stage_directions_variables[key]
					print("［助監　変数展開］　変数値：［" + value + "］")
				
					terget_after_change += value
				
				else:
					print("［助監　変数展開］　変数値が見つかりません")
					
					# 仕方ないので、カッコ悪いが、キー（ハンドルバー）を画面に表示する
					terget_after_change += "{{" + key + "}}"

				from = close_index + 2
		
			else:
				#print("［助監　変数展開］　対象なし　段落：［" + target_before_change + "］")
				terget_after_change += target_before_change.substr(from)
				break

		return terget_after_change
	
	else:
		#print("［助監　変数展開］　対象なし　非テキスト")
		return target_before_change


# １番外側でダブルクォーテーションが挟んでいれば、そのダブルクォーテーションを外します
func trim_double_quotation(line):
	if 2 <= line.length() and line[0]=="\"" and line[-1]=="\"":
		return line.substr(1, line.length()-2)
	
	return line


# 先頭行と、それ以外に分けます。できなければヌル
func split_head_line_or_tail(text):
	# 最初の改行を見つける
	var index = text.find("\n")
	
	if index < 0:
		return null
	
	var head = text.substr(0, index)
	var tail = text.substr(index+1)
	# print("［助監］　head：　[" + head + "]")
	# print("［助監］　tail：　[" + tail + "]")
	return [head, tail]


# 数値を全角テキストに変換
func number_to_zenkaku_text(number, figures):
	var zenkaku_text = ""
	
	while 0 < number:
		var zenkaku_num = self.zenkaku_numbers[number % 10]
		number /= 10
		
		zenkaku_text = zenkaku_num + zenkaku_text
	
	# 左側に全角空白を詰める
	var spaces = figures - zenkaku_text.length()
	for i in range(spaces):
		zenkaku_text = "　" + zenkaku_text
		
	return zenkaku_text


# シナリオの現在セクション配列のサイズを返す
func get_current_section_size_of_scenario():
	var snapshot = self.get_director().get_current_snapshot()	
	var scenario_node_name = snapshot.name
	var section_name =  snapshot.section_name
	
	var section_array = self.get_scenario_reader().get_section_array(scenario_node_name, section_name)
	return section_array.size()


# シナリオの現在パラグラフ（セクションのアイテム）を返す
func get_current_paragraph_of_scenario():
	var snapshot = self.get_director().get_current_snapshot()
	var message_window_gui = self.get_director().get_current_message_window_gui()

	return self.get_scenario_writer().get_node(str(snapshot.name)).document[snapshot.section_name][message_window_gui.section_item_index]


# 「§」セクションの再生
func play_section():
	var snapshot = self.get_director().get_current_snapshot()
	var message_window_gui = self.get_director().get_current_message_window_gui()

	# 全部消化済みの場合
	if self.get_current_section_size_of_scenario() <= message_window_gui.section_item_index:
		print("［助監］（" + snapshot.name + "　" + snapshot.section_name + "）　セクションを読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window_gui.statemachine_of_message_window.is_completed():
			print("［助監］（" + snapshot.name + "　"+ snapshot.section_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not message_window_gui.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window_gui.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［助監］（" + snapshot.name + "　"+ snapshot.section_name + "）　パースを開始してよい（本当か？）")
			# パースを開始してよい
			snapshot.set_parse_lock(false)


# 伝言窓で選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［助監］　選択肢を確定させた")

	# 伝言窓の状態遷移
	#	ずっと Completed だと、困るから
	print("［助監］　伝言窓を　オール・ページズ・フラッシュド　する")
	self.get_director().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


	var snapshot = self.get_director().get_current_snapshot()
	var department_name = str(snapshot.name)
	var section_name = snapshot.section_name
	
	print("［助監］　現在の部門名　　　：" + department_name)
	print("［助監］　現在の区画名　　　：" + section_name)
	print("［助監］　選んだ選択肢行番号：" + str(row_number))

	# シナリオ・ノード
	var scenario_node = self.get_scenario_writer().get_node(department_name)

	# 区画名。実質的には選択肢の配列
	var section_obj = scenario_node.choices_mappings[section_name]

	# 次のセクション名
	var next_section_name = section_obj[row_number]
	print("［助監］　次の区画名　　　　：" + next_section_name)
	
	self.get_director().set_current_section(next_section_name)
	self.play_section()


# パラグラフ（セクションのアイテム）が［ト書き］か、［台詞］か、によって処理を分けます
func parse_paragraph(paragraph_text):
	
	# ［ト書き］かどうか判定
	var first_head_tail = self.split_head_line_or_tail(paragraph_text)
	var first_head = first_head_tail[0].strip_edges()
	var first_tail = first_head_tail[1] 
	
	# ［ト書き］
	# `.strip_edges()` - 先頭行の最初と、最終行の最後の表示されない文字を消去
	if first_head.strip_edges() == "!":
		print("［助監］　命令テキストだ：[" + first_tail + "]")

		# さらに先頭行を取得
		var second_head_tail = self.split_head_line_or_tail(first_tail)
		
		while second_head_tail != null:
			var second_head = second_head_tail[0].strip_edges()
			var second_tail = second_head_tail[1]
			# print("［助監］　second_head：[" + second_head + "]")
			# print("［助監］　second_tail：[" + second_tail + "]")

			# 以下の命令は、アルファベット順で並べてある
			#
			# コメント
			if second_head.begins_with("#"):
				pass
				
			# 背景切替
			elif second_head.begins_with("bg:"):
				self.get_instruction("Bg").do_it(second_head)

			# ＢＧＭ再生／停止
			elif second_head.begins_with("bgm:"):
				self.get_instruction("Bgm").do_it(second_head)
			
			# 選択肢かどうか判定
			elif second_head.begins_with("choice:"):
				self.get_instruction("Choice").do_it(second_head)

			# 部門変更
			elif second_head.begins_with("department:"):
				self.get_instruction("Department").do_it(second_head)
				
			# 次のセクションへ飛ぶ
			elif second_head.begins_with("goto:"):
				self.get_instruction("Goto").do_it(second_head)

			# 画像を表示する
			elif second_head.begins_with("img:"):
				self.get_instruction("Img").do_it(second_head)

			# ラベル設定
			elif second_head.begins_with("label:"):
				self.get_instruction("Label").do_it(second_head)
			
			# メッセージ・スピード変更
			elif second_head.begins_with("msg_speed:"):
				self.get_instruction("MsgSpeed").do_it(second_head)

			# メッセージ出力先ウィンドウ変更
			elif second_head.begins_with("m_wnd:"):
				self.get_instruction("MWnd").do_it(second_head)

			# アプリケーション終了
			elif second_head.begins_with("quit:"):
				self.get_instruction("Quit").do_it(second_head)
			
			# 効果音
			elif second_head.begins_with("se:"):
				self.get_instruction("Se").do_it(second_head)

			# スリープ
			elif second_head.begins_with("sleep:"):
				self.get_instruction("Sleep").do_it(second_head)

			# テロップの表示／非表示
			elif second_head.begins_with("telop:"):
				self.get_instruction("Telop").do_it(second_head)
			
			# 変数セット
			elif second_head.begins_with("var:"):
				self.get_instruction("Var").do_it(second_head)

			# さらに先頭行を取得
			second_head_tail = split_head_line_or_tail(second_tail)

		#	［ト書き］終わり
		return

	var message_window_gui = self.get_director().get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.get_instruction("NormalTextChoice").do_it(paragraph_text)
		return

	# print("［助監］　選択肢ではない")
	self.get_instruction("NormalText").do_it(paragraph_text)


# ディレクターの `_process(delta)` が呼出す
func on_process(delta):

	if 0.0 < self.get_director().sleep_seconds:
		self.get_director().sleep_seconds -= delta

		# 疑似スリープ値が残っている間は、シナリオを進めません
		return

	var snapshot = self.get_director().get_current_snapshot()
	var message_window_gui = self.get_director().get_current_message_window_gui()

	# パースを開始してよいか？（ここで待機しないと、一瞬で全部消化してしまう）
	if not snapshot.is_parse_lock():
		
		# まだあるよ
		if message_window_gui.section_item_index < self.get_current_section_size_of_scenario():
		
			# 現在のシナリオの次のパラグラフを取得
			var paragraph = self.get_current_paragraph_of_scenario()

			# カウントアップ
			message_window_gui.section_item_index += 1
			
			if paragraph is String:
				
				var latest_message = paragraph + ""	# 文字列を参照ではなく、コピーしたい

				# ここで、命令と、台詞は区別する
				self.parse_paragraph(latest_message)
			
			else:
				# TODO 文字列以外のパラグラフに対応したい
				print("［助監］　TODO 匿名関数かもしれない呼出してみよ")
				paragraph.call()

		# もう無いよ
		else:
			if not self.get_director().get_current_message_window_gui().statemachine_of_message_window.is_none():
				# 伝言窓を閉じる
				self.get_director().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()
