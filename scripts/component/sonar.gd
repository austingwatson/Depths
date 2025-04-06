class_name Sonar
extends Area2D

@export var max_radius := 0.0
@export var duration := 0.0
@onready var collision_shape := $CollisionShape2D
@onready var shape: Shape2D = collision_shape.shape


func start_sonar() -> void:
	collision_shape.set_deferred("disabled", false)
	var tween := create_tween()
	await tween.tween_property(shape, "radius", max_radius, duration).finished
	shape.radius = 0.0
	collision_shape.set_deferred("disabled", true)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.ping()
