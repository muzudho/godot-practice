extends Label

var count = 0

# サブツリーが全てインスタンス化されたときに呼び出される
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	count += delta
	
	if 0.75 <= count: 
		visible = not visible
		count -= 0.75
