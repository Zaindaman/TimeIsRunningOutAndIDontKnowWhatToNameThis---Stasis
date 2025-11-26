extends CharacterBody2D
var gravity = 500


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	if GlobalValues.isBulletTime:
		velocity = Vector2.ZERO
		return
	move_and_slide()
