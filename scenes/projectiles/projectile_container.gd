extends Area2D
class_name ProjectileContainer

var movement_speed: int = 300
var direction: Vector2 = Vector2.UP
var rotation_speed: int = 50

var projectile_name = "placeholder"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(Globals.projectiles[projectile_name].duration)
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * movement_speed * delta
	rotation += rotation_speed * delta


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
	
	#delete the object
	queue_free()


func _on_timer_timeout():
	queue_free()
