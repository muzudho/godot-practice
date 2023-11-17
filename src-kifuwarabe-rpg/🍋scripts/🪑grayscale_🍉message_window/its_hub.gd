# メッセージ・ウィンドウ（Message Window；伝言窓）
# イッツ・ハブ（Its hub；その中心地）
extends Node


# 伝言窓変数の辞書（キー：メッセージ・ウィンドウ名。「■名前」みたいなやつ）
var message_window_variables = {}


# メッセージの早送り
var is_fast_forward = false


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


# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():

	# ーーーーーーーー
	# 初期化を行う
	# ーーーーーーーー

	# メッセージ・ウィンドウの初期設定
	for message_window_node in self.get_children():
		if message_window_node is Sprite2D:
			self.message_window_variables[message_window_node.name] = DepartmentMessageWindow.new()


# 伝言窓変数
func get_message_window_variables(
		message_window_node_name):	# StringName
	return self.message_window_variables[message_window_node_name]


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
