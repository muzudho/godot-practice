extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello, world!")

func _process(delta):

	var velocity = Vector2.ZERO
	
	# 上キーを押していなければ進まない仕組み
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed

	# その場で　ねずみ花火のように　くるくる回る
	rotation += angular_speed * delta

	# 洗濯機の中の衣類のように　周る
	var movement = velocity * delta

	# 何も押さなければその場で回転
	var direction = 0
	# 左キー押下で頭上の方へ進む
	if Input.is_action_pressed("ui_left"):
		direction = -1
	# 右キー押下で足下の方へ進む
	if Input.is_action_pressed("ui_right"):
		direction = 1
	movement *= direction
	
	# 移動ベクトルを足す
	position += movement
