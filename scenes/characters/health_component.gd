extends Area2D
class_name HealthComponent

signal onDead
signal onDamageTook
signal onHealthChanged(health: int)

@export var max_health: int = 3
var current_health: int = 0
var old_health: int

func _ready() -> void:
	current_health = max_health

func take_heal(value: int):
	set_health(value)

func take_damage(damage: int):
	var value = abs(damage)
	set_health(-value)

func set_health(value: int):
	old_health = current_health
	current_health += value
	current_health = clamp(current_health, 0, max_health)

	if old_health != current_health:
		onHealthChanged.emit(current_health)  # For GUI Listeners

	# Check first for Dead Event.
	if current_health <= 0:
		dead()
		return  # Makes sure to avoid call onDamage Event if the character should die.

	# Second Check for the Damaged Event.
	elif current_health >= 0 and current_health < old_health:
		onDamageTook.emit()  # On Damage Behaviour is coded outside and called by a signal.

func dead():
	onDead.emit()  # Dead Behaviour is coded outside and called by a signal.
