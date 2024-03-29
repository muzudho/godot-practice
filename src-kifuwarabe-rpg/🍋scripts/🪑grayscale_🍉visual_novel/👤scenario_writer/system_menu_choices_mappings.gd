# チョイスズ・マッピングス（Choices Mappings；選択肢の紐づけ）
extends Node


# 選択肢と飛び先
#
# 	- この `choices_mappings` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#
var choices_mappings = {

	# このキーは［段落名］と呼ぶことにします
	#
	#	- 頭に「¶」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの `choices_mappings` の段落名と被らないように運用してください
	#
	"¶システムメニュー画面" : {
		# 選択肢の行番号と、移動先索引
		1 : "¶再開",
		2 : "¶終了",
	},
}
