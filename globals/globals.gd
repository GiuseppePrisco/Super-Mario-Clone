extends Node

signal ui_change

# player stats
var original_player = {
	"position": Vector2.ZERO,
	"movement_speed": 200,
	"health": 200,
	"armor": 10,
	"level": 0,
	"xp": 0,
	"needed_xp": 100,
	"xp_multiplier": 1.1,
	"defeated_enemies": 0,	
}
var player = original_player.duplicate(true)


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
		"pierce": 2,
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
		"damage": 10,
		"cooldown": 1,
	},
	"bowser": {
		"movement_speed": 10,
		"health": 100,
		"damage": 50,
		"cooldown": 3,
	},
	"koopa": {
		"movement_speed": 35,
		"health": 25,
		"damage": 25,
		"cooldown": 2,
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
		"movement_speed": 100,
		"acceleration": 100,
		"duration": 10,
		"xp": 20,
	},
}

# ui 
var original_ui = {
	"game_started": false,
	"game_paused": false,
}
var ui = original_ui.duplicate(true)


func update_player(property: String, value) -> void:
	player[property] = value
	ui_change.emit()
#	print(property, value)


func reset_xp():
	player["xp"] = 0

func reset_game_stats():
	projectiles = original_projectiles.duplicate(true)
	player = original_player.duplicate(true)
	ui = original_ui.duplicate(true)

	
