extends Area2D
class_name ProjectileContainer

var projectile: String

var remaining_pierce: int
var movement_speed: int
var direction: Vector2 = Vector2.UP
var rotation_speed: int


func setup(projectile_name):
	projectile = projectile_name
	remaining_pierce = Globals.projectiles[projectile].pierce
	$Timer.set_wait_time(Globals.projectiles[projectile].duration)
	$Timer.start()


func _process(delta):
	
	movement_speed = Globals.projectiles[projectile].movement_speed
	rotation_speed = Globals.projectiles[projectile].rotation_speed
	
	if projectile == "mushroom":
		direction = Globals.projectiles[projectile].direction
	
	position += direction * movement_speed * delta
	rotation += rotation_speed * delta


func _on_body_entered(body):
	
	# an enemy was hit
	if "hit" in body:
		body.hit(Globals.projectiles[projectile].damage)
	
		# reduce the pierce of the projectile
		remaining_pierce -= 1
		if remaining_pierce <= 0:
			# delete the projectile
			queue_free()
	


func _on_timer_timeout():
	queue_free()
