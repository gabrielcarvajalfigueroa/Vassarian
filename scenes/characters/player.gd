extends CharacterBody2D  # Para Godot 4

const walkAcceleration = 5  # Aceleración al caminar
const runAcceleration = 10  # Aceleración al correr
const deceleration = 20  # Desaceleración cuando no se presiona nada
const walkSpeed = 80  # Velocidad máxima al caminar
const runSpeed = 200  # Velocidad máxima al correr
const jumpHeight = -500
const gravity = 15

@onready var sprite = $Sprite2D
@onready var animationPlayer = $AnimationPlayer  

var is_jumping = false  # Controla si el personaje está en el aire
var is_crouching = false  # Controla si el personaje está agachado

func _physics_process(_delta):
	# Aplicar gravedad
	velocity.y += gravity

	var move_direction = 0  # Dirección del movimiento (izquierda/derecha)
	var is_running = false  # Saber si el jugador está corriendo

	# **AGACHARSE (Crouch con flecha hacia abajo)**
	if Input.is_action_pressed("ui_down") and is_on_floor():
		animationPlayer.play("Crouch")  # Activa la animación de agachado
		velocity.x = 0  # Detiene el movimiento horizontal
		is_crouching = true
	else:
		is_crouching = false

	# **Solo moverse si NO está agachado**
	if not is_crouching:
		# **CAMINAR (A y D)**
		if Input.is_action_pressed("move_left_walk"):  # Tecla A
			sprite.flip_h = true
			move_direction = -1  # Mueve a la izquierda
			velocity.x += move_direction * walkAcceleration
			velocity.x = clamp(velocity.x, -walkSpeed, walkSpeed)  # Limitar a walkSpeed
			if is_on_floor() and not is_jumping:
				animationPlayer.play("Walk")  # Solo camina si está en el suelo

		elif Input.is_action_pressed("move_right_walk"):  # Tecla D
			sprite.flip_h = false
			move_direction = 1  # Mueve a la derecha
			velocity.x += move_direction * walkAcceleration
			velocity.x = clamp(velocity.x, -walkSpeed, walkSpeed)
			if is_on_floor() and not is_jumping:
				animationPlayer.play("Walk")

		# **CORRER (← y →)**
		elif Input.is_action_pressed("move_left_run"):  # Flecha Izquierda
			sprite.flip_h = true
			move_direction = -1
			velocity.x += move_direction * runAcceleration
			velocity.x = clamp(velocity.x, -runSpeed, runSpeed)  # Limitar a runSpeed
			is_running = true
			if is_on_floor() and not is_jumping:
				animationPlayer.play("Run")  # Activa Run de inmediato

		elif Input.is_action_pressed("move_right_run"):  # Flecha Derecha
			sprite.flip_h = false
			move_direction = 1
			velocity.x += move_direction * runAcceleration
			velocity.x = clamp(velocity.x, -runSpeed, runSpeed)
			is_running = true
			if is_on_floor() and not is_jumping:
				animationPlayer.play("Run")

	# Si no se presiona nada y no está agachado, desacelerar
	if move_direction == 0 and not is_crouching:
		velocity.x = lerp(velocity.x, 0.0, 0.1)  # Aplica fricción suave
		if is_on_floor() and not is_jumping:
			animationPlayer.play("Idle")  # Solo cambia a Idle si está en el suelo

	# **Salto solo si está en el suelo y NO está agachado**
	if is_on_floor() and not is_crouching:
		if Input.is_action_just_pressed("ui_accept"):  # Espacio para saltar
			animationPlayer.play("Jump")  # Reproduce la animación UNA VEZ
			velocity.y = jumpHeight  # Aplica salto
			is_jumping = true  # Marca que el personaje está en el aire

	# **Si está en el aire, mantiene la animación de "Jump"**
	if not is_on_floor():
		animationPlayer.play("Jump")  # Mantiene la animación de salto

	# **Si toca el suelo, reseteamos la variable de salto**
	if is_on_floor() and is_jumping:
		is_jumping = false  # Ya no está saltando

	move_and_slide()  # Aplica el movimiento
