# メッセージ・スピード（Msg Speed, Message Speed；眠る）
#
# `📗` （緑の本）で始まる名前の命令は、アドオンです
#
# 秒間何文字表示する
extends Node


# ーーーーーーーー
# ピックアップ
# ーーーーーーーー


# 命令名
var code = "msg_speed:"


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


var monkey = Monkey.new()


# ーーーーーーーー
# 親パス関連
# ーーーーーーーー


# プログラマーズ・ハブ取得
func hub():
	return monkey.find_ancestor_child(
			self,
			"🛩️ProgramsHub")


# ーーーーーーーー
# その他
# ーーーーーーーー


# それをする
func do_it(line):

	var csv = line.substr(self.code.length()).strip_edges()
	print("［命令　スリープ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var characters_per_second = float(self.hub().expand_variables(string_packed_array[0].strip_edges()))

	self.set_message_speed(characters_per_second)


# 秒間何文字表示に設定する
func set_message_speed(characters_per_second):
	print("［命令　伝言速度］　秒間：[" + str(characters_per_second) + "]文字")
	var message_window_gui = self.hub().get_current_message_window_gui()
	message_window_gui.msg_speed = characters_per_second
	
