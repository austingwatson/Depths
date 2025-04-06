class_name PlayerDistance
extends Node

@export var entity: Node2D
@export var distance := 0.0


func _physics_process(_delta: float) -> void:
	var player_pos := get_viewport().get_camera_2d().global_position
	if entity.global_position.distance_to(player_pos) >= distance:
		entity.queue_free()
