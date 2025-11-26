extends Node

var enemy = preload("res://Scenes/enemy_basic.tscn")
@export var TimeBetweenSpawn : float
func _process(delta: float) -> void:
	$timer.start(TimeBetweenSpawn)
	
func _on_timer_timeout():
	var instance = enemy.instantiate()
