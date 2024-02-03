# メッセージ・ウィンドウズ・モンキー（Message Windows Monkey；伝言窓たちの猿）
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# ノード・パス関連
# ーーーーーーーー


# 自身取得
func monkey():
	return self


# 監督ハブ取得
func of_staff():
	return MonkeyHelper.find_ancestor_child(
			self,
			&"👥Staff/🐵Monkey",
			self.ancestors)


# キャンバス・レイヤー取得
func get_canvas_layer(message_window_name):
	return self.monkey().of_staff().programmer().owner_node().telops.find_node("MessageWindow_" + message_window_name)


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
