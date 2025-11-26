extends CharacterBody2D

@export var speed : int = 64
@export var gravity : float = 500
var bounced 
func _physics_process(delta: float) -> void:
	# Base movement direction
	var dir
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
