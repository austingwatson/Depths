extends Node


func _ready() -> void:
	randomize()
	
	var player := preload("res://scenes/entity/actor/player.tscn").instantiate()
	player.global_position = Vector2(0, -50)
	player.rotation_degrees = 90
	EntityManager.add_entity(player, false)
	
	await get_tree().create_timer(0.5).timeout
	player.initial_drop = false
	
	var urchin := preload("res://scenes/entity/actor/urchin.tscn").instantiate()
	urchin.global_position = Vector2(50, 50)
	EntityManager.add_entity(urchin, true)
	
	var floater := preload("res://scenes/entity/actor/floater.tscn").instantiate()
	floater.global_position = Vector2(100, 100)
	EntityManager.add_entity(floater, true)
	
	#var hunter_fish := preload("res://scenes/entity/actor/hunter_fish.tscn").instantiate()
	#hunter_fish.global_position = Vector2(-100, -100)
	#EntityManager.add_entity(hunter_fish, true)
	
	var research_pickup := preload("res://scenes/entity/drops/resource_pickup.tscn").instantiate()
	research_pickup.global_position = Vector2(-50, 100)
	EntityManager.add_entity(research_pickup, true)
