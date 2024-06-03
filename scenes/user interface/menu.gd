extends CanvasLayer

@onready var music_slider = $"GamePaused/VBoxContainer/VBoxContainer/Music Slider"
@onready var sfx_slider = $"GamePaused/VBoxContainer/VBoxContainer2/SFX Slider"

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	# properly hide or show the correct menus
	$ColorRect.show()
	$GameNotPaused.hide()
	$GamePaused.hide()
	
	# correctly set the slider's values
	music_slider.value = Options.music_bus_volume
	sfx_slider.value = Options.sfx_bus_volume
	
	music_slider.min_value = Options.music_bus_min_volume
	sfx_slider.min_value = Options.sfx_bus_min_volume

func _process(_delta):
	if Input.is_action_just_pressed("exit") and Globals.ui["game_started"]:
		if Globals.ui["game_paused"]:
			_on_resume_button_pressed()
		else:
			_on_pause_button_pressed()


func _on_pause_button_pressed():
	$GameNotPaused.hide()
	$GamePaused.show()
	get_tree().paused = true
	Globals.ui["game_paused"] = true


func _on_start_button_pressed():
	$ColorRect.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	Globals.ui["game_started"] = true
	
	SoundManager.play_music()


func _on_resume_button_pressed():
	$GamePaused.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	Globals.ui["game_paused"] = false


func _on_home_button_pressed():
	$GamePaused.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	Globals.reset_game_stats()
	
	get_tree().reload_current_scene()



func _on_music_slider_value_changed(value):
	if value <= Options.music_bus_min_volume:
		value = -800
	
	Options.music_bus_volume = value
	SoundManager.set_bus_volume("Music", value)


func _on_sfx_slider_value_changed(value):
	if value <= Options.sfx_bus_min_volume:
		value = -800
	Options.sfx_bus_volume = value
	SoundManager.set_bus_volume("SFX", value)
