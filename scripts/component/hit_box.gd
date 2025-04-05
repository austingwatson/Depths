class_name HitBox
extends Area2D

signal hit

@export var damage: int
@export var shape: Shape2D
@onready var collision_shape := $CollisionShape2D


func _ready() -> void:
	collision_shape.shape = shape


func enable() -> void:
	collision_shape.set_deferred("disabled", false)
	

func disable() -> void:
	collision_shape.set_deferred("disabled", true)


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		area.take_damage(damage)
		hit.emit()
