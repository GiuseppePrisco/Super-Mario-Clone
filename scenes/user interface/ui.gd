extends CanvasLayer

@onready var enemy_label = $VBoxContainer/HBoxContainer/EnemiesDefeated
@onready var player_label = $VBoxContainer/HBoxContainer/PlayerLevel
@onready var xp_progress_bar = $VBoxContainer/ProgressBar
@onready var health_progress_bar = $PlayerHealth



func _ready():
	# connect the signal
	Globals.connect("ui_change", update_ui)
	
	update_ui()


func _process(_delta):
	
	if Globals.ui["game_started"]:
		$".".show()
	else:
		$".".hide()


func update_ui():
	enemy_label.text = str(Globals.player["defeated_enemies"])
	player_label.text = str(Globals.player["level"])
	
	var exp_value = (Globals.player["xp"] * 100) / Globals.player["needed_xp"]
	xp_progress_bar.value = exp_value
	
	var health_value = (Globals.player["health"] * 100) / Globals.player["max_health"]
	health_progress_bar.value = health_value
	
	
