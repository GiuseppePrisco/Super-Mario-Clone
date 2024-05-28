extends CanvasLayer


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	$ColorRect.show()
	$GameNotPaused.hide()
	$GamePaused.hide()


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
