extends Node2D

var fireball_scene: PackedScene = preload("res://scenes/projectiles/fireball.tscn")
var projectile_scenes = {
	"fireball": preload("res://scenes/projectiles/fireball.tscn"),
	"mushroom": preload("res://scenes/projectiles/mushroom.tscn"),
}


# Called when the node enters the scene tree for the first time.
func _ready():
	$Menu.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#TODO, WHEN THE GENERIC PROJECTILE SIGNAL FUNCTION IS COMPLETED, DELETE THIS SIGNAL
func _on_player_fireball_shot(pos, direction):
	var fireball = fireball_scene.instantiate()
	fireball.position = pos
	fireball.rotation = direction.angle()
	fireball.direction = direction
	#print(direction)
	$Projectiles.add_child(fireball)
	
	#add_child(fireball)
	#print("fireball shot")



func _on_player_projectile_shot(projectile_name, pos, direction):
	var projectile = projectile_scenes[projectile_name].instantiate()
	projectile.position = pos
	projectile.rotation = direction.angle()
	projectile.direction = direction
	$Projectiles.add_child(projectile)
#	print(projectile)
