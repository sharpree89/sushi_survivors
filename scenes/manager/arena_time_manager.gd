extends Node

# assign a node to a variable when the 
# node is ready
@onready var timer = $Timer


func get_time_elapsed():
	return timer.wait_time - timer.time_left
