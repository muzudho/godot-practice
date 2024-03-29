# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
extends Node


# 台本
#
# 	- この scenario_document` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#	- この書き方だと、実はインデントのタブが台詞データとして入っていますが、プログラム側で省きます
#
var scenario_document = {
	"¶システムメニュー画面":[
		"""\
		!
		# 先にメッセージ・ウィンドウを指定してから、選択肢を設定してください
		msg_wnd:		■中央
		choice:		1,2
		""",
		"""\
		　・再開
		　・終了
		""",
	],
	# 再開するなら
	"¶再開" : [
		# 部門変更
		"""\
		!
		department:	📗会話部門_🍉VisualNovel
		""",
	],
	# 終わるなら
	"¶終了" : [
		"""\
		!
		msg_wnd:		■中央, hide
		quit:
		"""
	],
}
