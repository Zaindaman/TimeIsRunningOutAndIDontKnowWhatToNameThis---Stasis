extends Node2D

var enemy = preload("res://Scenes/box.tscn")
@export var TimeBetweenSpawn : float
var isInversion
func _ready() -> void:
	$Timer.start(TimeBetweenSpawn)


func _process(_delta: float) -> void:
	if GlobalValues.isBulletTime:
		$"Timer".paused = true
		return
	elif isInversion:
		$"Timer".paused = false
	else:
		$"Timer".paused = false
func _on_timer_timeout():
	var instance = enemy.instantiate()
	get_parent().add_child(instance)
	instance.global_position = global_position
	if rotation != 0:
		instance.inverted = true
	$"Timer".start(TimeBetweenSpawn)
