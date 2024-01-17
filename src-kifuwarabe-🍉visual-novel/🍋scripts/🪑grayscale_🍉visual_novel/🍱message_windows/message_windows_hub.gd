# メッセージ・ウィンドウズ・ハブ（Message Windows Hub；メッセージ・ウィンドウの中心地）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}

# メッセージの早送り
var is_fast_forward = false


# ーーーーーーーー
# パス関連
# ーーーーーーーー


# 監督ハブ取得
func get_director_hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"🌏Director/🛩️Hub",
			self.ancestors)


# キャンバス・レイヤー取得
func get_canvas_layer(message_window_name):
	return self.get_director_hub().programmer_hub().telops.find_node("MessageWindow_" + message_window_name)


# テキストブロック
func get_text_block(message_window_name):
	return self.get_canvas_layer(message_window_name).get_node("TextBlock")


# 三角形の文末ブリンカー
func get_blinker_triangle(message_window_name):
	return self.get_canvas_layer(message_window_name).get_node("TextBlock/BlinkerTriangle")


# 下線の文末ブリンカー
func get_blinker_underscore(message_window_name):
	return self.get_canvas_layer(message_window_name).get_node("TextBlock/BlinkerUnderscore")


# 選択肢カーソル
func get_choices_cursor(message_window_name):
	return self.get_canvas_layer(message_window_name).get_node("TextBlock/ChoicesCursor")


# ーーーーーーーー
# その他
# ーーーーーーーー


## 先頭行と、それ以外に分けます
#func split_head_line_or_tail(text):
#	# 最初の改行を見つける
#	var index = text.find("\n")
#	var head = text.substr(0, index)
#	var tail = text.substr(index+1)
#
#	#print("［伝言窓］　head：　[" + head + "]")
#	#print("［伝言窓］　tail：　[" + tail + "]")
#
#	return [head, tail]
