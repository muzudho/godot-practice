# チョイスズ・マッピングス（Choices Mappings；選択肢の紐づけ）
extends Node


# 選択肢と飛び先
#
# 	- この `choices_mappings` という変数名は変えないでください
#	- ファイル名は変えても構いません
#	- `📗～部門` ノードにぶら下がっているファイルを読みに行きます
#
var choices_mappings = {

	# このキーは［セクション名］と呼ぶことにします
	#
	#	- 頭に「§」を付けているのは見やすさのためで、付けなくても構いません
	#	- `📗～部門` ノードにぶら下がっている他のファイルの `choices_mappings` のセクション名と被らないように運用してください
	#
	"§タイトル画面" : {
		# 選択肢の行番号と、移動先の［セクション名］
		1 : "§はじまり",
		2 : "§終了",
	},
	"§崎川市最強振興会館" : {
		1 : "§６筋の７段目の駒を６段目に突く",
		2 : "§角道を止める",
	},
}
