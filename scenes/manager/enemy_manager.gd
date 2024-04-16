extends Node

# window width is 640, radius is 320, plus a buffer so enemies spawn off screen
const SPAWN_RADIUS = 360
@export var base_enemy_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	# pick a random direction/angle (anywhere from 0 to 360 degrees)
	var rand_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	# enemy's spawn position is 330 pixels away from the enemy in a random direction
	var spawn_position = player.global_position + (rand_direction * SPAWN_RADIUS)
	
	# spawn enemy in Main scene at the position calculated above
	var enemy = base_enemy_scene.instantiate() as Node2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position
