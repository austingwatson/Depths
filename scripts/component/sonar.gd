class_name Sonar
extends Area2D

@export var max_radius := 0.0
@export var duration := 0.0
@onready var collision_shape: Shape2D = $CollisionShape2D.shape


func start_sonar() -> void:
	var tween := create_tween()
	await tween.tween_property(collision_shape, "radius", max_radius, duration).finished
	collision_shape.radius = 0.0


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.ping()
