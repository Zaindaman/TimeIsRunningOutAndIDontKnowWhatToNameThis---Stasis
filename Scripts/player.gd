extends CharacterBody2D

const SPEED = 96
const GRAVITY = 500
const JUMP_FORCE = -200
var health = 1
var is_on_jumpable

var held_box = null
var box_in_range = null

@export var chapter2 : bool = false
@export var max_time : float
@export var time_remaining : float = 5
@onready var hold_position = %HoldPosition
func _ready() -> void:
	$HourglassUi.set_frame_and_progress(0, 0.0)
	process_mode = Node.PROCESS_MODE_ALWAYS
	self.position = $"../Begin".position
	if chapter2 == false:
		$TextureProgressBar2.visible = false
		$TextureProgressBar2.max_value = max_time
	else:
		$TextureProgressBar2.max_value = max_time
		$TextureProgressBar2.visible = true
func _physics_process(delta: float) -> void:
	if chapter2 and GlobalValues.isBulletTime == true:
		time_remaining -= delta
		$TextureProgressBar2.value = time_remaining
		print(time_remaining)
		if time_remaining == 0:
			GlobalValues.isBulletTime = false
	
	if Input.is_action_just_pressed("Interact"):
		print("justed pressed interact")
		if held_box:
			drop_box()
		elif box_in_range:
			print("box in range and atmpting pickup")
			# Check if box_in_range is still valid before picking up
			if is_instance_valid(box_in_range):
				print("picking up box")
				pickup_box(box_in_range)

	if Input.is_action_just_pressed("Reset"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	var dir = get_input_direction()
	play_animation(dir)
	if Input.is_action_just_pressed("CallBulletTime"):
		if GlobalValues.isBulletTime == true:
			GlobalValues.isBulletTime = false
			$HourglassUi.set_frame_and_progress(0, 0.0)
		else:
			GlobalValues.isBulletTime = true

			$HourglassUi.play("default")
		
	# Horizontal movement
	velocity.x = dir.x * SPEED

	# Apply gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		if Input.is_action_just_pressed("UP"):
			velocity.y = JUMP_FORCE
		
	if held_box:
		if is_instance_valid(held_box):
			held_box.global_position = hold_position.global_position
		else:
			# Box might have been destroyed
			held_box = null
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

func play_animation(dir):
	if dir.x >= 0.5:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk")
		%HoldPosition.position = Vector2(16,0)
	elif dir.x <= -0.5:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk")
		%HoldPosition.position = Vector2(-16,0)
	else: 
		$AnimatedSprite2D.play("stand")

func pickup_box(box_node):
	# Check if we are already holding something or the box is invalid
	if held_box or not is_instance_valid(box_node):
		return
		
	held_box = box_node
	
	# Reparent the box to the player
	var original_parent = held_box.get_parent()
	original_parent.remove_child(held_box)
	self.add_child(held_box)
	
	# Disable the box's physics and collision
	# This assumes the box is a RigidBody2D or CharacterBody2D
	# and has a child node named "CollisionShape2D"
	held_box.set_physics_process(false)
	if held_box.has_node("CollisionShape2D"):
		held_box.get_node("CollisionShape2D").disabled = true
	
	# NEW: If it's a RigidBody2D, disable gravity
	if held_box is RigidBody2D:
		# Store original gravity scale before setting to 0
		held_box.set_meta("original_gravity_scale", held_box.gravity_scale)
		held_box.gravity_scale = 0.0
	
	# Set its position to the hold marker
	held_box.global_position = hold_position.global_position
	
	# We've picked it up, so it's no longer "in range"
	box_in_range = null

# NEW: Function to drop a box
func drop_box():
	if not held_box or not is_instance_valid(held_box):
		return

	# Reparent the box back to the main scene (or its original parent)
	# get_parent() should be the main level node
	var scene_root = get_parent() 
	self.remove_child(held_box)
	scene_root.add_child(held_box)

	# Place it at the hold position
	held_box.global_position = hold_position.global_position

	# Re-enable physics and collision
	held_box.set_physics_process(true)
	if held_box.has_node("CollisionShape2D"):
		held_box.get_node("CollisionShape2D").disabled = false

	# NEW: If it's a RigidBody2D, re-enable gravity
	if held_box is RigidBody2D:
		if held_box.has_meta("original_gravity_scale"):
			held_box.gravity_scale = held_box.get_meta("original_gravity_scale")
			held_box.remove_meta("original_gravity_scale")
		else:
			held_box.gravity_scale = 1.0 # Default fallback

	# Clear the reference
	held_box = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	print("area entered player")
	if area.is_in_group("Reset_zone"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	elif area.is_in_group("end_level"):
		var lvl = LevelManager.get_lvl()
		if lvl >= 10:
			print(lvl)
		GlobalValues.levelNumber.append(int(lvl))
		get_tree().change_scene_to_file("res://Scenes/level_finished.tscn")
	elif area.is_in_group("enemy"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	elif area.is_in_group("enviromental_obi"):
		var lvl = LevelManager.get_lvl()
		LevelManager.change_level(lvl)
	elif area.is_in_group("Pickup"):
		print("picked up",area.get_parent().pickup)
		time_remaining += area.get_parent().pickup
		if time_remaining > $TextureProgressBar2.max_value:
			time_remaining = $TextureProgressBar2.max_value
		$TextureProgressBar2.value = time_remaining
		area.get_parent().queue_free()
	elif area.is_in_group("box"):
		print("box in range")
		# NEW: When a box is nearby, store a reference to it
		# Assumes the Area2D is a child of the box's main node
		if not held_box:
			box_in_range = area.get_parent()
			print(box_in_range)
		


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemybounce"):
		print("bounced")
		velocity.y = JUMP_FORCE + -50
	
	


func _on_laser_damage() -> void:
	var lvl = LevelManager.get_lvl()
	LevelManager.change_level(lvl)


func _on_area_2d_area_exited(area: Area2D) -> void:
	print("area left 2d")
	if area.is_in_group("box"):
		# NEW: If the box leaving is the one we had in range, clear the reference
		if area.get_parent() == box_in_range:
			box_in_range = null


func _on_timer_timeout() -> void:
	pass # Replace with function body.
