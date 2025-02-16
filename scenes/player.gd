extends CharacterBody2D  # Para Godot 4

const moveSpeed = 25
const maxSpeed = 50
const jumpHeight = -400
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer  

func _physics_process(_delta):
	# Aplicar gravedad
	velocity.y += gravity

	# Movimiento horizontal
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)

	elif Input.is_action_pressed("ui_left"):
		sprite.flip_h = true
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)

	else:
		animationPlayer.play("Idle")
		velocity.x = lerp(velocity.x, 0.0, 0.2)  # Aplica fricción suave

	# Salto solo si está en el suelo
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y = jumpHeight  # Aplica salto

	move_and_slide()  # Aplica el movimiento
