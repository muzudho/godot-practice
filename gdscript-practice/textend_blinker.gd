extends Label

# 点滅用
var is_blink_started = false
var count_of_blink = 0

# タイプライターの文字出力間隔
var count_of_typewriter = 0

# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	# 最初は非表示
	visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# テキストを出し終えたか？
	count_of_typewriter += delta
	if not is_blink_started and 0.5 <= count_of_typewriter:
		var message_window_text = $".."
		if message_window_text.get("text_storage").length() < 1:
			is_blink_started = true
			visible = true
			
		count_of_typewriter -= 0.5

	# 点滅
	if is_blink_started:
		count_of_blink += delta
		if 0.75 <= count_of_blink: 
			visible = not visible
			count_of_blink -= 0.75
