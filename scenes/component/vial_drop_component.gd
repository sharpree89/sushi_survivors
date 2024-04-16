# when an enemy dies, it should drop a vial
extends Node

@export_range(0, 1) var drop_chance: float = 0.5
@export var health_component: Node
@export var vial_scene: PackedScene


func _ready():
	# listen for "died" signal emitted from HealthComponent
	(health_component as HealthComponent).died.connect(on_died)


func on_died():
	if vial_scene == null:
		return
	
	if not owner is Node2D:
		return
		
	# Generate a random float between 0 and 1
	var random_value = randf_range(0, 1)
	
	# Compare the random value directly with the drop chance
	if random_value > drop_chance:
		return # don't drop a vial
	else:
		var vial_instance = vial_scene.instantiate() as Node2D
		
		# owner = enemy
		# parent of owner = Main scene
		# add child = add vial to Main scene
		if owner != null:
			owner.get_parent().add_child(vial_instance)
		
			# put the vial at the enemy's position
			var spawn_position = (owner as Node2D).global_position
			vial_instance.global_position = spawn_position
		else:
			print("couldn't find owner!")
			return

