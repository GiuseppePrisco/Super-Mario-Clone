extends CanvasLayer

@onready var music_slider = $"GamePaused/VBoxContainer/VBoxContainer/Music Slider"
@onready var sfx_slider = $"GamePaused/VBoxContainer/VBoxContainer2/SFX Slider"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# connect the signal
	Globals.connect("game_over", game_over)
	
	
	if !Globals.ui["game_started"]:
		# properly hide or show the correct menus
		$ColorRect.show()
		$GameNotPaused.hide()
		$GamePaused.hide()
		get_tree().paused = true
	else:
		$ColorRect.hide()
		$GameNotPaused.show()
		$GamePaused.hide()
		get_tree().paused = false
	
	
	
	# correctly set the sliders' values
	music_slider.value = Options.music_bus_volume
	sfx_slider.value = Options.sfx_bus_volume
	
#	music_slider.min_value = Options.music_bus_min_volume
#	sfx_slider.min_value = Options.sfx_bus_min_volume

func _process(_delta):
	if Input.is_action_just_pressed("exit") and Globals.ui["game_started"]:
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


func exit_game():
	# TODO insert here the rest of the logic for exiting the game (save data, reset stage ecc)
	Globals.reset_game_stats()
	
	get_tree().reload_current_scene()
	

func _on_music_slider_value_changed(value):
	Options.music_bus_volume = value
	SoundManager.set_bus_volume("Music", value)


func _on_sfx_slider_value_changed(value):
	Options.sfx_bus_volume = value
	SoundManager.set_bus_volume("SFX", value)



