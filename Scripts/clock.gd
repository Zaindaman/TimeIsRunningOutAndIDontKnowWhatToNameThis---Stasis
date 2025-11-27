extends CharacterBody2D

@export var pickup : float
func _ready() -> void:
	$AnimationPlayer.play("Bob")
