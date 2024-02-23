# キー・コンフィグ　＞　インプット　＞　パーサー（Parser；解析機）
#
#	Godot の入力は文字列で送られてくる
extends Node


# ーーーーーーーー
# メモリ関連
# ーーーーーーーー

# 文字列解析用
var re_button = RegEx.new()
var re_lever = RegEx.new()


# ーーーーーーーー
# 起動時設定
# ーーーーーーーー

func _ready():
	# 入力イベントが返す文字列。仕様さっぱり分からん
	# 最後に半角スペースを入れること。 `Button 1` と `Button 10` を区別するために
	re_button.compile("Joypad Button (\\d+) ")
	# 例： Joypad Motion on Axis 4 (Joystick 2 X-Axis, Left Trigger, Sony L2, Xbox LT) with Value 0.00
	re_lever.compile("Joypad Motion on Axis (\\d+) \\(.*\\) with Value (-?\\d+(?:\\.\\d+)?)")


# ーーーーーーーー
# その他
# ーーーーーーーー

# 以下のシンボルを返す
#
# -1：　該当無し
# 1000 未満の整数：　ボタン番号
# 1000 以上の整数：　レバー番号に1000を足したもの
# 文字列：　キーボードのキー名
func get_button_symbol_by_text(event_as_text):
	# 📖　[enum JoyButton:](https://docs.godotengine.org/en/stable/classes/class_%40globalscope.html#enum-globalscope-joybutton)
	# レバーは -1 ～ 10、 ボタンは -1 ～ 128 まであるそうだ
	var matched = self.re_button.search(event_as_text)
	if matched:
		return int(matched.get_string(1))

	matched = self.re_lever.search(event_as_text)
	if matched:
		return int(matched.get_string(1)) + 1000
	
	print("［入力変換］　event_as_text：" + event_as_text + " type:" + str(typeof(event_as_text)))
	
	if typeof(event_as_text) == TYPE_STRING:
		# キーボードのキーの名前
		return event_as_text
	
	return -1


# 内部では使ってない。外部向け。
# レバーのイベント文字列から、-1.0 ～ 1.0 の値を取得
# レバーでなければ 0.0 を返す
func get_lever_value_by_text(event_as_text):
	var matched = self.re_lever.search(event_as_text)
	if matched:
		return float(matched.get_string(2))

	return 0.0
