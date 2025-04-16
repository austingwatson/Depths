extends Node


func _ready() -> void:
	var player := preload("res://scenes/entity/actor/player.tscn").instantiate()
	player.rotation_degrees = 90
	EntityManager.add_entity(player, false)
	player.initial_drop = false
	
	#var hunter_fish := preload("res://scenes/entity/actor/hunter_fish.tscn").instantiate()
	#hunter_fish.global_position = Vector2(100, 300)
	#EntityManager.add_entity(hunter_fish, true)
	
	var big_floater := preload("res://scenes/entity/actor/big_floater.tscn").instantiate()
	big_floater.global_position = Vector2(100, 100)
	EntityManager.add_entity(big_floater, true)
