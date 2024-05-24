extends CharacterBody2D
class_name EnemyContainer

var enemy: String

var health: int
var movement_speed: int

var rotation_threshold = 10

signal death(item_name, pos)

func setup(enemy_name):
	enemy = enemy_name
	
	# TODO move the following inside process if i am planning to make these stats change over time
	movement_speed = Globals.enemies[enemy].movement_speed
	health = Globals.enemies[enemy].health

func _process(delta):
	
	# rotate the character sprite
	if should_rotate():
		$Sprite2D.flip_h = !$Sprite2D.flip_h
	
	var player_direction = (Globals.player_position - global_position).normalized()
	
	velocity = movement_speed * player_direction
	move_and_slide()
	
	
func should_rotate() -> bool:
	if $Sprite2D.flip_h == true and global_position.x >= Globals.player_position.x + rotation_threshold:
		# enemy is at the right side of the character		
		return true
	else:
		if $Sprite2D.flip_h == false and global_position.x < Globals.player_position.x - rotation_threshold:
			# enemy is at the left side of the character		
			return true
	return false
	

func hit(damage):
	health -= damage
	if health <= 0:
		enemy_death()
	

func enemy_death():
		death.emit("green_mushroom", position)
#		print("death", death)
		queue_free()
	




