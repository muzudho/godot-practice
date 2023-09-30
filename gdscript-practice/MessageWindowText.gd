extends Label

var count = 0

var text_storage = """お父ん、なんで唐揚げを食べているんだぜ？
ダイエットはどうした？
野菜を TABERO だぜ！
"""

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	
	if 0.05 <= count:
		if 0 < self.text_storage.length():
			self.text += text_storage.substr(0, 1)
			text_storage = text_storage.substr(1, self.text_storage.length()-1)
		count -= 0.05
