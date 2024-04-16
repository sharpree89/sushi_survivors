extends CanvasLayer

@export var exp_manager: Node
@onready var progress_bar = $MarginContainer/ProgressBar

func _ready():
	progress_bar.value = 0
	# ExpBar is listening for the "exp_updated" signal
	# that is being emitted from ExpManager every time
	# exp is updated.
	exp_manager.exp_updated.connect(on_exp_updated)


func on_exp_updated(current_exp: float, target_exp: float):
	# we set the max value of the progress bar to 1,
	# so that whatever % we get here will display as a normal %
	# example:
	# current (5) / target (10) = 0.5 
	# bar will be filled to 50% because 0.5 is half of 1.
	# if we had left the progress bar's max value at 100,
	# the bar would only be filled to 0.5% which is not accurate.
	var percent = current_exp / target_exp
	progress_bar.value = percent
