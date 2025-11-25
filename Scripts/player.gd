extends CharacterBody2D

var dir 

func _process(delta: float) -> void:
	
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("UP"):
		dir.y = -1
	if Input.is_action_just_pressed("DOWN"):
		dir.y = 1
	if Input.is_action_just_pressed("RIGHT"):
		dir.x = -1
	if Input.is_action_just_pressed("LEFT"):
		dir.x = 1
	else:
		
