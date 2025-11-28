extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var collision_shape_2d2: CollisionShape2D = $"Death detection/CollisionShape2D"
@onready var collision_shape_2d3: CollisionPolygon2D = $CollisionShape2D

@export var speed : int = 64
@export var gravity : float = 500

var bounced

var _is_inversion := false

@export var isInversion: bool:
	get:
		return _is_inversion
	set(value):
		_is_inversion = value
		print("is inverted changed to: ", value)

@export var inverted = false

func _ready() -> void:
	await get_tree().process_frame
	print(inverted)
	if inverted == true:
		print("inverted enemy")
		rotation = deg_to_rad(180)
		animated_sprite_2d.flip_v = true
		collision_shape_2d.rotation = deg_to_rad(180)
		collision_shape_2d2.rotation = deg_to_rad(180)
		collision_shape_2d2.position = Vector2(0,17.5)
		collision_shape_2d3.rotation = deg_to_rad(180)
		collision_shape_2d3.position = Vector2(0,-8)
	print("spawned")
	
	
func _physics_process(delta: float) -> void:
	# Base movement direction
	var dir

	if GlobalValues.isBulletTime:
		# Bullet Time is ON
		if isInversion:
			# --- This is the Inverted logic ---
			# The enemy is in bullet time AND inverted, so it moves
			print("inversion time ")
			if scale == Vector2(-1,1) :
				dir = Vector2(-1, 0).rotated(rotation)
			else: 
				dir = Vector2(1, 0).rotated(rotation)
			
			velocity.x = dir.x * speed
			velocity.y += gravity * delta
			move_and_slide()
			return # Exit the function
		else:
			# --- This is the Freeze logic ---
			# The enemy is in bullet time but NOT inverted, so it freezes
			velocity = Vector2.ZERO
			# We don't call move_and_slide(), so it just stops
			return # Exit the function

	# --- This is the Normal logic ---
	# This code will only run if GlobalValues.isBulletTime is FALSE
	if scale == Vector2(-1,1) :
		dir = Vector2(-1, 0).rotated(rotation)
	else: 
		dir = Vector2(1, 0).rotated(rotation)
	
	velocity.x = dir.x * speed
	velocity.y += gravity * delta
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone") or area.is_in_group("enviromental_obi"):
		queue_free()


func _on_death_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		queue_free()


func _on_laser_enemydamage() -> void:
	queue_free()
