# シナリオ・プレイヤー　＞　イッツ　（Scenario Player；台本再生機）（Its；それ）
#
# TODO ここにシナリオを読取る処理を移動したい
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 下に居る猿
func sub_monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 選択肢と移動先
var cached_choices_mappings = {}


# ーーーーーーーー
# 時計
# ーーーーーーーー

func on_process(delta):
	self.sub_monkey().clock().on_process(delta)


# ーーーーーーーー
# プロパティーズ
# ーーーーーーーー

# 現在の部門変数
func get_current_department_value():
	return self.sub_monkey().of_programmer().owner_node().get_department_value(
			self.sub_monkey().of_programmer().owner_node().current_department_name)


# 現在の「¶」段落設定
func set_current_paragraph(paragraph_name):
	self.sub_monkey().paragraph_helper_node().set_current_paragraph(paragraph_name)


# 各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示
func dump_last_displayed_message_window():
	pass
	#print("［台本再生機］　各部門が最後に開いていたメッセージ・ウィンドウ名の一覧を表示")
	#
	## 部門名一覧
	#var department_names = self.sub_monkey().of_programmer().get_all_department_names()
	#for department_name in 	department_names:
	#	print("　　部門：　" + department_name)
	#
	#	# 部門変数
	#	var department = self.sub_monkey().of_programmer().owner_node().get_department_value(department_name)
	#
	#	for window_name in department.node_names_of_currently_displayed_message_window:
	#		print("　　　　👁 " + window_name)


# ーーーーーーーー
# アクセッサ―
# ーーーーーーーー

# 指定の部門下の choices_mappings 辞書を全てマージして返します。
# この処理は、最初の１回は動作が遅く、その１回目でメモリを多く使います
func get_merged_choices_mappings(department_name):
	# キャッシュになければ探索
	if not (department_name in self.cached_choices_mappings):

		# ［📗～］ノードの位置が変わっていることがあるので探索する
		var book_node = MonkeyHelper.search_descendant_node_by_name_str(
				self.sub_monkey().of_staff().scenario_writer().owner_node(),
				str(department_name))
		self.cached_choices_mappings[department_name] = {}

		MonkeyHelper.search_descendant_within_member(
				"choices_mappings",
				book_node,
				func(child_node):
					self.cached_choices_mappings[department_name].merge(child_node.choices_mappings))

	return self.cached_choices_mappings[department_name]


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー

# 「¶」段落の再生
func play_paragraph():
	var department_value = self.get_current_department_value()
	var message_window_gui = self.sub_monkey().get_current_message_window_gui()

	# 全部消化済みの場合
	if self.sub_monkey().scenario_helper_node().get_current_paragraph_array_size() <= message_window_gui.paragraph_item_index:
		print("［シナリオ再生エンジン］（" + department_value.name + "　" + department_value.paragraph_name + "）　段落を読み終わっている")

		# かつ、コンプリート中の場合、ユーザー入力を待つ
		if message_window_gui.statemachine_of_message_window.is_completed():
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.paragraph_name + "）　全消化済みだが、コンプリート中だから、勝手に何もしない。ユーザー入力を待つ")
			# 自動で何かしない
			return

	# パースを開始してよくないケースもあるが？
	# バッファーが残ってるときとか
	if not message_window_gui.has_text_block_buffer():
		# Completed 時もパース始めたらよくない
		if not message_window_gui.statemachine_of_message_window.is_completed():
			# TODO 選択肢のときもややこしいが
			print("［シナリオ再生エンジン］（" + department_value.name + "　"+ department_value.paragraph_name + "）　パースを開始してよい（本当か？）")
			# パースを開始してよい
			department_value.set_parse_lock(false)


# 伝言窓で選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected(row_number):
	print("［助監］　選択肢を確定させた")

	# 伝言窓の状態遷移
	#	ずっと Completed だと、困るから
	print("［助監］　伝言窓を　オール・ページズ・フラッシュド　する")
	self.sub_monkey().get_current_message_window_gui().statemachine_of_message_window.all_pages_flushed()


	var department_value = self.get_current_department_value()
	var department_name = str(department_value.name)
	var paragraph_name = department_value.paragraph_name
	
	print("［助監］　現在の部門名　　　：" + department_name)
	print("［助監］　現在の段落名　　　：" + paragraph_name)
	print("［助監］　選んだ選択肢行番号：" + str(row_number))

	# 辞書
	var choices_mappings_a = self.get_merged_choices_mappings(department_name)

	# 段落配列。実質的には選択肢の配列
	var paragraph_obj = choices_mappings_a[paragraph_name]

	# 次の段落名
	var next_paragraph_name = paragraph_obj[row_number]
	print("［助監］　次の段落名　　　　：" + next_paragraph_name)
	
	self.set_current_paragraph(next_paragraph_name)
	self.play_paragraph()
