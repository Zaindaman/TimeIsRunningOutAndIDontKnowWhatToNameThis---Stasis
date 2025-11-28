extends Node2D
var doorclosed = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_laser_closedoor() -> void:
	$AnimatedSprite2D.play("Close")
	$CollisionShape2D.disabled = false
	


func _on_laser_opendoor() -> void:
	$AnimatedSprite2D.play("Open")
	$CollisionShape2D.disabled = true

func _on_laser_invertclosedoor() -> void:
	$AnimatedSprite2D.play("Open")
	$CollisionShape2D.disabled = true
	


func _on_laser_invertopendoor() -> void:
	$AnimatedSprite2D.play("Close")
	$CollisionShape2D.disabled = false
