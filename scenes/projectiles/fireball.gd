extends Area2D

var speed: int = 300
var direction: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * speed * delta
	rotation += 50 * delta


func _on_body_entered(body):
	if "custom_method" in body:
		pass
	
	#delete the object
	queue_free()


func _on_timer_timeout():
	queue_free()
