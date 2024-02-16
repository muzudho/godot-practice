# ノーマル・テキスト・チョイス（Normal Text Choice;通常テキスト選択肢）
#
# `📘` （青い本）で始まる名前の命令は、ハードコーディングされています
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー

# 命令名
var code = ""


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

var ancestor_children_dictionary = {}


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー

# プログラマーズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤Programmer/🐵Monkey",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー

# それをする
func do_it(
		temp_text):		# str

	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# 変数展開
	var presentable_text = self.monkey().owner_node().expand_variables(temp_text.strip_edges())

	# デパートメント・オブジェクト
	var department_value = self.monkey().scenario_player_node().get_current_department_value()
	
	# メッセージ・ウィンドウ・オブジェクト
	var message_window_gui = self.monkey().scenario_player().get_current_message_window_gui_node()

	print("［命令　選択肢テキスト］　部門：［" + str(department_value.name) + "］　メッセージ：[" + presentable_text + "]")

	# メッセージ追加
	message_window_gui.remember(presentable_text)

	# 会話開始
	self.monkey().scenario_player().get_current_message_window_gui_node().statemachine_of_message_window.talk()

	# パースをするな
	department_value.set_parse_lock(true)
