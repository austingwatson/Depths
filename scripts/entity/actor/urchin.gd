class_name Urchin
extends Node2D


func _on_hurt_box_dead() -> void:
	queue_free()
