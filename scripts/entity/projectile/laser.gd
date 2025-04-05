class_name Laser
extends Node2D

@export var distance: float
@onready var line := $Line2D
@onready var ray_cast := $RayCast2D


func _ready() -> void:
	line.points[1] = Vector2(distance, 0.0)
	ray_cast.target_position = Vector2(distance, 0.0)


func fire(global_position: Vector2, direction: Vector2) -> void:
	#rotation = self.global_position.direction_to(direction).angle()
	#ray_cast.target_position = direction
	#ray_cast.target_position = direction * distance
	ray_cast.force_raycast_update()
	if ray_cast.is_colliding():
		print(ray_cast.get_collider())
