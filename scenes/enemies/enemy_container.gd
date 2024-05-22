extends CharacterBody2D
class_name EnemyContainer


# placeholder values
var movement_speed: int = 300
#var direction: Vector2 = Vector2.UP
#var rotation_speed: int = 50



func _process(delta):
	
	# TODO DELETE THIS AND MAKE THE ENEMY MIRROR (CHANGE THE SCALE) JUST LIKE THE PLAYER
	look_at(Globals.player_position)
	
	var player_direction = (Globals.player_position - global_position).normalized()
	
	# TODO CHANGE THE MOVEMENT OPTIONS
	velocity = player_direction * 50
	move_and_slide()
	
	#TEST WITH AREA2D
#	position += player_direction * 50 * delta
	
	# TODO TEST WITH MOVE AND COLLIDE
#	var collision = move_and_collide(velocity * delta)
#	if collision:
#		if collision.get_collider().get_collision_layer() == 1:
#			print(collision)
#
	
	
	
	
	

func hit():
	print("enemy hit")



