extends Node2D
class_name ItemContainer

var item: String

var movement_speed: int
var acceleration: float

var should_be_collected = false

@onready var collision = $Area2D
@onready var reception_field = $ReceptionField


func setup(item_name):
	# connect signals
	collision.connect("body_entered", _on_collision_body_entered)
	reception_field.connect("body_entered", _on_reception_field_body_entered)
	
	item = item_name
	movement_speed = Globals.items[item].movement_speed
	acceleration = Globals.items[item].acceleration
	$Timer.set_wait_time(Globals.items[item].duration)
	$Timer.start()
	
	
func _process(delta):
	
	if should_be_collected:
		var player_direction = (Globals.player_position - global_position).normalized()
		movement_speed += acceleration * delta
		position += movement_speed * player_direction * delta


func _on_reception_field_body_entered(body):
	print("reception field", body)
	should_be_collected = true


func _on_collision_body_entered(body):
	print("collision", body)
	queue_free()



# delete the item after a certain amount of time has passed
func _on_timer_timeout():
	queue_free()
