# ユーザー・デファインド・ファイル（User defined file；利用者定義書類）
#
#	Note: 戦闘テスト用に改造している
extends Node


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー

# シナリオライターズ・ハブ取得
func monkey():
	return MonkeyHelper.find_ancestor_child(
			self,
			"👤ScenarioWriter/🐵Monkey_🍉VisualNovel",
			self.ancestor_children_dictionary)


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

var ancestor_children_dictionary = {}


# ーーーーーーーー
# その他
# ーーーーーーーー

# 台本
#
# 	- この scenario_document` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#	- この書き方だと、実はインデントのタブが台詞データとして入っていますが、プログラム側で省きます
#
var scenario_document = {

	# このキーは［段落名］と呼ぶことにします
	#
	#	- 頭に「¶」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの scenario_document` の段落名と被らないように運用してください
	#
	"¶タイトル画面":[
		"""\
		!
		bg_music:	🎵タイトル
		telop:		Ｔタイトル
		img:		🗻崎川駅前
		# 先にメッセージ・ウィンドウを指定してから、選択肢を設定してください
		msg_wnd:	■下
		choice:		1,2
		""",
		"""\
		　・スタート
		　・終了
		""",
	],
	# 終わるなら
	"¶終了" : [
		"""\
		!
		quit:
		"""
	],
	# ゲーム開始
	"¶はじまり":[
		"""\
		!
		telop:	Ｔタイトル, hide
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		戦闘シーンのテストをします
		""",
		# ツツジロード
		"""\
		!
		telop:		Ｔ崎川駅周辺地図, hide
		img:		🗻崎川駅周辺地図,hide
		img:		🗻ツツジロード
		img:		🐕ヘム将棋
		""",
		"""\
		ひよ子
		「あんな　ちんちくりんな生き物は
		　知らないわねえ
		""",
		# バトル部門へ飛ばします
		"""\
		!
		var:			battle_exit_department		,📗会話部門_🍉Battle
		var:			battle_exit_section			,¶崎川市最強振興会館
		department:		📗バトル部門_🍉Battle			,%ignorable%
		goto:			¶１回目戦闘シーン
		""",
		# バトル部門がなければ、直後の goto 文は１回無視され、以下へフォールスルー
		"""\
		＊
		「戦闘シーンは省略しまーす
		""",
		"""\
		!
		img:		🐕ヘム将棋, hide
		img:		🗻ツツジロード, hide
		goto:		¶崎川市最強振興会館
		"""
	],
	"¶崎川市最強振興会館":[
		"""\
		!
		bg_music:
		img:		🗻４Ｆイベントルーム
		""",
		# ２３４５６７８９０１２３４５６７８９０
		"""\
		戦闘テストを終了します
		""",
		"""\
		!
		bg_music:	🎵エンディング
		img:	🗻エンディング
		telop:	Ｔエンディング
		"""
	],
}
