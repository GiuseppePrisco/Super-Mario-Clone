extends CharacterBody2D

#TODO DELETE THESE 2 SIGNALS and the flag
signal fireball_shot(pos, direction)
signal mushroom_shot(pos, direction)
var can_fireball = true


signal projectile_shot(projectile_name, pos, direction)

var cooldown_timers = {}

var player_direction = Vector2.RIGHT


func _ready():
	position = Vector2(20, 100)
#	pass
	

func _process(_delta):
	
	# update player position
	Globals.player["position"] = global_position
#	Globals.update_player("position", global_position)
	
	
	#input
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Globals.player["movement_speed"]
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
		
	
	# TODO RENAME THE FUNCTION AND VARIABLES TO AN ABILITY THE USER CAN USE AFTER X SECONDS
	# projectile triggered by the user
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
		
		
		
		
	for projectile in Globals.projectiles:
		if Globals.projectiles[projectile].can_be_fired:
			Globals.projectiles[projectile].can_be_fired = false
			projectile_shot.emit(projectile, position, player_direction)
			
			# create a timer for each projectile
			var timer = Timer.new()
			timer.set_name("Timer_for_projectile_" + str(projectile))
			timer.set_wait_time(Globals.projectiles[projectile].cooldown)
			timer.one_shot = true
			
			# they are equivalent
#			timer.timeout.connect(Callable(self, "_on_Timer_timeout"))
			timer.connect("timeout", _on_Timer_timeout)

			add_child(timer)
			timer.start()
			cooldown_timers[projectile] = timer
			
		
	

func _on_Timer_timeout():
	for projectile in cooldown_timers.keys():
		if not cooldown_timers[projectile].is_stopped():
			continue
		Globals.projectiles[projectile].can_be_fired = true
		cooldown_timers[projectile].queue_free()
		cooldown_timers.erase(projectile)
	
