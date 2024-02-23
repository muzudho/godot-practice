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
# 	programmer/input/_unhandled_key_input()
#
# Parameters
# ==========
# * `vk_name` - Virtual key name
func on_virtual_key_input(
		vk_name,
		vk_state,
		vk_occurence,
		vk_during):

	# 現在のデパートメントに紐づく、項目は辞書に記載されているか？
	if self.monkey().of_staff().programmer().department_controller_node().sub_monkey().input_node().on_virtual_key_input(
			vk_name,
			vk_state,
			vk_occurence,
			vk_during):
		# 入力されたキーへの対処が完了したなら、処理を抜ける
		return

	# シナリオライター・ハブで　この入力をスルーしたなら、以降の処理を続ける
	print("［台本再生機］　仮想キー（" + vk_name + "）　レバー値：" + str(vk_state) + "　vk_occurence:" + vk_occurence + " vk_during:" + vk_during)

	# メッセージ・ウィンドウへ渡す
	self.monkey().of_programmer().scenario_player().get_current_message_window_gui_node().on_virtual_key_input(
			vk_name,
			vk_state,
			vk_occurence,
			vk_during)
