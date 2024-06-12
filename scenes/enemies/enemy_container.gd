extends CharacterBody2D
class_name EnemyContainer

var death_effect_scene: PackedScene = preload("res://scenes/effects/death_effect.tscn")

signal death(item_name, pos)

var enemy: String

var health: int
var movement_speed: int

var rotation_threshold = 10

var is_colliding_with_player: bool = false
var should_player_take_damage: bool = true

var damaging_projectiles: Dictionary = {}

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
	
	if is_colliding_with_player and should_player_take_damage and !Globals.player.is_immortal:

		print("health before ", Globals.player["health"])
		Globals.update_player("health", Globals.player["health"] - Globals.enemies[enemy].damage)
		print("health after ", Globals.player["health"])
		
		var effect = "damage_received"
		var sound = Globals.sound_effects_files[effect].sound
		var volume = Globals.sound_effects_files[effect].volume
		SoundManager.play_item_collected_sound_effect(sound, volume)
		
		should_player_take_damage = false
		$"Hitbox/Hitbox Timer".set_wait_time(Globals.enemies[enemy].cooldown)
		$"Hitbox/Hitbox Timer".start()
	
	
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
		
		# instantiate the death effect as another scene
		var death_effect = death_effect_scene.instantiate()
		death_effect.global_position = position
		get_parent().get_parent().get_node("Effects").add_child(death_effect)
		
		# delete the enemy
		queue_free()
	


func _on_hitbox_body_entered(_body):
	# the player is colliding with the enemy
	is_colliding_with_player = true

func _on_hitbox_body_exited(_body):
	# the player is no longer colliding with the enemy
	is_colliding_with_player = false
	
func _on_hitbox_timer_timeout():
	# the player should take damage once again
	should_player_take_damage = true

