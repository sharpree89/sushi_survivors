extends CharacterBody2D

const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var movement_vector = get_movement_vector()
	var direction = movement_vector.normalized()
	
	# set velocity to 200 pixels/second in current direction
	var target_velocity = direction * MAX_SPEED
	
	# lerp = linear interporate
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-delta * ACCELERATION_SMOOTHING))
	
	# moves player based on current velocity
	move_and_slide()
	
	
func get_movement_vector():
	# x_movement is one of 3 possibilities:
	# 	move right: 10 - 0 = +10
	# 	move left: 0 - 10 = -10
	#	no movement: 0 - 0 = 0
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	# y_movement is one of 3 possibilities:
	# 	move down: 10 - 0 = +10
	# 	move up: 0 - 10 = -10
	#	no movement: 0 - 0 = 0
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	return Vector2(x_movement, y_movement)
