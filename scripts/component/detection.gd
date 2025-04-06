class_name Detection
extends Area2D

signal detected(entity: Node2D)
signal lost(entity: Node2D)

@export var shape: Shape2D


func _ready() -> void:
	$CollisionShape2D.shape = shape


func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		detected.emit(area.entity)


func _on_area_exited(area: Area2D) -> void:
	if area is HurtBox:
		lost.emit(area.entity)
