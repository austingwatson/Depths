class_name Player
extends Node2D

@onready var movement := $Movement
var rotate_down := false


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("rotate"):
		movement.turn(get_global_mouse_position(), delta)
		
	var direction := Vector2.RIGHT.rotated(rotation)
	if Input.is_action_pressed("thrust"):
		movement.move(direction, delta)
	else:
		movement.stop(direction, delta)
