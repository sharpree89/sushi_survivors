extends CharacterBody2D

const MAX_SPEED = 40

@onready var health_component: HealthComponent = $HealthComponent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_direction_to_player()
	
	# set velocity to 75 pixels/second in current direction
	velocity = direction * MAX_SPEED
	
	# moves entity based on current velocity
	move_and_slide()


func get_direction_to_player():
	# get Player node
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO

