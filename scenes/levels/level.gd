extends Node2D

var fireball_scene: PackedScene = preload("res://scenes/projectiles/fireball.tscn")

var projectile_scenes = {
	"fireball": preload("res://scenes/projectiles/fireball.tscn"),
	"mushroom": preload("res://scenes/projectiles/mushroom.tscn"),
}

var enemy_scenes = {
	"goomba": preload("res://scenes/enemies/goomba.tscn"),
	"bowser": preload("res://scenes/enemies/bowser.tscn"),
	"koopa": preload("res://scenes/enemies/koopa.tscn"),
}

var item_scenes = {
	"star": preload("res://scenes/items/star.tscn"),
	"green_mushroom": preload("res://scenes/items/green_mushroom.tscn"),
}

var enemy_spawn_positions: Array
var enemy_spawn_positions_max_distance: int = 200

const MAX_POSITION_NUM: int = 10
const MAX_ENEMY_COUNT: int = 20



func _ready():
	$Menu.show()
	enemy_spawn_positions = get_enemy_spawn_positions(MAX_POSITION_NUM)


func _process(_delta):
	# TODO maybe i can move this check when an enemy dies
	if $Enemies.get_child_count() < MAX_ENEMY_COUNT:
		spawn_enemy()


func get_enemy_spawn_positions(x):
	var theta = 2 * PI / x
	var vectors = []
	for i in range(x):
		var angle = i * theta
		vectors.append(Vector2(cos(angle), sin(angle)))
	return vectors


func spawn_enemy():
	for pos in enemy_spawn_positions:
		var enemy = enemy_scenes["goomba"].instantiate()
		enemy.connect("death", _on_enemy_death)
		enemy.position = pos * enemy_spawn_positions_max_distance + $Player.position
		$Enemies.add_child(enemy)



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


func _on_enemy_death(item_name, pos):
	var item = item_scenes[item_name].instantiate()
	item.position = pos
	$Items.call_deferred("add_child", item)
