class_name HunterFish
extends Node2D


func _on_hurt_box_dead() -> void:
	queue_free()
