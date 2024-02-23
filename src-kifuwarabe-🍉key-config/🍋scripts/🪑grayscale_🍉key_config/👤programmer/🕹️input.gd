# from 🍉KeyConfig
# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# 拡張ノード取得
func extension_node():
	return $"Extension"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 仮想キーのこの瞬間の入力状態
#
# 	キー：　プログラム内で決まりを作っておいてください。
# 	値：
#		ボタン：　押していないとき 0、押しているとき 1
#		レバー：　実数
#
var key_state = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : 0,
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : 0,
	# メッセージ早送りボタン
	&"VK_FastForward" : 0,
	# レバーの左右
	&"VK_Right" : 0,
	# レバーの上下
	&"VK_Down" : 0,
}

# 仮想キーの入力状態の変化の種類
#
# 	キー：　プログラム内で決まりを作っておいてください。
#	値：
#		&"Release?"：　ボタン、レバー等から指を離して、押されている状態から、ホーム位置にある状態へ遷移している途中（省略されることがあります）
#		&"Released"：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態に到達した最初のフレーム
#		&"Neutral" ：　ボタン、レバー等から指を離して、ボタンやレバーがホーム位置にある状態で、その状態の２フレーム目以降
#		&"Press?"  ：　ボタン、レバー等が、ホーム位置にあった状態から、押されている状態へ遷移している途中（省略されることがあります）
#		&"Pressed" ：　ボタン、レバー等が、押されている状態に到達した最初のフレーム
#		&"Pressing"：　ボタン、レバー等が、押されている状態で、その状態の２フレーム目以降
#		初期値は &"Neutral" とする
#
var key_process = {
	# 決定ボタン、メッセージ送りボタン
	&"VK_Ok" : &"Neutral",
	# キャンセルボタン、メニューボタン
	&"VK_Cancel" : &"Neutral",
	# メッセージ早送りボタン
	&"VK_FastForward" : &"Neutral",
	# レバーの左右
	&"VK_Right" : &"Neutral",
	# レバーの上下
	&"VK_Down" : &"Neutral",
}

# ーーーーーーーー
# 仮想キーの入力をさばく
# ーーーーーーーー
#
# paragraph_obj の例
# =================
#
#	ボタンの押下状態や、レバーの方向によって、飛び先の段落名を指定します
#
#{
#	"¶青森県" : {
#		# ボタン押下
#		&"VK_Ok" : "¶確定",
#		# ナナメ入力は、 &"VK_Down" の中に &"VK_Right" を入れる順番にしてください
#		&"VK_Down" : {
#			# レバーは + - も指定
#			&"-" : "¶北海道",
#			&"+" : {
#				# ナナメ入力があるときに、ナナメ入力でない上下方向があるなら、バーチャル・キー名を空文字列にしてください
#				&"" : "¶秋田県",
#				&"VK_Right" : {
#					&"+" : "¶岩手県",
#				},
#			},
#		},
#	},
#},

# 仮想キー（ボタン）の入力をさばく
func parse_virtual_button_input(virtual_key_name, paragraph_obj):
	
	# まず、ボタンの押下状態を確認
	var button_process = self.key_process[virtual_key_name]

	# 押下されており、段落にも記述があるなら	
	if button_process == &"Pressed" && virtual_key_name in paragraph_obj:
		#print("［入力　シナリオ再生中の入力で］　［" + str(virtual_key_name) + "］ボタン押下。段落：" + str(paragraph_obj) + "の中に見つかりました")
		
		var target = paragraph_obj[virtual_key_name]
		
		if target != &"":
			print("［入力　シナリオ再生中の入力で］　［" + str(virtual_key_name) + "］ボタン押下。［" + str(target) + "］へ飛ぶ")
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
			# ［シナリオで］状態に戻す
			self.monkey().owner_node().current_state = &"InScenario"
		
	#else:
	#	print("［入力　シナリオ再生中の入力で］　入力：" + str(virtual_key_name) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりませんでした")


# 仮想キー（レバー）の入力をさばく
func parse_virtual_lever_input(paragraph_obj):
	var target = paragraph_obj
	
	# まず、上下を確認
	var down_lever_value = self.key_state[&"VK_Down"]
	
	# 上下方向に入力があり、段落にも上下方向の記述があるか？
	if 0 != down_lever_value && &"VK_Down" in target:
		# その下の要素へ移動
		target = target[&"VK_Down"]
		print("［入力　シナリオ再生中の入力で　レバー］　上下方向の入力［" + str(down_lever_value) + "］があり、段落にも上下方向の記述がある。段落：" + str(target))

		# 上方向にレバーが倒れており、段落にも上方向の記載があるか？
		if down_lever_value < 0 && &"-" in target:
			# ［上方向］へ移動（飛び先の段落名だ）
			target = target[&"-"]
			print("［入力　シナリオ再生中の入力で　レバー］　上向きの入力［" + str(down_lever_value) + "］があり、段落にも上向きの記述がある。段落：" + str(target))
		
		# 下方向にレバーが倒れており、段落にも下方向の記載があるか？
		elif 0 < down_lever_value && &"+" in target:
			# ［下方向］へ移動
			#
			#　まだ、以下のどちらか確定していない
			#	- 辞書
			#	- 飛び先の段落名
			target = target[&"+"]
		
			if typeof(target) == TYPE_DICTIONARY:
				print("［入力　シナリオ再生中の入力で　レバー］　下向きの入力［" + str(down_lever_value) + "］があり、段落にも下向きの記述がある。段落：" + str(target))

			else:
				print("［入力　シナリオ再生中の入力で　レバー］　下向きの入力［" + str(down_lever_value) + "］があった。飛び先：" + str(target))
		
		else:
			# 段落に記述のない入力方向なので、関数を抜けます
			#print("［入力　シナリオ再生中の入力で　レバー］　レバーの向きの記述がなかった。段落：" + str(target))
			return
	
	# ターゲットが名前型（段落名）ではないなら
	if typeof(target) == TYPE_DICTIONARY:

		# 次に、左右を確認
		var right_lever_value = self.key_state[&"VK_Right"]

		# 左右方向には入力が無いか？
		if 0 == right_lever_value:
			
			# 段落は辞書型で、キーが空文字列のものを含むか？
			if typeof(target) == TYPE_DICTIONARY:
				if &"" in target:
					# FIXME ここにはこない？？
					# それを選ぶ（飛び先の段落名だ）
					target = target[&""]
				elif "" in target:
					# それを選ぶ（飛び先の段落名だ）
					target = target[""]
				
				#print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述があった。次の段落：" + str(target))
			
			#else:
			#	print("［入力　シナリオ再生中の入力で　レバー］　左右方向に入力がなく、段落にも左右方向に入力がないときの記述がないから無視します。 right_lever_value:［" + str(right_lever_value) + "］　段落：" + str(target))
		
		# 左右方向に入力があり、段落にも左右方向の記述があるか？
		elif &"VK_Right" in target:
			# その下の要素へ移動
			target = target[&"VK_Right"]
			print("［入力　シナリオ再生中の入力で　レバー］　左右方向の入力［" + str(right_lever_value) + "］があり、段落にも左右方向の記述がある。段落：" + str(target))

			# 左方向にレバーが倒れており、段落にも左方向の記載があるか？
			if right_lever_value < 0 && &"-" in target:
				# ［左方向］へ移動（飛び先の段落名だ）
				target = target[&"-"]
				print("［入力　シナリオ再生中の入力で　レバー］　左向きの入力［" + str(right_lever_value) + "］があり、段落にも左向きの記述がある。段落：" + str(target))
			
			# 右方向にレバーが倒れており、段落にも右方向の記載があるか？
			elif 0 < right_lever_value && &"+" in target:
				# ［右方向］へ移動（飛び先の段落名だ）
				target = target[&"+"]
				print("［入力　シナリオ再生中の入力で　レバー］　右向きの入力［" + str(right_lever_value) + "］があり、段落にも右向きの記述がある。段落：" + str(target))

			else:
				# 段落に記述のない入力方向なので、関数を抜けます
				print("［入力　シナリオ再生中の入力で　レバー］　レバーの向きの記述がなかった。関数を抜けます。段落：" + str(target))
				return
	
	if typeof(target) == TYPE_STRING || typeof(target) == TYPE_STRING_NAME:
		print("［入力　シナリオ再生中の入力で］　レバー入力。［" + str(target) + "］へ飛ぶ")
		self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
		# ［シナリオで］状態に戻す
		self.monkey().owner_node().current_state = &"InScenario"
		
	else:
		#if typeof(target) == TYPE_DICTIONARY:
		#	print("［入力　シナリオ再生中の入力で］　レバー入力を検知できなかったので無視します。 辞書の中身:［" + str(target) + "］")
		#else:
		#	print("［入力　シナリオ再生中の入力で］　レバー入力を検知できなかったので無視します。 typeof(target):［" + str(typeof(target)) + "］")
			
		return


# ーーーーーーーー
# 毎フレーム処理
# ーーーーーーーー

# 毎フレーム実行されるので、処理は軽くしたい
#
# 	入力されたキーが複数ある場合、 `_unhandled_input` が全部終わってから `_process` が呼出されることを期待する
#
func _process(delta):
	#print("［★プロセス］　delta:" + str(delta))

	# 仮想キーの状態変化の解析
	self.parse_key_process(&"VK_Ok")
	self.parse_key_process(&"VK_Cancel")
	self.parse_key_process(&"VK_FastForward")
	self.parse_key_process(&"VK_Right")
	self.parse_key_process(&"VK_Down")

	# 拡張
	self.extension_node().on_process(delta)
	
	# 仮想キーの入力状態のクリアー
	self.key_state[&"VK_Ok"] = 0
	self.key_state[&"VK_Cancel"] = 0
	self.key_state[&"VK_FastForward"] = 0
	self.key_state[&"VK_Right"] = 0
	self.key_state[&"VK_Down"] = 0


func parse_key_process(virtual_key_name):
	var old_process = self.key_process[virtual_key_name]
	var abs_old_state = abs(self.key_state[virtual_key_name])

	# 押すか、放すか、どちらかに達するまで維持します
	if old_process == &"Release?" || old_process == &"Press?":
		if 1 <= abs_old_state:
			print("［入力解析］　浮遊状態から押下確定")
			self.key_process[virtual_key_name] = &"Pressed"
		elif 0 == abs_old_state:
			print("［入力解析］　浮遊状態から解放確定")
			self.key_process[virtual_key_name] = &"Released"
	
	elif old_process == &"Released" || old_process == &"Neutral":
		if 1 <= abs_old_state:
			print("［入力解析］　解放状態から押下確定")
			self.key_process[virtual_key_name] = &"Pressed"
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　解放状態から押下浮遊")
			self.key_process[virtual_key_name] = &"Press?"
	
	elif old_process == &"Pressed" || old_process == &"Pressing":
		if 0 == abs_old_state:
			print("［入力解析］　押下状態から解放確定")
			self.key_process[virtual_key_name] = &"Released"
		elif 0 < abs_old_state && abs_old_state < 1:
			print("［入力解析］　押下状態から解放浮遊")
			self.key_process[virtual_key_name] = &"Release?"


# ーーーーーーーー
# 入力
# ーーーーーーーー

# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
#
#	X軸と Y軸は別々に飛んでくるので　使いにくい。斜め入力を判定するには `_process` の方を使う
#
func _unhandled_input(event):
	# キー入力を受け取り、その状態を記憶します
	self.memory_key_state(event)

	# 拡張
	self.extension_node().on_handled_input(event)


# キー入力を受け取り、その状態を記憶します
func memory_key_state(event):
	print("［入力　シナリオ再生中の入力で　アンハンドルド・インプット］　event:" + event.as_text())
	var button_number = self.monkey().key_config().input_parser_node().get_button_number_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　button_number:" + str(button_number))
	var lever_value = self.monkey().key_config().input_parser_node().get_lever_value_by_text(event.as_text())
	#print("［入力　シナリオ再生中の入力で］　lever_value:" + str(lever_value))

	var virtual_key_name = self.monkey().key_config_node().get_virtual_key_name_by_button_number(button_number)
	#print("［入力　シナリオ再生中の入力で］　virtual_key_name:" + str(virtual_key_name))

	if virtual_key_name == &"VK_Ok":
		self.key_state[&"VK_Ok"] = 1

	elif virtual_key_name == &"VK_Cancel":
		self.key_state[&"VK_Cancel"] = 1

	elif virtual_key_name == &"VK_FastForward":
		self.key_state[&"VK_FastForward"] = 1

	elif virtual_key_name == &"VK_Right":
		self.key_state[&"VK_Right"] = lever_value

	elif virtual_key_name == &"VK_Down":
		self.key_state[&"VK_Down"] = lever_value
