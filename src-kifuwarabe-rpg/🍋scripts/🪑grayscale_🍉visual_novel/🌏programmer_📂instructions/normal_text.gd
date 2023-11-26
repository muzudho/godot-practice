# ノーマル・テキスト（Normal Text；通常テキスト）
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
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🛩️Hub",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(temp_text):
	self.put_textblock(temp_text)


# メッセージ追加、会話開始
func put_textblock(
		temp_text):		# str

	# 変数展開
	temp_text = self.hub().expand_variables(temp_text.strip_edges())

	# メッセージの追加
	var department_value = self.hub().get_current_department_value()
	var message_window_gui = self.hub().get_current_message_window_gui()

	message_window_gui.remember(temp_text)

	# 会話の開始
	self.hub().get_current_message_window_gui().statemachine_of_message_window.talk()

	# パースをするな
	department_value.set_parse_lock(true)
