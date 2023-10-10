#	ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


#	関数
var set_message_window_waiting_for_order = null


func before_initialize(set_message_window_waiting_for_order):
	self.set_message_window_waiting_for_order = set_message_window_waiting_for_order


#	それをする
func do_it(temp_text):
	self.put_message(temp_text)


func put_message(temp_text):
	# メッセージ・ウィンドウの表示
	$"../../GuiArtist/WindowsOfMessage".push_message(temp_text)

	self.set_message_window_waiting_for_order.call(false)
