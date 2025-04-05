class_name HitBox
extends Area2D

signal hit

@export var damage: int
@onready var collision_shape := $CollisionShape2D


func enable() -> void:
	collision_shape.set_deferred("disabled", false)
	

func disable() -> void:
	collision_shape.set_deferred("disabled", true)


func _on_area_entered(area: Area2D) -> void:
	if area is HitBox:
		area.take_damage(area.damage)
		hit.emit()
