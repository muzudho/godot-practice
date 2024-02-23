# プログラマー　＞　インプット　＞　バーチャル（Virtual；実際上）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../../🐵Monkey"

# オーナー取得
func owner_node():
	return $"../../🕹️Input"


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
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func parse_virtual_button_input(vk_name, paragraph_obj):
	
	# まず、ボタンの押下状態を確認
	var button_process = self.owner_node().get_key_process(vk_name)

	# 押下されており、段落にも記述があるなら	
	if button_process == &"Pressed" && vk_name in paragraph_obj:
		#print("［入力　シナリオ再生中の入力で］　［" + str(vk_name) + "］ボタン押下。段落：" + str(paragraph_obj) + "の中に見つかりました")
		
		var target = paragraph_obj[vk_name]
		
		if target != &"":
			print("［入力　シナリオ再生中の入力で］　［" + str(vk_name) + "］ボタン押下。［" + str(target) + "］へ飛ぶ")
			self.monkey().of_staff().programmer().get_instruction_node(&"📗Goto").goto(target)
			# ［シナリオで］状態に戻す
			self.monkey().owner_node().current_state = &"InScenario"
		
	#else:
	#	print("［入力　シナリオ再生中の入力で］　入力：" + str(vk_name) + " は、選択肢：" + str(paragraph_obj) + "の中に見つかりませんでした")


# 仮想キー（レバー）の入力をさばく
func parse_virtual_lever_input(paragraph_obj):
	var target = paragraph_obj
	
	# まず、上下を確認
	var down_lever_value = self.owner_node().get_key_state(&"VK_Down")
	
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
		var right_lever_value = self.owner_node().get_key_state(&"VK_Right")

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
