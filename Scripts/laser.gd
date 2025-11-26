extends Node2D

@onready var ray = $RayCast2D
@onready var line = $Line2D

func _physics_process(delta):
	ray.force_raycast_update()
	if ray.is_colliding():
		var hit_pos = ray.get_collision_point()
		line.points = [Vector2.ZERO, to_local(hit_pos)]
		var collider = ray.get_collider()
		if collider is Area2D:
			print("Hit Area2D: ", collider.name)
		else:
			print("Hit something else: ", collider)
		
	else:
		line.points = [Vector2.ZERO, ray.target_position]
		
