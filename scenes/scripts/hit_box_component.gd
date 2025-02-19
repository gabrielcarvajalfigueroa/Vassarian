extends Area2D
class_name HitboxComponent

@export var damage: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	area_entered.connect(hit)


func hit(area):
	if area is HealthComponent:
		area.take_damage(damage)
