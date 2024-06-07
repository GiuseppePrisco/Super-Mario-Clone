extends Area2D
class_name ProjectileContainer

var projectile: String

var movement_speed: int
var direction: Vector2
var radius
var rotation_speed: int
var rotation_direction: int = 1
var remaining_pierce: int
var rotation_angle = 0
const projectile_spawn_position_number = 10

# TODO use this for stationary projectiles
var original_position: Vector2


func setup(projectile_name):
	projectile = projectile_name
	remaining_pierce = Globals.projectiles[projectile].pierce
	
	# used in some of the projectiles
	radius = Globals.projectiles[projectile].radius
	
	# TODO use this for stationary projectiles
	original_position = position
	
	match projectile:
		"fireball":
			if Globals.player["direction"].x < 0:
				$Sprite2D.flip_h = true
				rotation_direction = -rotation_direction
		"fire_flower":
			position = position + radius * get_projectile_spawn_position().pick_random()
	
	
	
	var sound = Globals.projectiles[projectile].sound
	var volume = Globals.projectiles[projectile].volume
	SoundManager.play_projectile_sound_effect(sound, volume)
	
	# set the timer duration as the projectile duration minus the animation duration (since at the end of the animation the projectile will expire)
	$Timer.set_wait_time(Globals.projectiles[projectile].duration - $AnimationPlayer.get_animation("projectile expired").length)
	$Timer.start()

func _process(delta):
	
	movement_speed = Globals.projectiles[projectile].movement_speed
	rotation_speed = Globals.projectiles[projectile].rotation_speed
	
	if projectile == "mushroom":
		direction = Globals.projectiles[projectile].direction
		
	if projectile == "blue_mushroom":
		rotation_angle += deg_to_rad(rotation_speed) * delta

		position = Globals.player["local_position"] + Vector2(radius, 0).rotated(rotation_angle)
		
	else:
		position += direction * movement_speed * delta
		rotation += rotation_speed * rotation_direction * delta


#func _on_body_entered(body):
#
#	# an enemy was hit
#	if "hit" in body:
#		body.hit(Globals.projectiles[projectile].damage, projectile)
#
#		# reduce the pierce of the projectile
#		remaining_pierce -= 1
#		if remaining_pierce <= 0 :
#			# delete the projectile
#			queue_free()
	

func _on_timer_timeout():
	$AnimationPlayer.play("projectile expired")
	
	
func get_projectile_spawn_position():
	var theta = 2 * PI / projectile_spawn_position_number
	var vectors = []
	for i in range(projectile_spawn_position_number):
		var angle = i * theta
		vectors.append(Vector2(cos(angle), sin(angle)))
	return vectors


func _on_area_entered(area):
	# an enemy was hit
	if area.name == "Hurtbox":
		# get the enemy node and call the hit method
		area.get_parent().hit(Globals.projectiles[projectile].damage)
	
		# reduce the pierce of the projectile
		remaining_pierce -= 1
		if remaining_pierce <= 0 :
			# delete the projectile
			queue_free()
