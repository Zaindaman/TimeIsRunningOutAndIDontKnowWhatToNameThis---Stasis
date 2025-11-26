extends CharacterBody2D
var centerpos
var SPEED = 50
var direction = Vector2.ZERO
var rotationrate : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	centerpos = global_position.x + 85
	velocity = direction*SPEED
	rotationrate = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !GlobalValues.isBulletTime:
		if global_position.x > centerpos:
			velocity.x -= 12
		if global_position.x < centerpos:
			velocity.x += 12
		if rotationrate <10:
			rotationrate+= 0.2
		
		$Boomerang.rotation_degrees += rotationrate
		
		move_and_slide()
	
