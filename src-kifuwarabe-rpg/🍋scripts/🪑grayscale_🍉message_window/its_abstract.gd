# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・アブストラクト（Its abstract；その抽象的な）
extends Node


# 監督取得
func get_director():
	return $"../../../Director"


# 助監取得
func get_assistant_director():
	return self.get_director().get_node("AssistantDirector")


# キャンバス・レイヤー取得
func get_canvas_layer(message_window_name):
	return self.get_director().get_node("TelopCoordinator/MessageWindow_" + message_window_name)


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
