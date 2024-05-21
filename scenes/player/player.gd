extends CharacterBody2D

signal fireball_shot(pos, direction)

var can_fireball = true
var player_direction = Vector2.RIGHT
#var player_is_flipped = false


func _ready():
	position = Vector2(20, 100)


func _process(_delta):
	
	#input
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * 200
	move_and_slide()
	
	
	# rotate the character sprite
	if input_direction.x > 0 and player_direction != Vector2.RIGHT:
		player_direction = Vector2.RIGHT
		scale.x = -scale.x
	
	if input_direction.x < 0 and player_direction != Vector2.LEFT:
		player_direction = Vector2.LEFT
		scale.x = -scale.x
	
	
#	print("position", position)
	
	
#	#rotate
#	var target = position + input_direction
#	target = position + player_direction
#	look_at(target)
#	if input_direction != Vector2(0, 0):
#		player_direction = (target - position).normalized()
		
	if Input.is_action_just_pressed("fireball") and can_fireball:
		can_fireball = false
		var fireball_markers = $FireballPositions.get_children()
		var selected_fireball = fireball_markers[randi() % fireball_markers.size()]
		fireball_shot.emit(selected_fireball.global_position, player_direction)
#		fireball_shot.emit(selected_fireball.position, player_direction)		
		$GPUParticles2D.emitting = true
		
		print("marker pos", selected_fireball.position)
		print("marker global pos", selected_fireball.global_position)
		print("fireball pos", selected_fireball.global_position)
		print("player pos", position)
		print("player global pos", global_position)
		
		
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
