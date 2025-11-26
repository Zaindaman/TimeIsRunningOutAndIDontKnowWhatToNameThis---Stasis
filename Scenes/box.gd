extends CharacterBody2D
var gravity = 500


func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
