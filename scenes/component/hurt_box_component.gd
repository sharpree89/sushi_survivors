extends Area2D
class_name HurtBoxComponent

@export var health_component: Node


func _ready():
	area_entered.connect(on_area_entered)


func on_area_entered(other_area: Area2D):
	if not other_area is HitBoxComponent:
		return
	
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitBoxComponent
	
	# damage lifecycle: 
	# sword ability controller -> sword ability's hitbox -> hurtbox
	health_component.take_damage(hitbox_component.damage)
