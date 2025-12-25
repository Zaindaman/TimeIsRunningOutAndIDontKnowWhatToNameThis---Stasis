extends RigidBody2D
var isInversion : bool


func _physics_process(delta: float) -> void:
	if isInversion and GlobalValues.isBulletTime:
		gravity_scale = 0.3
		return
	elif GlobalValues.isBulletTime:
		gravity_scale = 0
		linear_velocity = Vector2.ZERO

		return
	else:
		gravity_scale = 0.3


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone"):
		queue_free()
