# デパートメント・スナップショット（Department Snapshot；部門の瞬間の状態）
extends Object

class_name DepartmentSnapshot


# 「§」セクション名
var section_name = null

# 部門名。StringName 型
var name = null

# パースをするな
var parse_lock_flag = true

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null

# テキストブロック汎用
#	セクションの何番目（０開始）を次に読込むか
var section_item_index = 0
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 伝言窓のノード名。最後に表示した伝言窓をカレントにするために、スタック構造をしている。文字列ではなく StringName 型
var stack_of_last_displayed_message_window = [] # TODO 新仕様

# 現在表示中の伝言窓のノード名（StringName型）
#	`m_wnd *` コマンドで追加、 `m_wnd, hide` コマンドで除外
var node_names_of_currently_displayed_message_window = []

# メッセージ・スピード（１秒当たりの文字数）
var msg_speed = 20.0


# パースをするな
func set_parse_lock(flag):
	self.parse_lock_flag = flag


# パース禁止か？
func is_parse_lock():
	return self.parse_lock_flag


# 選択肢か？
func is_choices():
	return self.choices_row_numbers != null


# テキストブロックのバッファーが残っているか？
func has_text_block_buffer():
	return 0 < self.text_block_buffer.length()


# メッセージを記録するだけ
func remember(
	new_text):		# str

	# 設定
	self.text_block_buffer = new_text

	# 選択肢なら
	if self.is_choices():
		print("［部門スナップ写　”" + self.name + "”］　リメンバー　選択肢：[" + new_text + "]")

	# それ以外なら
	else:
		print("［部門スナップ写　”" + self.name + "”］　リメンバー　台詞：[" + new_text + "]")


# 現在開いているメッセージ・ウィンドウ名を追加
func append_currently_displayed_message_window(
		node_name):		# StringName
	self.node_names_of_currently_displayed_message_window.append(node_name)


# 現在開いているメッセージ・ウィンドウ名を除去
func remove_currently_displayed_message_window(
		node_name):		# StringName
	var index = self.node_names_of_currently_displayed_message_window.find(node_name)
	if 0<=index:
		self.node_names_of_currently_displayed_message_window.remove_at(index)
