extends Node2D

var fireball_scene: PackedScene = preload("res://scenes/projectiles/fireball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_fireball_shot(pos, direction):
	var fireball = fireball_scene.instantiate()
	fireball.position = pos
	fireball.rotation = direction.angle()
	fireball.direction = direction
	#print(direction)
	$Projectiles.add_child(fireball)
	
	#add_child(fireball)
	#print("fireball shot")
