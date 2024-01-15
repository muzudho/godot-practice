extends Node


# ーーーーーーーー
# 共通メモリ関連
# ーーーーーーーー

# 先祖の辞書キャッシュ
var ancestors = {}


# ーーーーーーーー
# 外パス関連
# ーーーーーーーー


# プログラムズ・ハブ取得
func hub():
	return MonkeyHelper.find_ancestor_child(
			self,
			"🌏Programmer/🛩️Hub",
			self.ancestors)


# ーーーーーーーー
# 以下、主要プログラム
# ーーーーーーーー


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# TODO ここにシナリオを読取る処理を移動したい
func parse_paragraph_test():
	print("［シナリオエンジン］　準備中")
	pass


# 通常文書の表示	
func print_normal_text(paragraph_text):
	#print("［シナリオエンジン］　準備中　通常文書の表示")
	self.hub().get_instruction(&"📘NormalText").do_it(paragraph_text)


# 選択肢の表示
func print_choices(paragraph_text):
	print("［シナリオエンジン］　準備中　選択肢の表示")
	var message_window_gui = self.hub().get_current_message_window_gui()

	# 選択肢だ
	if message_window_gui.choices_row_numbers != null:
		self.hub().get_instruction(&"📘NormalTextChoice").do_it(paragraph_text)
		return true

	return false
