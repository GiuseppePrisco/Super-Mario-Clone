extends Node

# player global position
var player_position: Vector2

# projectiles stats
var original_projectiles = {
	"fireball": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"rotation_speed": 50,
		"duration": 5,
		"pierce": 1,
		"cooldown": 0.5,
		"can_be_fired": true,
	},
	"mushroom": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"rotation_speed": 50,
		"duration": 3,
		"pierce": 1,
		"cooldown": 1,		
		"can_be_fired": true,
	},
}
var projectiles = original_projectiles.duplicate(true)


# enemy stats



func reset_game_stats():
	projectiles = original_projectiles.duplicate(true)

	
