extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# this line makes the ExpVial listen
	# for the global area_entered signal,
	# and calls a method handler when it hears the signal.
	$Area2D.area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	# when player enters the vial's area, emit the signal
	# that ExpManager is listening for, so it knows 
	# when to increase exp.

	# since this is where the signal is actually emitted,
	# this is also where we pass in the # of points to
	# increment exp by.
	GameEvents.emit_exp_vial_collected(1)
	queue_free()
