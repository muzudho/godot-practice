# メッセージ・スピード（Msg Speed, Message Speed；眠る）
#	秒間何文字表示する
extends Node


# 助監
func get_assistant_director():
	return $"../../../AssistantDirector"


# それをする
func do_it(line):

	var csv = line.substr(10).strip_edges()
	print("［命令　スリープ］　CSV：[" + csv + "]")
	# 文字列の配列に分割
	var string_packed_array = csv.split(",", true, 0)

	var characters_per_second = float(self.get_assistant_director().expand_variables(string_packed_array[0].strip_edges()))

	self.set_message_speed(characters_per_second)


# 秒間何文字表示に設定する
func set_message_speed(characters_per_second):
	print("［命令　伝言速度］　秒間：[" + str(characters_per_second) + "]文字")
	var message_window_gui = self.get_assistant_director().get_director().get_current_message_window_gui()
	message_window_gui.msg_speed = characters_per_second
	
