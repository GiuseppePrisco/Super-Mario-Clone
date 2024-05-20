extends CanvasLayer

var game_started = false
var game_paused = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	
	$ColorRect.show()
	$GameNotPaused.hide()
	$GamePaused.hide()

func _process(delta):
	if Input.is_action_just_pressed("exit") and game_started:
		if game_paused:
			_on_resume_button_pressed()
		else:
			_on_pause_button_pressed()


func _on_pause_button_pressed():
	get_tree().paused = true
	game_paused = true
	$GameNotPaused.hide()
	$GamePaused.show()


func _on_start_button_pressed():
	$ColorRect.hide()
	$GameNotPaused.show()
	get_tree().paused = false
	game_started = true


func _on_resume_button_pressed():
	get_tree().paused = false
	game_paused = false
	$GamePaused.hide()	
	$GameNotPaused.show()
