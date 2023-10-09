#	ノーマル・テキスト（Normal Text；通常テキスト）
extends Node


#	それをする
func do_it(
	temp_text,
	set_message_window_waiting_for_order):

	# メッセージ・ウィンドウの表示
	$"../../GuiArtist/Windows".show()
	$"../../GuiArtist/Windows/Message".push_message(temp_text)

	set_message_window_waiting_for_order.call(false)
