#	ビジュアル・ノベル・デパートメント・マネージャー（Visual Novel Department Manager；ビジュアル・ノベル部管理人）
extends Node


var is_appear = false


#	居なくなる
func disappear():
	print("［ビジュアル・ノベル部］　隠す")
	is_appear = false
	
	#	表示中の［下］ウィンドウを隠す
	if $"../../../GuiArtist/WindowsOfMessage/下".visible:
		$"../../../GuiArtist/WindowsOfMessage/下".set_visible_subtree(false)

	#	ポーズ
	#		とりあえず、［下］メッセージ・ウィンドウを止めてみる
	#		is_processing は、初回は false
	if $"../../../GuiArtist/WindowsOfMessage/下".is_processing():
		$"../../../GuiArtist/WindowsOfMessage/下".set_process_subtree(false)
		

#	現れる
func appear():
	print("［ビジュアル・ノベル部］　表示")
	is_appear = true

	#	表示中の［下］ウィンドウを表示する
	if not $"../../../GuiArtist/WindowsOfMessage/下".visible:
		$"../../../GuiArtist/WindowsOfMessage/下".set_visible_subtree(true)

	#	再開
	if not $"../../../GuiArtist/WindowsOfMessage/下".is_processing():
		$"../../../GuiArtist/WindowsOfMessage/下".set_process_subtree(true)
