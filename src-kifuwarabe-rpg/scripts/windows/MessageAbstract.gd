#	アブストラクト・メッセージ・ウィンドウ（Abstract Message Window；抽象的な伝言窓）
#
#		このノードは常に visible にしておいてください
extends Node2D


#	状態遷移機械
var statemachine = load("res://scripts/statemachines/MessageWindow.gd").new()


#	メッセージを出力する対象となるノードの名前（文字列）
var concrete_message_window_name = null


#	アシスタント・ディレクターを取得
func get_assistant_director():
	return $"../../AssistantDirector"


#	音楽家を取得
func get_musician():
	return $"../../Musician"


func get_snapshot(department_node_name):
	return $"../../System/Snapshots".get_node(department_node_name)


#	初期化の前に
#		初期化の一種ですが、初期化より前に行います。
#		引数を渡すことが **初期化** との違いです
func before_initialize(concrete_message_window_name_obj, parent_statemachine):
	#	親からステートマシンを引き継ぐ
	self.get_node(str(concrete_message_window_name_obj)).statemachine = parent_statemachine

	#	子どもにもステートマシンを渡す
	self.get_node(str(concrete_message_window_name_obj)).get_node("CanvasLayer/TextBlock").before_initialize(self.statemachine)


#	初期化
#		ウィンドウが閉じた状態を想定しています
func initialize():
	print("［抽象メッセージ・ウィンドウ］　初期化　具体：" + self.concrete_message_window_name + "］")
	self.initialize_concrete_message_window(self.concrete_message_window_name)
	self.statemachine.all_page_flushed()


#	初期化
#		ウィンドウが閉じた状態を想定しています
func initialize_concrete_message_window(
	concrete_message_window_name):		# 文字列
		
	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　初期化（非表示）")

	# 子要素を初期化
	self.get_node(concrete_message_window_name).get_node("CanvasLayer/TextBlock").initialize()

	# この要素の初期状態は、非表示、透明
	self.get_node(concrete_message_window_name).hide()
	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　初期化による透明化")
	self.get_node(concrete_message_window_name).modulate.a = 0.0	# 初期化による透明化


#	空欄化
#		空っぽのウィンドウに戻すことを想定しています。
#		初期化の一種ですが、ウィンドウは消しません
func emptize():
	print("［抽象メッセージ・ウィンドウ］　クリアーテキスト　具体：［" + self.concrete_message_window_name + "］")

	#	空欄に戻します（ウィンドウは消しません）
	self.emptize_concrete_message_window(self.concrete_message_window_name)


#	空欄化
func emptize_concrete_message_window(
	concrete_message_window_name):		# 文字列

	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　空欄化")
	#	空欄に戻します（ウィンドウは消しません）
	self.get_node(concrete_message_window_name).get_node("CanvasLayer/TextBlock").emptize()


#	メッセージ出力先ウィンドウ変更。ノード名を指定
func redirect_concrete_message_window_by_name(node_name):

	# 以前のウィンドウは閉じる
	if self.concrete_message_window_name != null:
		self.get_concrete_message_window().initialize()

	print("［抽象メッセージ・ウィンドウ］　［" + node_name + "］メッセージ・ウィンドウへ　リダイレクト")
	
	# 新しいウィンドウ
	self.concrete_message_window_name = node_name
	
	# 初期化
	self.initialize_concrete_message_window(self.concrete_message_window_name)


#	メッセージ出力先ウィンドウのノード名
func get_concrete_message_window():
	return self.get_node(self.concrete_message_window_name)


#	選択肢カーソルを表示
func show_choice_cursor():
	print("［抽象メッセージ・ウィンドウ］　選択肢カーソル表示　具体：［" + self.concrete_message_window_name + "］")
	self.get_concrete_message_window().get_node("CanvasLayer/TextBlock/ChoiceCursor").show()


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


#	メッセージを追加
func push_message(text, choices_row_numbers = null):

	#	空っぽのウィンドウを残します
	self.emptize()

	#	選択肢なら
	if choices_row_numbers != null:
		print("［抽象メッセージ・ウィンドウ］　選択肢：[" + text + "]　具体：［" + self.concrete_message_window_name + "］")
		self.show_choice_cursor()

	#	それ以外なら
	else:
		print("［抽象メッセージ・ウィンドウ］　台詞：[" + text + "]　具体：［" + self.concrete_message_window_name + "］")

	#	表示
	self.show()
	self.get_concrete_message_window().show()
	self.get_concrete_message_window().get_node("CanvasLayer").show()

	#	メッセージ追加
	self.push_message_concrete(self.concrete_message_window_name, text, choices_row_numbers)

	#	タイプライター風表示へ状態遷移
	self.statemachine.scenario_seted()


#	メッセージ追加
func push_message_concrete(
	concrete_message_window_name,	# str
	text,							# str
	choices_row_numbers):			# number_array
		
	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　メッセージ追加（表示、不透明化）")
	self.get_node(concrete_message_window_name).get_node("CanvasLayer/TextBlock").push_message(text, choices_row_numbers)
	self.get_node(concrete_message_window_name).modulate.a = 1.0	# メッセージ追加による不透明化


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree(is_process):
	print("［抽象メッセージウィンドウ］　プロセッシング：" + str(is_process) + "　具体：［" + self.concrete_message_window_name + "］")

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.is_processing():
		self.set_process(is_process)

		#	子ノード
		for child in self.get_children():
			self.set_process_subtree_concrete(str(child.name), is_process)


#	サブツリーの is_process を設定。ポーズ（Pause；一時停止）の逆の操作
func set_process_subtree_concrete(
	concrete_message_window_name,	# str
	is_process):					# bool
		
	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　プロセッシング：" + str(is_process))

	#	処理しろ　（true） という指示のとき、処理していれば　　（true） 、何もしない（pass）。
	#	処理するな（false）という指示のとき、処理していれば　　（true） 、停止する　（false）。
	#	処理しろ　（true） という指示のとき、処理していなければ（false）、再開する　（true）。
	#	処理するな（false）という指示のとき、処理していなければ（false）、何もしない（pass）
	if is_process != self.get_node(concrete_message_window_name).is_processing():
		self.get_node(concrete_message_window_name).set_process(is_process)

		#	子ノード
		for child in self.get_node(concrete_message_window_name).get_node("CanvasLayer").get_children():
			if child.has_method("set_process_subtree"):
				child.set_process_subtree(is_process)


#	サブツリーの visible を設定
func set_visible_subtree_concrete(
	concrete_message_window_name,	# str
	is_visible):					# bool
		
	print("［”" + concrete_message_window_name + "”メッセージウィンドウ］　可視性：" + str(is_visible))

	#	見せろ（true） という指示のとき、見えてれば（true） 、何もしない（pass）。
	#	隠せ　（false）という指示のとき、見えてれば（true） 、隠す　　　（false）。
	#	見せろ（true） という指示のとき、隠れてれば（false）、見せる　　（true）。
	#	隠せ　（false）という指示のとき、隠れてれば（false）、何もしない（pass）
	if is_visible != self.visible:
		self.visible = is_visible

		#	子ノード
		for child in self.get_node(concrete_message_window_name).get_node("CanvasLayer").get_children():
			if child.has_method("set_visible_subtree"):
				child.set_visible_subtree(is_visible)


#	ページ送り
func on_page_forward():
	print("［抽象メッセージ・ウィンドウ］　ページ送り　具体：［" + self.concrete_message_window_name + "］")

	#	効果音
	self.get_musician().playSe("ページめくり音")

	#	空っぽのウィンドウを残して、次の指示を待ちます
	self.emptize()
	self.awaiting_order()


#	下位ノードで選択肢が選ばれたとき、その行番号が渡されてくる
func on_choice_selected():
	#	カーソル音
	self.get_musician().playSe("選択肢確定音")

	var row_number = self.get_concrete_message_window().get_node("CanvasLayer/TextBlock/ChoiceCursor").selected_row_number	
	print("［抽象メッセージ・ウィンドウ］　選んだ選択肢行番号：" + str(row_number) + "　具体：［" + self.concrete_message_window_name + "］")

	#	選択肢の行番号を、上位ノードへエスカレーションします
	self.get_assistant_director().on_choice_selected(row_number)


#	テキストボックスなどにフォーカスが無いときの入力を拾う
func on_unhandled_key_input(event):
	print("［抽象メッセージ・ウィンドウ］　アンハンドルド・キー入力")

	#	完全表示中
	if self.statemachine.is_completed():

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
					self.on_choice_selected()
					return
		
		#	それ以外なら
		else:
		
			#	何かキーを押したとき
			if event.is_pressed():
				
				if event.keycode == KEY_R:
					# print("［抽象メッセージ・ウィンドウ］　Ｒキーは、メッセージの早送りに使うので、メッセージ送りしません")
					return
				
				#	ページ送り
				self.on_page_forward()


func _ready():
	# このノードは常に visible にしておいてください
	self.show()

	#	全ての子どもにステートマシンを渡す
	for concrete_message_window in self.get_children():
		
		self.initialize_concrete_message_window(str(concrete_message_window.name))
		
		self.before_initialize(concrete_message_window.name, self.statemachine)
