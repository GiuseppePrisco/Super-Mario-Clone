extends CharacterBody2D
class_name EnemyContainer

signal death(item_name, pos)

var enemy: String

var health: int
var movement_speed: int

var rotation_threshold = 10

var is_colliding_with_player: bool = false
var should_player_take_damage: bool = true


func setup(enemy_name):
	enemy = enemy_name
	
	# TODO move the following inside process if i am planning to make these stats change over time
	movement_speed = Globals.enemies[enemy].movement_speed
	health = Globals.enemies[enemy].health

func _process(_delta):
	
	# rotate the character sprite
	if should_rotate():
		$Sprite2D.flip_h = !$Sprite2D.flip_h
	
	var player_direction = (Globals.player["position"] - global_position).normalized()

	
	velocity = movement_speed * player_direction
	move_and_slide()
	
	if is_colliding_with_player and should_player_take_damage:

		print("health before ", Globals.player["health"])
		Globals.update_player("health", Globals.player["health"] - Globals.enemies[enemy].damage)
		print("health after ", Globals.player["health"])
		
		should_player_take_damage = false
		$Hitbox/Timer.set_wait_time(Globals.enemies[enemy].cooldown)
		$Hitbox/Timer.start()
	
	
	
	
func should_rotate() -> bool:
	if $Sprite2D.flip_h == true and global_position.x >= Globals.player["position"].x + rotation_threshold:
		# enemy is at the right side of the character		
		return true
	else:
		if $Sprite2D.flip_h == false and global_position.x < Globals.player["position"].x - rotation_threshold:
			# enemy is at the left side of the character		
			return true
	return false
	

func hit(damage):
	health -= damage
	if health <= 0:
		enemy_death()
	

func enemy_death():
		death.emit("green_mushroom", position)
		Globals.update_player("defeated_enemies", Globals.player["defeated_enemies"] + 1)
		queue_free()
	


func _on_hitbox_body_entered(_body):
	# the player is colliding with the enemy
	is_colliding_with_player = true

func _on_hitbox_body_exited(_body):
	# the player is no longer colliding with the enemy
	is_colliding_with_player = false
	
func _on_timer_timeout():
	# the player should take damage once again
	should_player_take_damage = true



