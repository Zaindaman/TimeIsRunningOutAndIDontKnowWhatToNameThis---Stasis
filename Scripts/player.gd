extends CharacterBody2D

const SPEED = 96


func _physics_process(delta: float) -> void:
	var dir = get_input_direction()
	velocity = dir * SPEED * delta 

func get_input_direction() -> Vector2:
	var dir := Vector2.ZERO
	if Input.is_action_pressed("UP"): 
		dir.y -= 1
		print("UP")
	if Input.is_action_pressed("DOWN"): 
		dir.y += 1
		print("DOWNwda")
	if Input.is_action_pressed("LEFT"): 
		dir.x -= 1
		print("LEFT")
	if Input.is_action_pressed("RIGHT"): 
		dir.x += 1
		print("RIGHT")
	return dir
