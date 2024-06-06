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

# TODO use this for stationary projectiles
var original_position: Vector2


func setup(projectile_name):
	projectile = projectile_name
	remaining_pierce = Globals.projectiles[projectile].pierce
	
	# TODO use this for stationary projectiles
	original_position = position
	
	if projectile == "fireball":
		if Globals.player["direction"].x < 0:
			$Sprite2D.flip_h = true
			rotation_direction = -rotation_direction
	
	var sound = Globals.projectiles[projectile].sound
	var volume = Globals.projectiles[projectile].volume
	SoundManager.play_projectile_sound_effect(sound, volume)
	
	$Timer.set_wait_time(Globals.projectiles[projectile].duration)
	$Timer.start()


func _process(delta):
	
	movement_speed = Globals.projectiles[projectile].movement_speed
	rotation_speed = Globals.projectiles[projectile].rotation_speed
	
	if projectile == "mushroom":
		direction = Globals.projectiles[projectile].direction
		
	if projectile == "blue_mushroom":
		radius = Globals.projectiles[projectile].radius
		rotation_angle += deg_to_rad(rotation_speed) * delta

		position = Globals.player["local_position"] + Vector2(radius, 0).rotated(rotation_angle)
		
	else:
		position += direction * movement_speed * delta
		rotation += rotation_speed * rotation_direction * delta


func _on_body_entered(body):
	
	# an enemy was hit
	if "hit" in body:
		body.hit(Globals.projectiles[projectile].damage)
	
		# reduce the pierce of the projectile
		remaining_pierce -= 1
		if remaining_pierce <= 0 :
			# delete the projectile
			queue_free()
	


func _on_timer_timeout():
	queue_free()
