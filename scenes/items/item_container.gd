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
	
	
func _physics_process(delta):
	
	if should_be_collected:
		var player_direction = (Globals.player["position"] - global_position).normalized()
		movement_speed += acceleration * delta
		position += movement_speed * player_direction * delta


func _on_reception_field_body_entered(_body):
	should_be_collected = true


func _on_collision_body_entered(_body):
	
	# play the sound of the collected item
	var collect_sound = Globals.items[item].collect_sound
	var collect_volume = Globals.items[item].collect_volume
	SoundManager.play_item_collected_sound_effect(collect_sound, collect_volume)
#	SoundManager.play_item_collected_sound_effect(Globals.items["star"].collect_sound)
	
	
	#TODO insert the behaviour for other items
	if item == "green_mushroom":
		# update player xp
		Globals.update_player("xp", Globals.player["xp"] + Globals.items[item].xp)
		var current_xp: int = Globals.player["xp"]
		var needed_xp: int = Globals.player["needed_xp"]
		var xp_multiplier = Globals.player["xp_multiplier"]
		
		# check if player should level up
		if current_xp >= needed_xp:

#			print("first current xp ", current_xp)
#			print("first needed_xp ", needed_xp)
			
			# the player levels up
			Globals.update_player("level", Globals.player["level"] + 1)
			Globals.update_player("xp", current_xp % needed_xp)
			Globals.update_player("needed_xp", round(needed_xp * xp_multiplier))
			
			var effect = "level_up"
			var sound = Globals.sound_effects_files[effect].sound
			var volume = Globals.sound_effects_files[effect].volume
			SoundManager.play_menu_sound_effect(sound, volume)
			
#			print("second current xp ", Globals.player["xp"])
#			print("second needed_xp ", Globals.player["needed_xp"])
	
	# delete the item
	queue_free()



# delete the item after a certain amount of time has passed
func _on_timer_timeout():
	queue_free()
