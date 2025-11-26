extends CharacterBody2D
var centerpos
var SPEED = 50
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centerpos = global_position.x + 85
	velocity = direction*SPEED
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.x > centerpos:
		velocity.x -= 12
	if global_position.x < centerpos:
		velocity.x += 12
	move_and_slide()
