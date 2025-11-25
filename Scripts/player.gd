extends CharacterBody2D

const SPEED = 96
const GRAVITY = 500
const JUMP_FORCE = -200

func _physics_process(delta: float) -> void:
	var dir = get_input_direction()

	# Horizontal movement
	velocity.x = dir.x * SPEED

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if Input.is_action_just_pressed("UP"):
			velocity.y = JUMP_FORCE

	move_and_slide()

func get_input_direction() -> Vector2:
	var dir := Vector2.ZERO

	if Input.is_action_pressed("LEFT"):
		dir.x -= 1
	if Input.is_action_pressed("RIGHT"):
		dir.x += 1

	# remove these if this is a platformer
	if Input.is_action_pressed("UP"):
		dir.y -= 1
	if Input.is_action_pressed("DOWN"):
		dir.y += 1

	return dir
