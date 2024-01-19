# スタッフ（Staff；制作者）
extends Node2D


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# ディレクター・ハブ取得
func monkey():
	return $"🐵Monkey"


# ーーーーーーーー
# 初期化
# ーーーーーーーー


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# キャッシュを作成するだけ
	var _all_instruction_code = self.monkey().programmer().scenario_player().get_all_instruction_codes()

	# ーーーーーーーー
	# 非表示
	# ーーーーーーーー
	#
	# 開発中にいじったものが残ってるかもしれないから、掃除
	
	# グリッドは隠す
	self.monkey().grid().hide()
	
	# イラストレーターはとにかく隠す
	MonkeyHelper.search_in_folder(
			self.monkey().illustrator(),		# 探す場所
			func(child_node):
				return child_node is Sprite2D,
			func(child_node):
				child_node.hide())
	
	# テロップはとにかく非表示にする
	MonkeyHelper.search_in_folder(
			self.monkey().telop_coordinator(),		# 探す場所
			func(child_node):
				return child_node is CanvasLayer,
			func(child_node):
				child_node.hide())

	self.monkey().programmer().key_config_node().ready_in_staff()

	# ーーーーーーーー
	# 表示
	# ーーーーーーーー
	
	# 監督自身
	self.show()
	# イラストレーター
	self.monkey().illustrator().show()
	# テロップ
	self.monkey().telop_coordinator().show()


# ーーーーーーーー
# その他
# ーーーーーーーー


func on_key_config_entered():
	# 背景
	self.monkey().programmer().owner_node().images.find_node("🗻崎川駅前").visible = true


func on_key_config_exited():
	self.monkey().programmer().owner_node().current_state = &"Ready"


# テキストボックスなどにフォーカスが無いときのキー入力を拾う
#
# 子要素から親要素の順で呼び出されるようだ。
# このプログラムでは　ルート　だけで　キー入力を拾うことにする
func _unhandled_key_input(event):

	# キー・コンフィグのために、何もするな
	if self.monkey().programmer().owner_node().current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグ中なので、何もするな
	elif self.monkey().programmer().owner_node().current_state == &"KeyConfig":
		pass

	# 主要な状態
	elif self.monkey().programmer().owner_node().current_state == &"Main":

		var vk_operation = null

		# 何かキーを押したとき
		if event.is_pressed():
			print("［監督］　キー入力　押下")
			vk_operation = &"VKO_Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			print("［監督］　キー入力　リリース")
			vk_operation = &"VKO_Released"
		
		# それ以外には対応してない
		else:
			print("［監督］　キー入力　▲！想定外")
			return

		# 以下、仮想キー

		# このゲーム独自の仮想キーに変換
		var virtual_key_name = null
		
		# エンターキー押下
		if event.keycode == KEY_ENTER:
			virtual_key_name = &"VK_Ok"

		# エスケープキー押下
		elif event.keycode == KEY_ESCAPE:
			virtual_key_name = &"VK_Cancel"

		# ［Ｒ］キー押下（後でスーパーファミコンの R キーにしようと思っていたアルファベット）
		elif event.keycode == KEY_R:
			virtual_key_name = &"VK_FastForward"
		
		# それ以外のキーは無視する（十字キーや Ctrl キーの判定を取り除くのが難しい）
		else:
			return

		var lever_value = 0.0

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# テキストボックスなどにフォーカスが無いときの入力をとにかく拾う
func _unhandled_input(event):

	# キー・コンフィグのために何もするな、という状態
	if self.monkey().programmer().owner_node().current_state == &"WaitForKeyConfig":
		pass

	# キー・コンフィグに入力の制御を譲れ、という状態
	elif self.monkey().programmer().owner_node().current_state == &"KeyConfig":
		self.monkey().programmer().key_config_node().on_unhandled_input(event)

	# 主な状態
	elif self.monkey().programmer().owner_node().current_state == &"Main":

		var vk_operation = null

		# 何かキーを押したとき
		if event.is_pressed():
			#print("［監督］　入力　押下")
			vk_operation = &"VKO_Pressed"
		
		# 何かキーを離したとき
		elif event.is_released():
			#print("［監督］　入力　リリース")
			vk_operation = &"VKO_Released"
		
		# それ以外には対応してない
		else:
			print("［監督］　入力　▲！想定外")
			return

		# ーーーーーーーー
		# 以下、仮想キー
		# ーーーーーーーー
		# 文字列だけだと、押したのか放したのか分からない
		var event_as_text = event.as_text()
		
		# 文字列をボタン番号に変換
		var button_number = self.monkey().programmer().key_config_node().get_button_number_by_text(event_as_text)
		
		# ボタン番号を、仮想キー名に変換
		var virtual_key_name = self.monkey().programmer().key_config_node().get_virtual_key_name_by_button_number(button_number)

		# レバー値
		var lever_value = self.monkey().programmer().key_config_node().get_lever_value_by_text(event_as_text)

		# 仮想キーを押下したという建付け
		self.on_virtual_key_input(virtual_key_name, lever_value, vk_operation)


# 仮想キーを押下したという建付け
#
# 呼出し元:
# 	_unhandled_key_input()
#	_unhandled_input()
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if self.monkey().scenario_writer().on_virtual_key_input(
			virtual_key,
			lever_value,
			vk_operation):
		# 入力されたキーへの対処が完了したなら、処理を抜ける
		return

	# シナリオライター・ハブで　この入力をスルーしたなら、以降の処理を続ける
	print("［監督］　仮想キー（" + virtual_key + "）　レバー値：" + str(lever_value) + "　操作：" + vk_operation)

	# メッセージ・ウィンドウへ渡す
	self.monkey().programmer().scenario_player().get_current_message_window_gui().on_virtual_key_input(virtual_key, lever_value, vk_operation)
