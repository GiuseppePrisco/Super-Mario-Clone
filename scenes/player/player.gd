extends CharacterBody2D

signal fireball_shot(position, direction)

var can_fireball = true
var player_direction = Vector2.RIGHT

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(0, 100)

#var i: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	#input
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 200
	move_and_slide()
	
	#rotate
	var target = position + direction
	look_at(target)
	#print(position + direction)
	
	if direction != Vector2(0, 0):
		player_direction = (target - position).normalized()
		
	if Input.is_action_just_pressed("fireball") and can_fireball:
		can_fireball = false
		var fireball_markers = $FireballPositions.get_children()
		var selected_fireball = fireball_markers[randi() % fireball_markers.size()]
		fireball_shot.emit(selected_fireball.global_position, player_direction)
		$GPUParticles2D.emitting = true
		#print(selected_fireball.global_position)
		$Timer.start()
		
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


func _on_timer_timeout():
	can_fireball = true
