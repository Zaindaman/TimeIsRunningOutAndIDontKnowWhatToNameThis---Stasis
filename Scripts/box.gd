extends RigidBody2D
var isInversion : bool


func _process(delta: float) -> void:
	if isInversion and GlobalValues.isBulletTime:
		gravity_scale = 1
		return
		gravity_scale = 1
	if GlobalValues.isBulletTime:
		gravity_scale = 0
		return


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Reset_zone"):
		queue_free()
