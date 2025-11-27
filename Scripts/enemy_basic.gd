extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var speed : int = 64
@export var gravity : float = 500
var bounced 
var isInversion 
func _ready() -> void:
	print("spawned")
func _physics_process(delta: float) -> void:
	# Base movement direction
	var dir
	if isInversion and GlobalValues.isBulletTime:
		if scale == Vector2(-1,1) :
			dir = Vector2(-1, 0).rotated(rotation)
		else: 
			dir = Vector2(1, 0).rotated(rotation)
		
		velocity.x = dir.x * speed
		velocity.y += gravity * delta
		move_and_slide()
		return 
	if scale == Vector2(-1,1) :
		dir = Vector2(-1, 0).rotated(rotation)
	else: 
		dir = Vector2(1, 0).rotated(rotation)
	
	velocity.x = dir.x * speed
	velocity.y += gravity * delta
	if GlobalValues.isBulletTime:
		velocity = Vector2.ZERO
		return
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone") or area.is_in_group("enviromental_obi"):
		queue_free()


func _on_death_detection_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		queue_free()
