class_name Player
extends CharacterBody2D

@onready var character_movement := $CharacterMovement


func _unhandled_input(_event: InputEvent) -> void:
	character_movement.set_direction(Input.get_vector("move_left", "move_right", "move_up", "move_down"))
	look_at(get_global_mouse_position())
