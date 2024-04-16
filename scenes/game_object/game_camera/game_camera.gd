extends Camera2D

const CAMERA_SMOOTHING = 20

var target_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	# game can have many cameras, so this tells 
	# godot that this is the current camera
	make_current()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	acquire_target()
	# lerp = linear interporate
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * CAMERA_SMOOTHING))


func acquire_target():
	# get all nodes in "player" group
	var player_nodes = get_tree().get_nodes_in_group("player")
	if player_nodes.size() > 0:
		# get the first player node
		var player = player_nodes[0] as Node2D
		# follow the player
		# the below line works, but it doesn't have "camera smoothing"
		# global_position = player.global_position
		target_position = player.global_position
