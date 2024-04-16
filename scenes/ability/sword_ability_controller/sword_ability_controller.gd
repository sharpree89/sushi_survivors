# responsible for spawning the sword ability in combat
extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene
var damage: float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	# $Timer is a shortcut for get_node("Timer")
	$Timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# this method gets called every 1.5 seconds
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies = enemies.filter(func(enemy: Node2D): 
		# only return enemies that are at least 150 pixels away from the player
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if enemies.size() == 0:
		return
	
	# sort enemies by distance to player
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	# create a new sword instance
	var sword_instance = sword_ability.instantiate() as SwordAbility

	# add the sword to the main scene
	player.get_parent().add_child(sword_instance)
	
	# assign sword's damage
	sword_instance.hitbox_component.damage = damage
	
	var closest_enemy = enemies[0] as Node2D
	
	# position the sword on top of the closest enemy
	sword_instance.global_position = closest_enemy.global_position
	
	# spawn the sword anywhere along a circle with a radius of 4 around the enemy's position
	# before, we were spawning the sword right on top of the enemy, and since the sword only attacks
	# directly to the right, it would sometimes miss hitting the enemy
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	# angle the sword towards the enemy
	var enemy_direction = closest_enemy.global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
