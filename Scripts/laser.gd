extends Node2D

@onready var ray: RayCast2D = $RayCast2D
@onready var line: Line2D = $Line2D

signal opendoor
signal closedoor
signal damage
signal enemydamage

var was_colliding: bool = false
var last_collider: Node2D = null

func _physics_process(delta: float) -> void:
	ray.force_raycast_update()
	var is_colliding: bool = ray.is_colliding()

	if is_colliding:
		var hit_pos: Vector2 = ray.get_collision_point()
		line.points = [Vector2.ZERO, to_local(hit_pos)]
		var collider: Node2D = ray.get_collider()

		# react on change
		if not was_colliding or collider != last_collider:
			if collider.is_in_group("activator"):
				emit_signal("opendoor")
			else:
				emit_signal("closedoor")

			if collider.is_in_group("player"):
				emit_signal("damage")

			if collider.is_in_group("enemy_laser"):
				emit_signal("enemydamage")

		last_collider = collider

	else:
		line.points = [Vector2.ZERO, ray.target_position]

		# Collision just ended
		if was_colliding:
			emit_signal("closedoor")
			last_collider = null

	was_colliding = is_colliding
