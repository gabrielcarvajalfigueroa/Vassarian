extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum PlayerState {
	IDLE,  # Jugador está en reposo
	RUNNING,  # Jugador está corriendo
	JUMPING,  # Jugador está saltando
	ATTACKING,  # Jugador está atacando
}

var state : PlayerState = PlayerState.IDLE  # El estado inicial del jugador es reposo

func _physics_process(delta: float) -> void:
	if state == PlayerState.ATTACKING and $AnimatedSprite2D.is_playing():
		print(PlayerState.ATTACKING)
		return
		
	# Añadir gravedad si el jugador no está en el suelo
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Verificar si el jugador está en el suelo o en el aire
	if is_on_floor():
		# Estado de reposo o corriendo
		handle_grounded_state()
	else:
		# Estado de salto o caída
		handle_airborne_state()

	# Aplicar el movimiento al jugador
	move_and_slide()

# Maneja los estados cuando el jugador está en el suelo
func handle_grounded_state():
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_just_pressed("ui_accept"):  # Si el jugador presiona "salto"
		velocity.y = JUMP_VELOCITY
		change_state(PlayerState.JUMPING)
	elif Input.is_action_just_pressed("attack") and state != PlayerState.ATTACKING:  # Si el jugador presiona "ataque"
		change_state(PlayerState.ATTACKING)
	elif direction != 0:  # Si hay entrada de dirección, el jugador se mueve
		velocity.x = direction * SPEED
		change_state(PlayerState.RUNNING)
	else:  # Si no hay entrada de dirección
		velocity.x = move_toward(velocity.x, 0, SPEED)
		change_state(PlayerState.IDLE)

# Maneja los estados cuando el jugador está en el aire
func handle_airborne_state():
	var direction = Input.get_axis("ui_left", "ui_right")
	# Aquí solo se juega la animación de salto mientras está en el aire
	if velocity.y < 0:
		change_state(PlayerState.JUMPING)  # Jugador está saltando
	else:
		change_state(PlayerState.JUMPING)  # Jugador está cayendo
		
	if direction != 0:  # Si hay entrada de dirección, el jugador se mueve
		velocity.x = direction * SPEED		
	else:  # Si no hay entrada de dirección
		velocity.x = move_toward(velocity.x, 0, SPEED)

# Cambia el estado del jugador y maneja la animación correspondiente
func change_state(new_state: PlayerState):
	if state != new_state:
		state = new_state
		update_animation()

# Actualiza la animación del jugador basado en su estado
func update_animation():
	match state:
		PlayerState.IDLE:
			$AnimatedSprite2D.play("idle")
		PlayerState.RUNNING:
			$AnimatedSprite2D.play("run")
			$AnimatedSprite2D.flip_h = velocity.x < 0  # Cambia la dirección del sprite
		PlayerState.JUMPING:
			$AnimatedSprite2D.play("jump")
			$AnimatedSprite2D.flip_h = velocity.x < 0  # Cambia la dirección del sprite
		PlayerState.ATTACKING:
			$AnimatedSprite2D.play("attack")
