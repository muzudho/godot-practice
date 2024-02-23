# インプット（Input；入力）
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# 猿取得
func monkey():
	return $"../🐵Monkey"


# ーーーーーーーー
# 入力
# ーーーーーーーー

# 仮想キーを押下したという建付け
#
# 呼出し元:
# 	on_unhandled_key_input()
#	on_unhandled_input()
func on_virtual_key_input(virtual_key, lever_value, vk_operation):

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if self.monkey().of_staff().programmer().department_controller_node().sub_monkey().input_node().on_virtual_key_input(
			virtual_key,
			lever_value,
			vk_operation):
		# 入力されたキーへの対処が完了したなら、処理を抜ける
		return

	# シナリオライター・ハブで　この入力をスルーしたなら、以降の処理を続ける
	print("［監督］　仮想キー（" + virtual_key + "）　レバー値：" + str(lever_value) + "　操作：" + vk_operation)

	# メッセージ・ウィンドウへ渡す
	self.monkey().of_programmer().scenario_player().get_current_message_window_gui_node().on_virtual_key_input(virtual_key, lever_value, vk_operation)
