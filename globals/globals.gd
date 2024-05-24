extends Node

# player global position
var player_position: Vector2

# projectiles stats
var original_projectiles = {
	"fireball": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"rotation_speed": 50,
		"damage": 10,
		"duration": 5,
		"pierce": 1,
		"cooldown": 1,
		"can_be_fired": true,
	},
	"mushroom": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"rotation_speed": 50,
		"damage": 25,
		"duration": 5,
		"pierce": 1,
		"cooldown": 1,
		"can_be_fired": true,
	},
}
var projectiles = original_projectiles.duplicate(true)


# enemies stats
var enemies = {
	"goomba": {
		"movement_speed": 50,
		"health": 10,
	},
	"bowser": {
		"movement_speed": 10,
		"health": 100,
	},
	"koopa": {
		"movement_speed": 30,
		"health": 25,
	},
}

# items stats
var items = {
	"star": {
		"movement_speed": 50,
		"acceleration": 100,
		"duration": 10,
	},
	"green_mushroom": {
		"movement_speed": 50,
		"acceleration": 100,
		"duration": 10,
	},
}



func reset_game_stats():
	projectiles = original_projectiles.duplicate(true)

	
