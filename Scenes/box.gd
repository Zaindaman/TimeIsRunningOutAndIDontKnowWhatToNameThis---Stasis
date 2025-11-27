extends CharacterBody2D
var gravity = 500
var isInversion : bool

func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if isInversion and GlobalValues.isBulletTime:
		if not is_on_floor():
			velocity.y += gravity * delta
		move_and_slide()
		return
	if not is_on_floor():
		velocity.y += gravity * delta
	if GlobalValues.isBulletTime:
		velocity = Vector2.ZERO
		return
	move_and_slide()
