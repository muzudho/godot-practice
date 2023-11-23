extends Node2D


class_name MessageWindowProgram


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー


# 状態機械
var statemachine_of_message_window = load("res://🍋scripts/🪑grayscale_🍉visual_novel/🍱message_windows/statemachines/message_window.gd").new()

# ページ送り時の対応関数
var on_message_window_page_forward = func():
	pass

# 可視性
var is_appear = true

# メッセージ・スピード（１秒当たりの文字数）
var msg_speed = 20.0

# テキストブロック汎用
#	セクションの何番目（０開始）を次に読込むか
var section_item_index = 0
#	表示したい文章
var text_block_buffer = ""
#	タイプライターのカウント
var count_of_typewriter = 0

# 選択肢
#	選択肢の行番号用配列。無ければヌル
var choices_row_numbers = null
#	選択肢配列のインデックス
var choices_index = 0
