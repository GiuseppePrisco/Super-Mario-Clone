extends Node

signal ui_change
signal game_over
signal level_up

# player stats
var original_player = {
	"position": Vector2.ZERO,
	"local_position": Vector2.ZERO,
	"direction": Vector2.RIGHT,
	"movement_speed": 200,
	"max_health": 200,
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
		"radius": 99999999,
		"rotation_speed": 15,
		"damage": 10,
		"duration": 5,
		"pierce": 1,
		"cooldown": 0.5,
		"can_be_fired": true,
		"is_active": true,
		"sound": load("res://assets/sounds/projectiles/fireball.wav"),
		"volume": 0.3,
	},
	"mushroom": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"radius": 99999999,
		"rotation_speed": 15,
		"damage": 25,
		"duration": 5,
		"pierce": 2,
		"cooldown": 1,
		"can_be_fired": true,
		"is_active": false,
		"sound": load("res://assets/sounds/items/coin.wav"),
		"volume": 0.3,
	},
	"blue_mushroom": {
		"movement_speed": 300,
		"direction": Vector2.UP,
		"radius": 50,
		"rotation_speed": 270,
		"damage": 25,
		"duration": 5,
		"pierce": 9999999999,
		"cooldown": 7,
		"can_be_fired": true,
		"is_active": false,
		"sound": load("res://assets/sounds/items/coin.wav"),
		"volume": 0.3,
	},
	"fire_flower": {
		"movement_speed": 0,
		"direction": Vector2.UP,
		"radius": 200,
		"rotation_speed": 0,
		"damage": 25,
		"duration": 4,
		"pierce": 9999999999,
		"cooldown": 5,
		"can_be_fired": true,
		"is_active": false,
		"sound": load("res://assets/sounds/items/coin.wav"),
		"volume": 0.3,
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
		"damage": 100,
		"cooldown": 3,
	},
	"koopa": {
		"movement_speed": 35,
		"health": 25,
		"damage": 25,
		"cooldown": 1.5,
	},
}

# items stats
var items = {
	"star": {
		"movement_speed": 50,
		"acceleration": 100,
		"duration": 10,
		"collect_sound": load("res://assets/sounds/items/coin.wav"),
		"collect_volume": 0.3,
	},
	"green_mushroom": {
		"movement_speed": 100,
		"acceleration": 100,
		"duration": 10,
		"xp": 20,
		"collect_sound": load("res://assets/sounds/items/mushroom.wav"),
		"collect_volume": 0.2,
	},
}

# ui 
var original_ui = {
	"game_started": false,
	"game_paused": false,
	"can_be_paused": true,
}
var ui = original_ui.duplicate(true)

var music_files = {
	"background": {
		"music": load("res://assets/sounds/music/background.mp3"),
		"volume": 0.3,
	},
	"game_over": {
		"music": load("res://assets/sounds/music/game_over.wav"),
		"volume": 1,
	},
}

var sound_effects_files = {
	"menu_pause": {
		"sound": load("res://assets/sounds/menu/pause.wav"),
		"volume": 0.2,
	},
	"level_up": {
		"sound": load("res://assets/sounds/menu/level_up.wav"),
		"volume": 0.2,
	}
}


func update_player(property: String, value) -> void:
	player[property] = value
	ui_change.emit()
	
	if property == "level":
		level_up.emit()
	
	# check if the player should be dead
	if Globals.player["health"] <= 0:
		game_over.emit()


func reset_game_stats():
	projectiles = original_projectiles.duplicate(true)
	player = original_player.duplicate(true)
#	ui = original_ui.duplicate(true)
	
	# stop all audio streams
	for audio_stream in SoundManager.get_children():
		audio_stream.stop()

