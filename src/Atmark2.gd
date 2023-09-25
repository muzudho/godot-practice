extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):	
	pass

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_A:
			print("A was pressed")
		elif event.keycode == KEY_RIGHT:
			print("Right was pressed")
			position.x += 32
