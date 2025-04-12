extends Node


func _ready() -> void:
	var player := preload("res://scenes/entity/actor/player.tscn").instantiate()
	player.rotation_degrees = 90
	EntityManager.add_entity(player, false)
	player.initial_drop = false
	
	var hunter_fish := preload("res://scenes/entity/actor/hunter_fish.tscn").instantiate()
	hunter_fish.global_position = Vector2(100, 100)
	EntityManager.add_entity(hunter_fish, true)
