extends Node
class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health: float


func _ready():
	current_health = max_health


func take_damage(damage_amt: float):
	# set current_health to whichever of the two #s is higher
	# to prevent health from dropping to below 0
	current_health = max(current_health - damage_amt, 0)
	
	# calls check_death on the next idle frame
	# workaround for: 
	# "Can't change this state while flushing queries... 
	# Use call_deferred() or set_deferred() to change monitoring state instead."
	Callable(check_death).call_deferred()


func check_death():
	if current_health == 0:
		died.emit()
		# remove this node's owner (player/enemy) from the scene
		owner.queue_free()
