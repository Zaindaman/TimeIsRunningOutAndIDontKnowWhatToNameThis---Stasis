extends CharacterBody2D

const SPEED = 96
const GRAVITY = 500
const JUMP_FORCE = -200
var health = 1
var is_on_jumpable

@export var chapter2 : bool = false
@export var max_time : float
@export var time_remaining : float = 5
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	self.position = $"../Begin".position
	if chapter2:
		$TextureProgressBar2.visible = false
		$TextureProgressBar2.max_value = max_time
func _physics_process(delta: float) -> void:
	if chapter2 and GlobalValues.isBulletTime == true:
		time_remaining -= delta
		$TextureProgressBar2.value = time_remaining
		if time_remaining == 0:
			GlobalValues.isBulletTime = false
			$Label.text = "Bullet time NOT ACTIVE"

	if Input.is_action_just_pressed("Reset"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
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
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	elif area.is_in_group("end_level"):
		var lvl = LevelManager.get_lvl()
		GlobalValues.levelNumber.append(int(lvl))
		get_tree().change_scene_to_file("res://Scenes/level_finished.tscn")
	elif area.is_in_group("enemy"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	elif area.is_in_group("enviromental_obi"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemybounce"):
		print("bounced")
		velocity.y = JUMP_FORCE + -100
	elif body.is_in_group("pickup"):
		time_remaining += body.pickup
	


func _on_laser_damage() -> void:
	var lvl = LevelManager.get_lvl()
	LevelManager.change_level(lvl)
