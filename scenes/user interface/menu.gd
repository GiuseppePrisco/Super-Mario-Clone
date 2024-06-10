extends CanvasLayer

@onready var music_slider = $"GamePaused/VBoxContainer/VBoxContainer/Music Slider"
@onready var sfx_slider = $"GamePaused/VBoxContainer/VBoxContainer2/SFX Slider"

var projectile_card_scene: PackedScene = preload("res://scenes/user interface/projectile_card.tscn")



func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# connect the signals
	Globals.connect("game_over", game_over)
	Globals.connect("level_up", level_up)
	
	$GamePaused.hide()
	$LevelUp.hide()
	
	
	if !Globals.ui["game_started"]:
		# properly hide or show the correct menus
		$ColorRect.show()
		$GameNotPaused.hide()
		get_tree().paused = true
	else:
		$ColorRect.hide()
		$GameNotPaused.show()
		get_tree().paused = false
	
	
	
	# correctly set the sliders' values
	music_slider.value = Options.music_bus_volume
	sfx_slider.value = Options.sfx_bus_volume
	
#	music_slider.min_value = Options.music_bus_min_volume
#	sfx_slider.min_value = Options.sfx_bus_min_volume

func _process(_delta):
	if Input.is_action_just_pressed("exit") and Globals.ui["game_started"] and Globals.ui["can_be_paused"]:
		if Globals.ui["game_paused"]:
			_on_resume_button_pressed()
		else:
			_on_pause_button_pressed()

func _on_start_button_pressed():
	$ColorRect.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	Globals.ui["game_started"] = true
	
	var music_name = "background"
	var music = Globals.music_files[music_name].music
	var volume = Globals.music_files[music_name].volume
	SoundManager.play_music(music, volume)
	

func _on_pause_button_pressed():
	$GameNotPaused.hide()
	$GamePaused.show()
	get_tree().paused = true
	Globals.ui["game_paused"] = true
	
	var effect = "menu_pause"
	var sound = Globals.sound_effects_files[effect].sound
	var volume = Globals.sound_effects_files[effect].volume
	SoundManager.play_menu_sound_effect(sound, volume)


func _on_resume_button_pressed():
	$GamePaused.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	Globals.ui["game_paused"] = false


func _on_home_button_pressed():
	Globals.ui["game_started"] = false
	Globals.ui["game_paused"] = false
	
	exit_game()

func _on_restart_button_pressed():
	Globals.ui["game_started"] = true
	Globals.ui["game_paused"] = false
	
	exit_game()
	
	var music_name = "background"
	var music = Globals.music_files[music_name].music
	var volume = Globals.music_files[music_name].volume
	SoundManager.play_music(music, volume)
	
	

func game_over():
	$GameNotPaused.hide()
	$GamePaused.show()
	$"GamePaused/VBoxContainer/Game Over Label".show()
	$GamePaused/VBoxContainer/HBoxContainer/RestartButton.show()
	$GamePaused/VBoxContainer/HBoxContainer/ResumeButton.hide()
	get_tree().paused = true
	Globals.ui["game_started"] = false
	Globals.ui["game_paused"] = true
	
	var music_name = "game_over"
	var music = Globals.music_files[music_name].music
	var volume = Globals.music_files[music_name].volume
	SoundManager.play_music(music, volume)

func level_up():
	var possible_projectile_choices = []
	for projectile in Globals.projectiles.keys():
		if !Globals.projectiles[projectile].is_active:
			possible_projectile_choices.append(projectile)
	possible_projectile_choices.shuffle()
	
	var number_of_displayed_choices = 3
	for random_choice in min(number_of_displayed_choices, possible_projectile_choices.size()):
		var projectile = possible_projectile_choices[random_choice]
		
		var projectile_card = projectile_card_scene.instantiate()
		var texture_button = projectile_card.get_node("VBoxContainer/TextureButton")
		var label = projectile_card.get_node("VBoxContainer/Label")
		
		# dynamically set the image and label for the corresponding projectile
		texture_button.texture_normal = load("res://assets/sprites/"+projectile+".png")
		label.text = projectile.capitalize()
		
		# define the signal for the texture button
		texture_button.connect("pressed", activate_projectile.bind(projectile))
		
		$LevelUp/HBoxContainer.add_child(projectile_card)
	
	
	if possible_projectile_choices.size() != 0:
		Globals.ui["can_be_paused"] = false
		$LevelUp.show()
		get_tree().paused = true
	



func exit_game():
	# TODO insert here the rest of the logic for exiting the game (save data, reset stage ecc)
	Globals.reset_game_stats()
	
	get_tree().reload_current_scene()
	
	
func activate_projectile(projectile: String):
	Globals.projectiles[projectile].is_active = true
	
	# remove all the children from the horizontal container
	for node in $LevelUp/HBoxContainer.get_children():
		$LevelUp/HBoxContainer.remove_child(node)
		node.queue_free()
	
	Globals.ui["can_be_paused"] = true
	$LevelUp.hide()
	get_tree().paused = false
	

func _on_music_slider_value_changed(value):
	Options.music_bus_volume = value
	SoundManager.set_bus_volume("Music", value)


func _on_sfx_slider_value_changed(value):
	Options.sfx_bus_volume = value
	SoundManager.set_bus_volume("SFX", value)



