extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):
	# その場で　ねずみ花火のように　くるくる回る
	rotation += angular_speed * delta

	# 洗濯機の中の衣類のように　周る
	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta	
