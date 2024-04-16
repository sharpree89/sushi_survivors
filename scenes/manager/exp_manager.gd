extends Node

signal exp_updated(current_exp: float, target_exp: float)

# rate at which target_exp should increase with each level
const TARGET_EXP_GROWTH = 5
var current_exp = 0
var target_exp = 5
var current_level = 1


func _ready():
	# this line makes the ExpManager listen
	# for the exp_vial_collected signal from GameEvents,
	# and calls a method handler when it hears the signal.

	# ExpManager is what handles incrementing
	# exp, so it makes sense that it would be listening for
	# the signal, so it knows WHEN to increment exp. 
	GameEvents.exp_vial_collected.connect(on_exp_vial_collected)


func increment_exp(exp: float):
	# ensure current_exp doesn't ever exceed target_exp
	current_exp = min(current_exp + exp, target_exp)
	
	exp_updated.emit(current_exp, target_exp)
	
	if (current_exp == target_exp):
		# increment level & raise target_exp for new level
		current_level += 1
		target_exp += TARGET_EXP_GROWTH
		
		# reset exp to 0
		current_exp = 0
		
		exp_updated.emit(current_exp, target_exp)


# signal handlers should just do one thing
func on_exp_vial_collected(exp: float):
	# when this node hears the signal that a vial was collected,
	# it should increment the player's exp.
	increment_exp(exp)
	
# (now go to exp_vial.gd to see where the signal is emitted from)
