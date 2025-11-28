extends RigidBody2D
var isInversion : bool


func _process(delta: float) -> void:
	if isInversion and GlobalValues.isBulletTime:
		gravity_scale = 0.7
		return
		gravity_scale = 0.7
	if GlobalValues.isBulletTime:
		gravity_scale = 0
		return
