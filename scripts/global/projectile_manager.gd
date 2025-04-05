extends Node

const torpedo_scene := preload("res://scenes/entity/projectile/torpedo.tscn")
@export_flags_2d_physics var friendly_layer: int
@export_flags_2d_physics var friendly_mask: int

func add_friendly_torpedo(global_position: Vector2, target_position: Vector2, damage: int) -> void:
	var torpedo := torpedo_scene.instantiate()
	add_child(torpedo)
	torpedo.init(global_position, target_position, friendly_layer, friendly_mask, damage)
