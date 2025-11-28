extends Node2D

var enemy = preload("res://Scenes/enemy_basic.tscn")
@export var TimeBetweenSpawn : float
var isInversion
@export var invert = true
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
	print('telling the bot', invert)
	instance.inverted = invert
	$"Timer".start(TimeBetweenSpawn)
