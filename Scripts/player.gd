extends CharacterBody2D

const SPEED = 96
const GRAVITY = 500
const JUMP_FORCE = -200

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	self.position = $"../Begin".position
func _physics_process(delta: float) -> void:
	var dir = get_input_direction()
	if Input.is_action_just_pressed("CallBulletTime"):
		if GlobalValues.isBulletTime == true:
			GlobalValues.isBulletTime = false
			$Label.text = "Bullet time NOT ACTIVE"
		else:
			GlobalValues.isBulletTime = true
			$Label.text = "Bullet time ACTIVE"
		
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


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone"):
		self.position = $"../Begin".position
	elif area.is_in_group("end_level"):
		var lvl = LevelManager.get_lvl()
		GlobalValues.levelNumber.append(int(lvl))
		get_tree().change_scene_to_file("res://Scenes/level_finished.tscn")
