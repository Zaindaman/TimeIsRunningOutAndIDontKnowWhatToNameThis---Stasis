extends CharacterBody2D

@export var speed: float = 100
@export var move_distance: float = 200

var start_position: Vector2
var direction := 1
var isInversion
func _ready():
	start_position = global_position

func _physics_process(_delta):
	# Move enemy horizontally
	if isInversion and GlobalValues.isBulletTime:
		velocity.x = speed * direction
		move_and_slide()
		if abs(global_position.x - start_position.x) >= move_distance:
			direction *= -1
		return
	velocity.x = speed * direction
	if GlobalValues.isBulletTime:
		velocity = Vector2.ZERO
		return
	move_and_slide()

	# Turn around when reaching distance limit
	if abs(global_position.x - start_position.x) >= move_distance:
		direction *= -1
