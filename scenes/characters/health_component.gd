extends Area2D
class_name HealthComponent

signal onDead
signal onDamageTook
signal onHealthChanged(health:int)

@export var max_health: int = 3
