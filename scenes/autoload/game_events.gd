# a singleton Node that we added to the project's
# autoload, so it will always be loaded in the game
# unless we manually remove it.
extends Node

signal exp_vial_collected(exp: float)


func emit_exp_vial_collected(exp: float):
	# for our signal to notify anything listening 
	# for it, we need to emit it.
	exp_vial_collected.emit(exp)

# (now go to exp_manager.gd to see what is listening for the signal) 

# ---------------------------------

# 1. In GameEvents we defined a custom signal called "exp_vial_collected", and we also defined a method that emits that signal. 
# Note that we haven't actually called that method yet, so the signal is not being emitted - 
# we just set everything up so that we can emit it later.

# 2. We told ExpManager to listen for the vial signal to be emitted. When it hears the signal, it increments exp points. 
# Again, the vial signal is not yet being emitted!

# 3. ExpVial is listening for a separate signal, "area_entered". It's in that signal's handler that we finally emit the vial signal, 
# which kicks off the code to increment exp points and remove the vial from the scene.
