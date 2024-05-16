extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(200, 100)

var i: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 200
	move_and_slide()
	
	if Input.is_action_just_pressed("fireball"):
		pass
	
#	if Input.is_action_pressed("left"):
#		position.x -= 100 * delta
#
#	if Input.is_action_pressed("right"):
#		position.x += 100 * delta
#
#	if Input.is_action_pressed("up"):
#		position.y -= 100 * delta
#
#	if Input.is_action_pressed("down"):
#		position.y += 100 * delta
	
	
	
#	if rotation_degrees > 180 || rotation_degrees < 0:
#		direction = -direction
#
#	rotation_degrees += direction*100*delta
	
#	while i < 1000:
#		if i % 10 == 0:
#			scale += Vector2(0.1, 0.1)
#
#		print(i)
#		i += 1
