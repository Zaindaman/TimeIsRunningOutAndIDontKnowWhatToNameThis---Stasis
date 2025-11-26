extends CharacterBody2D

@export var speed : int = 64
@export var gravity : float = 500

func _physics_process(delta: float) -> void:
	# Base movement direction
	var dir = Vector2(1, 0).rotated(rotation)

	velocity.x = dir.x * speed
	velocity.y = dir.y * speed + gravity * delta

	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone"):
		queue_free()
