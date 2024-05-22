extends Area2D
class_name ProjectileContainer

# placeholder values
var movement_speed: int = 300
var direction: Vector2 = Vector2.UP
var rotation_speed: int = 50

var projectile = "placeholder"

func setup(projectile_name):
	projectile = projectile_name	
	$Timer.set_wait_time(Globals.projectiles[projectile_name].duration)
	$Timer.start()


func _process(delta):
	
	movement_speed = Globals.projectiles[projectile].movement_speed
	rotation_speed = Globals.projectiles[projectile].rotation_speed
	
	if projectile == "mushroom":
		direction = Globals.projectiles[projectile].direction
	
	position += direction * movement_speed * delta
	rotation += rotation_speed * delta


func _on_body_entered(body):
	# TODO
	if "hit" in body:
		body.hit()
	
	#delete the object
	queue_free()


func _on_timer_timeout():
	queue_free()
